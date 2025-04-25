import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabarak_tv/widgets/center_view/commodities/commodities_rate.dart';
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
      backgroundColor: kCprimary,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(kbg),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
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
                          child: Container(
                            // color: Colors.orangeAccent,
                            child: TopBar(),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Container(
                            // color: Colors.deepPurpleAccent,
                            child: LiveRate(),
                          ),
                        ),
                        // CommoditiesRate.buildFooter
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // color: const Color.fromARGB(255, 9, 255, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(80, 80, 80, 0),
                            child: Container(
                              height: 300, 
                              // color: Colors.blueAccent,
                            
                            ),
                          ),
                          CommoditiesList(),
                        ],
                      ),
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
      ),
    );
  }
}
