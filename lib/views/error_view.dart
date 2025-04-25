import 'package:flutter/material.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_texts.dart';


class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              kerror,
              height: 300,
            ),
            Text(
              kdeviceError,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
