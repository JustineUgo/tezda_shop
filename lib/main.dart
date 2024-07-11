import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tezda_shop/injection/injection.dart';
import 'package:tezda_shop/routes/router.dart';
import 'package:tezda_shop/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white, statusBarIconBrightness: Brightness.dark));
  final sharedPreferences = await SharedPreferences.getInstance();
  configureDependencies(sharedPreferences);
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
    return Container(
      color: Colors.grey.shade200,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: TezdaTheme.themeData,
            routerConfig: routerConfig,
          ),
        ),
      ),
    );
  }
}
