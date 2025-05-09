import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/utils/app_assets.dart';
import 'date_time_display.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20,top: 10),
            child: Image.asset(
              klogo,
              height: 8.w,
            ),
          ),
          DateTimeDisplay(),
          // WorldClockDisplay()
        ],
      ),
    );
  }
}
