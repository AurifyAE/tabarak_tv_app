import 'package:flutter/material.dart';

import 'error_view.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 800) {
      return HomeScreen();
    } else {
      return ErrorView();
    }
  }
}
 