import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServiceModule {

  @singleton
  Dio get dioClient => Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/', connectTimeout: const Duration(seconds: 20)));

}
