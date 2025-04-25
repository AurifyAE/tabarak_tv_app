import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sizer/sizer.dart';

class LoadingPriceBox extends StatelessWidget {
  final Color borderColor;
  
  const LoadingPriceBox({
    Key? key,
    required this.borderColor,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 0.5.w, horizontal: 3.w), 
        padding:  EdgeInsets.symmetric(vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 2),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 1),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          child: Container(
            height: 24,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingPreviousPrice extends StatelessWidget {
  const LoadingPreviousPrice({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(seconds: 1),
      color: Colors.white,
      colorOpacity: 0.3,
      enabled: true,
      child: Container(
        height: 20,
        width: 70,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}