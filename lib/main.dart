import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/bindings/initial_binding.dart';
// import 'package:pulparambil_gold/app/routes/route_management.dart';
// import 'package:pulparambil_gold/app/core/utils/app_texts.dart';
import 'package:sizer/sizer.dart';

import 'bindings/initial_binding.dart';
import 'core/utils/app_texts.dart';
import 'routes/route_management.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          title: kappName,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          initialBinding: InitialBinding(),
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}