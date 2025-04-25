import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:tabarak_tv/widgets/center_view/commodities/commodities_rate.dart';
import 'package:tabarak_tv/widgets/center_view/image_slider.dart';
import 'package:tabarak_tv/widgets/center_view/spot_rate/live_rate.dart';

import '../core/utils/app_assets.dart';
import '../core/utils/app_colors.dart';
import '../widgets/bottom_news/bottom_news.dart';
import '../widgets/center_view/center_view.dart';
import '../widgets/left_bar/top_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCaccent,
      body: Column(
        children: [
          Expanded(
            flex: 8,
            child: Row( 
              children: [
                Expanded(
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TopBar(),
                      ),
                      Expanded(
                        flex: 4,
                        child: LiveRate(),
                      ),
                      Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              // color: const Color(0xFF3C4226), // Dark green footer
              child: Center(
                child: Text(
                  'Powered by www.aurify.ae',
                  style: TextStyle( 
                    color: Colors.white,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
                      // CommoditiesRate.buildFooter
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(80, 80, 80, 0),
                        child: ImageSlider()
                      ),
                      CommoditiesList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // color: Colors.redAccent,
              child: BottomNews(),
            ),
          ),
        ],
      ),
    );
  }
}
