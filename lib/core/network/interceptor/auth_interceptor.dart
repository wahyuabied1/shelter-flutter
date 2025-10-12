import 'package:flutter/services.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:shelter_super_app/app/env_define.dart';
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/event_bus/event_bus.dart';
import 'package:shelter_super_app/core/event_bus/http_unauthorized_event.dart';
import 'package:shelter_super_app/core/network/http/http_inspector.dart';
import 'package:shelter_super_app/core/network/repository/core_http_repository.dart';
import 'package:shelter_super_app/data/repository/auth_repository.dart';
import 'package:synchronized/synchronized.dart';

extension on BaseRequest {
  void authorize(String token, {bool force = false}) {
    if (token.isNotEmpty) {
      if (force) {
        headers['Authorization'] = 'Bearer $token';
      } else {
        headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
    }
  }
}

class AuthInterceptor extends InterceptorContract {
  late final CoreHttpRepository _coreHttpRepository = serviceLocator();
  late final AuthRepository _authRepository = serviceLocator();
  late final EventBus _networkEventBus = serviceLocator();
  late final HttpInspector? _inspector = kEnableDevOps ? serviceLocator() : null;

  final _shouldIgnore401 = {
    '/realms/amartha/protocol/openid-connect/token',
  };

  final _lock = Lock();

  AuthInterceptor();

  Future<BaseResponse> _autoLogout(
    BaseResponse response,
  ) async {
    _networkEventBus.fire(HttpUnauthorizedEvent(
      response.request,
      response.statusCode,
    ));
    return response;
  }

  Future<bool> _refreshTokenWithSynchronize(
    String oldToken,
  ) async {
    return await _lock.synchronized<bool>(() async {
      final token = await _coreHttpRepository.getToken();
      if (oldToken == token) {
        // refresh token later
        final newUser = await _authRepository.refreshToken();
        await _authRepository.saveSession(user: newUser.data);
      }
      return true;
    });
  }

  Future<BaseResponse> _retryWithRefreshToken(
    BaseResponse response,
  ) async {
    try {
      final requestOrigin = response.request?.copyWith();

      final token = await _coreHttpRepository.getToken();
      final hasNewToken = await _refreshTokenWithSynchronize(token);
      if (hasNewToken && requestOrigin != null) {
        final newToken = await _coreHttpRepository.getToken();
        final request = requestOrigin..authorize(newToken, force: true);

        await _logging(response, request);

        final streamResponse = await request.send();
        final httpResponse = await Response.fromStream(streamResponse);

        // Still 401 after refresh
        if (httpResponse.statusCode == 401) {
          await _autoLogout(httpResponse);
        }

        return httpResponse;
      } else {
        // Not got new token
        await _autoLogout(response);
      }
    } on PlatformException catch (e) {
      if (e.message?.contains('invalid_grant') == true) {
        await _autoLogout(response);
      }
    }
    return response;
  }

  Future<void> _logging(
    BaseResponse originalResponse,
    BaseRequest newRequest,
  ) async {
    try {
      if (_inspector == null) {
        return;
      }

      /// set response for original request and put new request object instead
      /// open HttpInspector.interceptResponse to see how it works
      await _inspector.interceptResponse(response: originalResponse);
      await _inspector.interceptRequest(request: newRequest);
    } catch (e) {
      // ignore any exception during logging
    }
  }

  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    final token = await _coreHttpRepository.getToken();
    if (token.isNotEmpty) {
      return request..authorize(token);
    }
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({
    required BaseResponse response,
  }) async {
    // stop interceptor if user is not logged in
    // if not stopped, a logged out application may suddenly logged in again
    // because access token is renewed by refresh token
    final isLogin = await _authRepository.isLoggedIn();
    if (!isLogin) {
      return response;
    }

    switch (response.statusCode) {
      case 401:
        if (_shouldIgnore401.contains(response.request?.url.path)) {
          return response;
        }
        return await _retryWithRefreshToken(response);
      case 403:
        return await _autoLogout(response);
    }
    return response;
  }

  Future<Map<String, String>> getAuthorizationHeader(
      {required Map<String, String> headers}) async {
    final Map<String, String> allHeaders = Map.from(headers);
    final tokenFuture = _coreHttpRepository.getToken().then((token) =>
        allHeaders.putIfAbsent('Authorization', () => 'Bearer $token'));
    await Future.wait([tokenFuture]);
    return allHeaders;
  }
}
