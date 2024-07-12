// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:image_picker/image_picker.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i9;
import 'package:tezda_shop/injection/module/service_module.dart' as _i13;
import 'package:tezda_shop/routes/router.dart' as _i3;
import 'package:tezda_shop/src/repositories/auth_repo.dart' as _i11;
import 'package:tezda_shop/src/repositories/product_repo.dart' as _i12;
import 'package:tezda_shop/src/services/image_service.dart' as _i7;
import 'package:tezda_shop/src/services/network_service.dart' as _i10;
import 'package:tezda_shop/src/services/storage_service.dart' as _i8;
import 'package:tezda_shop/src/services/ui_service.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final serviceModule = _$ServiceModule();
    gh.singleton<_i3.TezdaRouter>(() => serviceModule.router);
    gh.singleton<_i4.Dio>(() => serviceModule.dioClient);
    gh.singleton<_i5.ImagePicker>(() => serviceModule.getImage);
    gh.singleton<_i6.UIService>(() => _i6.UIService());
    gh.singleton<_i7.EcoImageService>(
        () => _i7.EcoImageService(gh<_i5.ImagePicker>()));
    gh.singleton<_i8.StorageService>(
        () => _i8.SharedPreferenceService(gh<_i9.SharedPreferences>()));
    gh.singleton<_i10.NetworkService>(() => _i10.DioClient(
          gh<_i8.StorageService>(),
          gh<_i6.UIService>(),
          gh<_i4.Dio>(),
        ));
    gh.singleton<_i11.AuthRepo>(() => _i11.AuthRepoImpl(
          gh<_i10.NetworkService>(),
          storage: gh<_i8.StorageService>(),
        ));
    gh.singleton<_i12.ProductRepo>(
        () => _i12.ProductRepoImpl(request: gh<_i10.NetworkService>()));
    return this;
  }
}

class _$ServiceModule extends _i13.ServiceModule {}
