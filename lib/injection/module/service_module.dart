import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tezda_shop/routes/router.dart';

@module
abstract class ServiceModule {
  @singleton
  TezdaRouter get router => TezdaRouter();

  @singleton
  Dio get dioClient => Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/', connectTimeout: const Duration(seconds: 20)));
}
