import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/date_time_controller.dart';

class DateTimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateTimeController>(
      builder: (controller) {
        return Container(
          // color: const Color(0xFF3A432E), // Dark green background from image
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(
            child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.formattedTime.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  controller.formattedDate.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            )),
          ),
        );
      },
    );
  }
}