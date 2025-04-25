import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_clock/one_clock.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/date_time_controller.dart';

class WorldClockDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DateTimeController>(
      init: DateTimeController(),
      builder: (controller) {
        return SizedBox(
          width: 30.w,
          height: 20.w,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildClock(controller.indiaTime, 'India', constraints),
                  _buildClock(controller.londonTime, 'London', constraints),
                  _buildClock(controller.newYorkTime, 'New York', constraints),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildClock(Rx<DateTime> time, String location, BoxConstraints constraints) {
    double clockSize = constraints.maxWidth > 600 ? 8.w : 8.w; 
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: clockSize,
          height: clockSize,
          child: Obx(() => AnalogClock(
                datetime: time.value,
                isLive: true,
                hourHandColor: Colors.black,
                minuteHandColor: Colors.black,
                secondHandColor: Colors.red,
                numberColor: Colors.black,
                showDigitalClock: true,
                decoration: BoxDecoration(
                  border: Border.all(width: 1.2, color: Colors.black),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              )),
        ),
        SizedBox(height: 0.3.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.6.h),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37),
            borderRadius: BorderRadius.circular(1.w),
          ),
          child: Text(
            location,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
