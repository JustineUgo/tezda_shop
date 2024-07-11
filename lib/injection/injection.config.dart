// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;
import 'package:tezda_shop/injection/module/service_module.dart' as _i8;
import 'package:tezda_shop/routes/router.dart' as _i3;
import 'package:tezda_shop/src/services/storage_service.dart' as _i6;
import 'package:tezda_shop/src/services/ui_service.dart' as _i5;

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
    gh.singleton<_i5.UIService>(() => _i5.UIService());
    gh.singleton<_i6.StorageService>(
        () => _i6.SharedPreferenceService(gh<_i7.SharedPreferences>()));
    return this;
  }
}

class _$ServiceModule extends _i8.ServiceModule {}
