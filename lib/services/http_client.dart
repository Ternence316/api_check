import 'package:dio/dio.dart';

class HttpClient {
  HttpClient._();
  static final HttpClient I = HttpClient._();

  late final Dio dio = Dio(BaseOptions(
    baseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: ''),
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 20),
    headers: { 'Content-Type': 'application/json' },
  ))
    ..interceptors.addAll([
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // TODO: attach token if needed
          return handler.next(options);
        },
        onError: (e, handler) {
          // Simple error mapping
          final msg = _mapError(e);
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: msg,
              type: e.type,
              response: e.response,
            ),
          );
        },
      ),
    ]);

  String _mapError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) return '连接超时';
    if (e.type == DioExceptionType.receiveTimeout) return '接收超时';
    if (e.type == DioExceptionType.sendTimeout) return '发送超时';
    if (e.type == DioExceptionType.badResponse) return '服务器错误';
    if (e.type == DioExceptionType.connectionError) return '网络连接错误';
    return '请求失败';
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? query,
    Options? options,
  }) async {
    return dio.get<T>(path, queryParameters: query, options: options);
  }

  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    return dio.post<T>(path, data: data, options: options);
  }
}

