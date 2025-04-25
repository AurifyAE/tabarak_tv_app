import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/controllers/news_controller.dart';

import '../../controllers/news_controller.dart';
import 'news_tickerbar.dart';

class BottomNews extends StatelessWidget {
  const BottomNews({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 50,
        child: Obx(() {
          if (newsController.isLoading.value) {
            return const NewsTickerBar(
              height: 50,
            );
          }
      
          if (newsController.errorMessage.value.isNotEmpty ||
              newsController.newsList.isEmpty) {
            return const NewsTickerBar(
              height: 50,
            );
          }
      
          return const NewsTickerBar(
            height: 50,
          );
        }),
      ),
    );
  }
}
