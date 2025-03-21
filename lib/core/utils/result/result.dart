import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:shelter_super_app/core/network/response/api_response.dart';
import 'package:shelter_super_app/core/network/response/json_list_response.dart';
import 'package:shelter_super_app/core/network/response/json_response.dart';
import 'package:shelter_super_app/core/network/response/response_extensions.dart';
import 'package:shelter_super_app/core/utils/common.dart';
import 'package:shelter_super_app/core/utils/result/result_exceptions.dart';

/// Utility class to describe a loading, error and
/// success state of a method call
///
/// It's almost the same with Result class in Kotlin
///
/// Usage
/// ```dart
/// Result<String> _someResult = Result.initial();
///
/// Result.call<Strng>(
///     future: fetchSomething(),
///     onResult: (result) {
///         _someResult = result;
///        notifyListener();
///     }
/// )
///
/// See [ResultBuilder] and [ResultSelectorBuilder] on how to use it
/// ```
sealed class Result<T> with EquatableMixin {
  const Result._();

  const factory Result.initial() = Initial<T>;

  const factory Result.loading() = Loading<T>;

  const factory Result.success(T value) = Success<T>;

  const factory Result.error(dynamic error, [StackTrace? stackTrace]) =
      ResultError<T>;

  /// Transform result to another type
  Result<R> map<R>(R Function(T data) transform) {
    switch (this) {
      case Initial<T>():
        return Initial<R>();
      case Loading<T>():
        return Loading<R>();
      case ResultError<T>():
        return Result.error(error, trace);
      case Success<T>():
        return Result.success(transform((this as Success).data));
    }
  }

  /// Used to call API that return [JsonResponse] or [JsonListResponse]
  ///
  /// Will throw exception if ApiResponse not success
  static Future<bool> callApi<T>({
    required Future<ApiResponse> future,
    required Function(Result<T> result) onResult,
    int retryTimes = 0,
    bool returnData = true,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    Future<T> internalCall() async {
      final result = await future;
      if (result.isSuccess) {
        if (result is JsonResponse<T>) {
          return result.data as T;
        } else if (result is JsonListResponse<T>) {
          return result.data as T;
        } else {
          // Plain ApiResponse
          return result as T;
        }
      } else {
        throw ApiResultException(result.statMsg ?? 'API Error', result);
      }
    }

    return call<T>(
      future: internalCall(),
      onResult: onResult,
      retryTimes: retryTimes,
      onError: onError,
      onSuccess: onSuccess,
    );
  }

  /// Call any future
  static Future<bool> call<T>({
    required Future<T> future,
    required Function(Result<T> result) onResult,
    int retryTimes = 0,
    Function(T data)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    try {
      await retry(retryTimes, () async {
        onResult.call(const Result.loading());
        final response = await future;
        onResult.call(Result.success(response));
        onSuccess?.call(response);
      });
      return Future.value(true);
    } catch (e, s) {
      debugPrint(e.toString());
      onResult.call(Result<T>.error(e, s));
      onError?.call(e);
      if (e is! ApiResultException) {
        // unawaited(FirebaseCrashlytics.instance.recordError(e, s));
      }
      return Future.value(false);
    }
  }
}

class Initial<T> extends Result<T> {
  const Initial() : super._();

  @override
  List<Object?> get props => const [];
}

class Loading<T> extends Result<T> {
  const Loading() : super._();

  @override
  List<Object?> get props => const [];
}

class ResultError<T> extends Result<T> {
  const ResultError(
    this.error, [
    this.stackTrace,
  ]) : super._();

  final dynamic error;
  final StackTrace? stackTrace;

  void rethrowError() {
    if (error is Error) {
      Error.throwWithStackTrace(error, stackTrace ?? StackTrace.current);
    } else {
      throw error;
    }
  }

  @override
  List<Object?> get props => [error, stackTrace];
}

class Success<T> extends Result<T> {
  const Success(this.data) : super._();

  final T data;

  @override
  List<Object?> get props => [data];
}

// coverage:ignore-start
/// A wrapper class for [Result] that save last success value
/// Usage
///
/// ```dart
/// ResultState<String> _someResult = ResultState("Initial");
///
/// Result.call<String>(
///     future: fetchSomething(),
///     onResult: (result) {
///         _someResult.setResult(result);
///        notifyListener();
///     },
/// )
///
/// Consuming
///
/// _someResult.activeResult // current active result
/// _someResult.lastResult // last success result
/// ```
class ResultState<T> with EquatableMixin {
  @Deprecated('use [lastResult] and [activeResult] instead')
  Result<T> result = const Result.initial();

  /// Should automaticcaly use last data if error occur
  @Deprecated('use [lastResult] and [activeResult] instead')
  bool useLastDataOnError;

  /// Contain last success data,
  /// will not be changed if new result is error or loading
  Result<T> lastResult = const Result.initial();

  /// Contain current active result
  Result<T> activeResult = const Result.initial();

  /// Cached last success data
  T? get lastData => lastResult.dataOrNull;

  ResultState({this.useLastDataOnError = false, T? initialValue}) {
    if (initialValue != null) {
      activeResult = Result.success(initialValue);
      lastResult = Result.success(initialValue);

      result = Result.success(initialValue);
    }
  }

  /// Set internal [Result] for this wrapper class
  SetResultInfo setResult(Result<T> newResult) {
    // New implementation
    bool lastResultChanged = false;
    activeResult = newResult;
    if (lastResult is! Success || newResult is Success) {
      lastResult = newResult;
      lastResultChanged = true;
    }

    // Old implementation
    result = newResult;
    if (newResult is ResultError && useLastDataOnError) {
      restorePrevious();
    }

    return (lastResultChanged: lastResultChanged,);
  }

  /// Reset to initial state
  void reset([T? initalValue]) {
    if (initalValue != null) {
      activeResult = Result.success(initalValue);
      lastResult = Result.success(initalValue);
    } else {
      activeResult = const Result.initial();
      lastResult = const Result.initial();
    }
  }

  /// Restore previously success data
  @Deprecated('use [lastResult] and [activeResult] instead')
  void restorePrevious() {
    final data = lastData;
    if (data != null) {
      result = Result.success(data);
    }
  }

  @override
  List<Object?> get props =>
      [result, lastResult, activeResult, useLastDataOnError];
}

typedef SetResultInfo = ({
  bool lastResultChanged,
});
// coverage:ignore-end

extension ResultExt<T> on Result<T> {
  bool get isLoading => this is Loading;

  bool get isSuccess => this is Success;

  bool get isError => this is ResultError;

  bool get isInitial => this is Initial;

  bool get isInitialOrLoading => this is Initial || this is Loading;

  @Deprecated(
    '''
    avoid this API that performs unsafe cast.
    use [dataOrNull] as alternative
    ''',
  )
  T get data => (this as Success).data;

  T? get dataOrNull => this is Success ? (this as Success<T>).data : null;

  dynamic get error => (this as ResultError).error;

  StackTrace? get trace => (this as ResultError).stackTrace;

  void rethrowError() {
    (this as ResultError).rethrowError();
  }
}
