import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/controllers/news_controller.dart';
// import 'package:pulparambil_gold/app/core/utils/app_texts.dart';

import '../../controllers/news_controller.dart';
import '../../core/utils/app_texts.dart';
import 'ticker_widget.dart';

class NewsTickerBar extends StatelessWidget {
  final double height;

  const NewsTickerBar({
    super.key,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find<NewsController>();

    return Obx(() {
      List<String> headlines = [];

      if (newsController.isLoading.value) {
        headlines = [knewsLoading];
      } else if (newsController.errorMessage.value.isNotEmpty) {
        headlines = [knewsLoading];
      } else if (newsController.newsList.isEmpty) {
        headlines = [knewsLoading];
      } else {
        headlines = newsController.newsList.map((news) => news.title).toList();
      }

      final String combinedHeadlines = headlines.join('          •          ');

      return TickerWidget(
        combinedHeadlines: combinedHeadlines,
        height: height,
      );
    });
  }
}
