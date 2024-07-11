import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tezda_shop/errors/exceptions.dart';
import 'package:tezda_shop/src/services/storage_service.dart';
import 'package:tezda_shop/src/services/ui_service.dart';

enum NetworkMethod { post, get, delete, put, patch }

abstract class NetworkService {
  Future<dynamic> makeRequest(String path, {required NetworkMethod mode, Map<String, dynamic>? body});
}

@Singleton(as: NetworkService)
class DioClient implements NetworkService {
  final StorageService storageService;
  final UIService uiService;
  final Dio client;
  DioClient(this.storageService, this.uiService, this.client) {
    client.interceptors.add(NetworkInterceptor(storageService: storageService, uiService: uiService));
  }

  @override
  Future<dynamic> makeRequest(String path, {required NetworkMethod mode, Map<String, dynamic>? body}) async {
    late Response response;
    switch (mode) {
      case NetworkMethod.post:
        response = await client.post(path, data: body);
        break;
      case NetworkMethod.get:
        response = await client.get(path);
        break;
      case NetworkMethod.put:
        response = await client.put(path, data: body);
        break;
      case NetworkMethod.patch:
        response = await client.patch(path, data: body);
        break;
      case NetworkMethod.delete:
        response = await client.delete(path, data: body);
        break;
      default:
        throw (UnknownException(exception: 'Unknown request', stacktrace: StackTrace.current));
    }

    return response.data;
  }
}

class NetworkInterceptor extends Interceptor {
  final StorageService storageService;
  final UIService uiService;
  NetworkInterceptor({required this.storageService, required this.uiService});

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await storageService.retrieve(key: StorageService.userAccessTokenKey);
    if (token != null) options.headers.addAll({'Authorization': 'Bearer $token'});
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    switch (err.type) {
      case DioExceptionType.cancel:
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        uiService.showToast(type: ToastType.error, text: 'No internet network');
        throw ConnectionException(statusCode: err.response?.statusCode ?? 0, cause: err.type);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 401:
            unauthenticatedAction(err);
          case 400:
          case 403:
          case 404:
          case 409:
          case 429:
          case 406:
          case 422:
            uiService.showToast(type: ToastType.error, text: err.response?.data["error"]);
            throw UserException(error: err.response?.data["error"], statusCode: err.response?.statusCode ?? 0);
        }
        if (err.response?.data == null) {
          uiService.showToast(type: ToastType.error, text: 'An unexpected error occurred. Please try again later.');
        } else {
          uiService.showToast(type: ToastType.error, text: err.response?.data["error"]);
        }

        throw UnknownException(exception: err.error, stacktrace: err.stackTrace);

      default:
        if (err.error is HandshakeException || err.error is SocketException || err.error is TimeoutException) {
          uiService.showToast(type: ToastType.error, text: err.response?.data["error"]);
          throw ConnectionException(statusCode: err.response?.statusCode ?? 0, cause: err.type);
        } else {
          if (err.response?.data == null) {
            uiService.showToast(type: ToastType.error, text: 'An unexpected error occurred. Please try again later.');
          } else {
            uiService.showToast(type: ToastType.error, text: err.response?.data["error"]);
          }
          throw UnknownException(exception: err, stacktrace: err.stackTrace);
        }
    }
  }

  void unauthenticatedAction(DioException err) {
    // TODO: unauthenticate user
    // getIt<TezdaRouter>().replaceAll([const OnboardingRoute()]);
    throw UserException(error: err.response?.data, statusCode: err.response?.statusCode ?? 0);
  }

}
