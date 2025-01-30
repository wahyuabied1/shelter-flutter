import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shelter_super_app/core/dependency_injection/service_locator.dart';
import 'package:shelter_super_app/core/network/interceptor/auth_interceptor.dart';

class CoreHttpClient {
  final Future<Uri> _uri;
  final Map<String, String> _additionalHeaders;
  final http.Client Function() _httpClient;
  final _authInterceptor = serviceLocator.get<AuthInterceptor>();

  CoreHttpClient(
    this._uri,
    this._additionalHeaders,
    this._httpClient,
  );

  Future<http.Response> post<T extends Object>([T? body]) async {
    var client = _httpClient();
    var uri = await _uri;

    try {

      var response = await client.post(
        uri,
        headers: _additionalHeaders,
        body: jsonEncode(body),
      );
      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> get<T extends Object>() async {
    var client = _httpClient();
    var uri = await _uri;
    try {
      var response = await client.get(uri, headers: _additionalHeaders);
      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> put<T>([T? body]) async {
    var client = _httpClient();
    var uri = await _uri;
    try {
      var response = await client.put(
        uri,
        headers: _additionalHeaders,
        body: jsonEncode(body),
      );
      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> patch<T extends Object>([T? body]) async {
    var client = _httpClient();
    var uri = await _uri;
    try {
      var response = await client.patch(
        uri,
        headers: _additionalHeaders,
        body: jsonEncode(body),
      );
      return response;
    } finally {
      client.close();
    }
  }

  Future<http.Response> delete<T extends Object>([T? body]) async {
    var client = _httpClient();
    var uri = await _uri;
    try {
      var response = await client.delete(
        uri,
        headers: _additionalHeaders,
        body: jsonEncode(body),
      );

      return response;
    } finally {
      client.close();
    }
  }

  Future<http.StreamedResponse> postMultipart({
    Map<String, String> fields = const {},
    List<http.MultipartFile> files = const [],
  }) async {
    var uri = await _uri;
    try {
      var allHeaders = await _authInterceptor.getAuthorizationHeader(
          headers: _additionalHeaders);
      final multipartRequest = http.MultipartRequest('POST', uri)
        ..headers.addAll(allHeaders)
        ..headers[HttpHeaders.contentTypeHeader] = 'multipart/form-data'
        ..fields.addAll(fields)
        ..files.addAll(files);
      var response = await multipartRequest.send();
      return response;
    } finally {
    }
  }
}
