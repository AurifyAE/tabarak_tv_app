import 'package:flutter/material.dart';
// import 'package:pulparambil_gold/app/core/utils/app_colors.dart';
// import 'package:pulparambil_gold/app/core/utils/app_textstyles.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_textstyles.dart';

class GoldValueShimmerCard extends StatelessWidget {
  final String title;

  const GoldValueShimmerCard({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: kSstitle
          ),
          const SizedBox(height: 10),
          Shimmer(
            duration: Duration(seconds: 3),
            interval: Duration(seconds: 5),
            color: kCprimary,
            colorOpacity: 0.3,
            enabled: true,
            direction: ShimmerDirection.fromLTRB(),
            child: Container(
              width: 100,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
