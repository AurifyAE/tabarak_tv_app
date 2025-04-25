import 'package:get/get.dart';

import '../bindings/initial_binding.dart';
import '../bindings/splash_binding.dart';
import '../views/home_screen.dart';
import '../views/main_screen.dart';
import '../views/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String home = '/home';
  static const String main = '/main';
  static const String test = '/test';

  static final pages = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
      binding: SplashBinding()
    ),
    GetPage(
      name: home,
      page: () => HomeScreen(),
      bindings: [
        InitialBinding()
      ]
    ),
    GetPage(
      name: main,
      page: () => MainScreen(),
      bindings: [
        InitialBinding()
      ]
    ),


  ];
}
