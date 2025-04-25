import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../models/price_change_state.dart';
import 'price_animation_controller.dart';

class FlashingPriceBox extends StatelessWidget {
  final double currentPrice;
  final Color borderColor;
  final String commodityName;
  final String priceType;

  const FlashingPriceBox({
    Key? key,
    required this.currentPrice,
    required this.borderColor,
    required this.commodityName,
    required this.priceType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = PriceAnimationController(
      commodityName: commodityName,
      priceType: priceType,
    );

    animationController.updatePrice(currentPrice);

    return Obx(() {
      PriceChangeState state = animationController.currentState;
      Color bgColor = Colors.white;

      if (state == PriceChangeState.increase) {
        bgColor = Colors.green;
      } else if (state == PriceChangeState.decrease) {
        bgColor = Colors.red;
      }

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(vertical: 0.5.w, horizontal: 3.w), 
        padding:  EdgeInsets.symmetric(vertical: 1),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            currentPrice.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: borderColor,
            ),
          ),
        ),
      );
    });
  }
}

class PreviousPriceIndicator extends StatelessWidget {
  final double previousPrice;
  final bool isHigherPrice;

  const PreviousPriceIndicator({
    Key? key,
    required this.previousPrice,
    required this.isHigherPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          isHigherPrice ? Icons.arrow_upward : Icons.arrow_downward,
          color: isHigherPrice ? Colors.green : Colors.red,
          size: 2.w,
        ), 
        const SizedBox(width: 4),
        Text(
          previousPrice.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
