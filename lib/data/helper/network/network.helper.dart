import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:technical_test/data/helper/network/url_list_service.helper.dart';

class NetworkHelper {
  final Dio _client = Dio(
    BaseOptions(
      baseUrl: UrlListService.baseUrl,
      receiveTimeout: 10000,
      sendTimeout: 10000,
      contentType: Headers.formUrlEncodedContentType,
    ),
  );

  Future<T> get<T>({
    required String path,
    required T Function(dynamic data) onSuccess,
    required T Function(dynamic error) onError,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isRawResult = false,
    String? customBaseUrl,
    bool isCustomUrl = true,
  }) async {
    final Dio _client = Dio(
      BaseOptions(
        baseUrl: UrlListService.baseUrl,
        connectTimeout: 10000,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    try {
      final response = await _client.get(
        path,
        options: Options(headers: headers),
        queryParameters: queryParameters,
      );
      return onSuccess(response.data);
    } on DioError catch (e) {
      return onError(e);
    }
  }

  Future<Object?> post<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
    bool isResultCode = false,
  }) async {
    try {
      _client.interceptors.add(LogInterceptor());
      final response = await _client.post(
        path!,
        data: containsFile ? FormData.fromMap(body!) : body,
        options: Options(
          headers: headers,
          contentType: Headers.jsonContentType,
        ),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data);
    } on DioError catch (e) {
      print('${e.message} for $path');

      return isResultCode ? onError!(e.response?.statusCode) : onError!(e.response?.data);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }

  Future<T> put<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    @required Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
    bool containsFile = false,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.put(
        path!,
        data: containsFile ? FormData.fromMap(body!) : body,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data['content']);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }

  Future<T> delete<T>({
    @required String? path,
    @required T Function(dynamic content)? onSuccess,
    @required T Function(dynamic error)? onError,
    Map<String, dynamic>? headers,
    bool isRawResult = false,
  }) async {
    try {
      final response = await _client.delete(
        path!,
        options: Options(headers: headers),
      );

      return isRawResult ? onSuccess!(response.data) : onSuccess!(response.data['content']);
    } on DioError catch (e) {
      print('${e.message} for ${UrlListService.baseUrl}$path');
      return onError!(e);
    } catch (e) {
      print(e.toString());
      return onError!(e);
    }
  }
}
