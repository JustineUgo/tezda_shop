import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tezda_shop/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies(SharedPreferences sharedPreferences) {
  getIt.registerSingleton(sharedPreferences);
  getIt.init();
}
