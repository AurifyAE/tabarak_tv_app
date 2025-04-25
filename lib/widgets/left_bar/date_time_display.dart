import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
// import 'package:sizer/sizer.dart';

import '../../controllers/date_time_controller.dart';

class DateTimeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateTimeController>(
      builder: (controller) {
        return Center(
          child: Obx(() => Text(
                controller.formattedTime.value,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.sp, 
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        );
      },
    );
  }
}