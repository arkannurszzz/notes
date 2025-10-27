import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:notes/core/services/env_services.dart';
import 'package:notes/domain/model/reponse_login_api.dart';

class DioServices extends GetxService {
  late Dio _dio;

  Dio get dio => _dio;

  Future<DioServices> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvServices.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add authorization token if needed
          // final token = Get.find<AuthService>().token;
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }

          print('Request [${options.method}] => ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print(
            'Response [${response.statusCode}] => ${response.requestOptions.uri}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          print(
            'Error [${error.response?.statusCode}] => ${error.requestOptions.uri}',
          );
          _handleError(error);
          return handler.next(error);
        },
      ),
    );

    // Add logging interceptor in debug mode
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        logPrint: (obj) => print(obj),
      ),
    );

    return this;
  }

  void _handleError(DioException error) {
    String errorMessage = '';

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timeout';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request cancelled';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Certificate verification failed';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'An unexpected error occurred';
        break;
    }

    print('Dio Error: $errorMessage');
  }

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 503:
        return 'Service unavailable';
      default:
        return 'Something went wrong';
    }
  }

  // Helper methods for common HTTP operations
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<ReponseLoginApi> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final response = await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    final api = ReponseLoginApi.fromJson(response.data ?? {});
    api.code = response.statusCode;
    return api;
  }

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.delete(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    return await _dio.patch(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}
