import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/routes/router.dart';
import 'package:tezda_shop/theme/theme.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  final sharedPreferences = await SharedPreferences.getInstance();
  configureDependencies(sharedPreferences);
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  var routerConfig = getIt<TezdaRouter>().config();

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: TezdaTheme.themeData,
        routerConfig: routerConfig,
      ),
    );
  }
}
