import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

import '../../controllers/news_controller.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/app_texts.dart';
import '../../core/utils/app_textstyles.dart';

class NewsTickerBar extends StatelessWidget {
  final double height;
  final bool showDebugInfo;

  const NewsTickerBar({
    super.key,
    this.height = 50.0,
    this.showDebugInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find<NewsController>();

    return Column(
      children: [
        Obx(() {
          String tickerText;
          
          if (newsController.isLoading.value) {
            tickerText = knewsLoading;
          } else if (newsController.errorMessage.value.isNotEmpty) {
            tickerText = "Error: ${newsController.errorMessage.value}";
          } else if (newsController.newsList.isEmpty) {
            tickerText = "TABAREK NEWS          TABAREK NEWS          TABAREK NEWS";
          } else {
            // Debug the actual news list
            print("News list has ${newsController.newsList.length} items");
            for (var news in newsController.newsList) {
              print("News item: ${news.title}");
            }
            
            tickerText = newsController.newsList.map((news) => news.title).join('          •          ');
          }
          
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kCaccent1,
            ),
            height: height,
            child: Row(
              children: [
                // Left side - PULPARAMBIL NEWS
                _buildTitleSection(),
                // Right side - Scrolling news
                _buildMarqueeSection(tickerText),
                // Debug button
                showDebugInfo ? IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => newsController.fetchNews(),
                ) : const SizedBox.shrink(),
              ],
            ),
          );
        }),
        
        // Debug information panel
        if (showDebugInfo)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: newsController.buildDebugInfo(),
          ),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Container(
      width: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: kCaccent2, // Gold color
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        knewsbar,
        style: kSnewsBar,
      ),
    );
  }

  Widget _buildMarqueeSection(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Marquee(
          text: text,
          style: kSnewsHedline,
          scrollAxis: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.center,
          blankSpace: 150.0,
          velocity: 50.0,
          pauseAfterRound: const Duration(seconds: 1),
          startPadding: 10.0,
          accelerationDuration: const Duration(seconds: 1),
          accelerationCurve: Curves.linear,
          decelerationDuration: const Duration(milliseconds: 500),
          decelerationCurve: Curves.easeOut,
        ),
      ),
    );
  }
}

// Updated BottomNews widget with debug option
class BottomNews extends StatelessWidget {
  final bool showDebugInfo;
  
  const BottomNews({
    super.key,
    this.showDebugInfo = false,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the NewsController if not already done
    Get.put(NewsController());

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: showDebugInfo ? null : 50,
        child: NewsTickerBar(
          height: 50,
          showDebugInfo: showDebugInfo,
        ),
      ),
    );
  }
}