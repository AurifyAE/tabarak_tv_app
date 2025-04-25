import 'package:flutter/material.dart';
// import 'package:pulparambil_gold/app/core/utils/app_colors.dart';
// import 'package:pulparambil_gold/app/core/utils/app_textstyles.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_textstyles.dart';

class GoldValueCard extends StatelessWidget {
  final String title;
  final String value;

  const GoldValueCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCprimary,
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: kCaccent,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 0.2.w),
            decoration:  BoxDecoration(
              color: kCaccent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(2.w), 
                topRight: Radius.circular(2.w), 
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: kSgoldtitle,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: kSgoldvalue,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
