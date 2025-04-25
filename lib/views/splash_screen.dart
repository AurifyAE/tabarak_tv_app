import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';
import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCsecondary,
      body: Center(
        child: Image.asset(klogo, height: 400),
      ),
    );
  }
}