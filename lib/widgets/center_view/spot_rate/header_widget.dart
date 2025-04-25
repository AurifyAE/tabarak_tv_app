import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CommodityHeader extends StatelessWidget {
  final String commodityName;
  final Widget commodityImage;
  final Color baseColor;
  final Color textColor;
  
  const CommodityHeader({
    Key? key,
    required this.commodityName,
    required this.commodityImage,
    required this.baseColor,
    required this.textColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.w,
      color: baseColor,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 5.w,
            child: commodityImage,
          ),
         SizedBox(height: 1.w),
          Text(
            commodityName,
            style: TextStyle(
              fontSize: 12.sp, 
               fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
} 