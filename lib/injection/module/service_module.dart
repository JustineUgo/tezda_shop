import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:tezda_shop/routes/router.dart';
import 'package:image_picker/image_picker.dart';

@module
abstract class ServiceModule {
  @singleton
  TezdaRouter get router => TezdaRouter();

  @singleton
  Dio get dioClient => Dio(BaseOptions(baseUrl: 'https://api.escuelajs.co/api/v1/', connectTimeout: const Duration(seconds: 20)));

  @singleton
  ImagePicker get getImage => ImagePicker();
}
