import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/news_controller.dart';
import 'news_tickerbar.dart';

class BottomNews extends StatelessWidget {
  const BottomNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the NewsController if not already done
    Get.put(NewsController());

    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        child: NewsTickerBar(
          showDebugInfo: false,
          height: 50,
        ),
      ),
    );
  }
}