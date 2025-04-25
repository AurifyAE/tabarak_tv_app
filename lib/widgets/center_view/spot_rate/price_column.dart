import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'flashing_price_box.dart';
import 'loading_price_box.dart';
// import 'package:pulparambil_gold/app/widgets/live_rate_card/flashing_price_box.dart';
// import 'package:pulparambil_gold/app/widgets/live_rate_card/loading_price_box.dart';

class PriceColumn extends StatelessWidget {
  final String title;
  final String commodityName;
  final double currentPrice;
  final double previousPrice;
  final Color titleColor;
  final bool isHigh;
  final bool isLoading;
  
  const PriceColumn({
    Key? key,
    required this.title,
    required this.commodityName,
    required this.currentPrice,
    required this.previousPrice,
    required this.titleColor,
    required this.isHigh,
    required this.isLoading,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Title (BID/ASK) - Always visible
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: titleColor,
            ),
          ),
        ),
        
        // Current price in box - Shimmer when loading, Flash animation when value changes
        isLoading
          ? LoadingPriceBox(borderColor: titleColor)
          : FlashingPriceBox(
              currentPrice: currentPrice,
              borderColor: titleColor,
              commodityName: commodityName,
              priceType: title,
            ),
        
        // Previous price with arrow indicator - Shimmer when loading
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: isLoading
            ? const LoadingPreviousPrice()
            : PreviousPriceIndicator(
                previousPrice: previousPrice,
                isHigherPrice: isHigh,
              ),
        ),
      ],
    );
  }
}