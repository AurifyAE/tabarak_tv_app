import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/conectivity_controller.dart';
import '../core/utils/app_assets.dart';
import '../core/utils/app_texts.dart';
import '../core/utils/app_textstyles.dart';

class NoInternetView extends StatelessWidget {
  final ConnectivityController controller = Get.find<ConnectivityController>();

  NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            knointernet,
            height: 250,
          ),
          SizedBox(height: 16),
          Text(
            kconnectionError,
            style: kSconnectionError,
          ),
        ],
      ),
    );
  }
}
