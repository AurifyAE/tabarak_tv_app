import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/controllers/live_controller.dart';
// import 'package:pulparambil_gold/app/controllers/live_rate_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/live_controller.dart';
import '../../../controllers/live_rate_controller.dart';
import '../../../core/utils/price_calculator.dart';
import 'header_widget.dart';
import 'price_column.dart';

class LiveRateCard extends GetView<LiveRateController> {
  final String commodityName;
  final Widget commodityImage;
  final double bidPrice;
  final double askPrice;
  final Color baseColor;
  final Color textColor;

  const LiveRateCard({
    super.key,
    required this.commodityName,
    required this.commodityImage,
    required this.bidPrice,
    required this.askPrice,
    this.baseColor = const Color(0xFFD6B96D),
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final liveController = Get.find<LiveController>();

    return Obx(() {
      bool isLoading = controller.marketData.isEmpty ||
          controller.marketData[commodityName] == null ||
          liveController.spotRateModel.value == null;

      final data = isLoading ? null : controller.marketData[commodityName];
      final spotRateModel = liveController.spotRateModel.value;

      final priceModel = PriceCalculator.calculatePrices(
        commodityName: commodityName,
        marketData: data,
        spotRateModel: spotRateModel,
        isLoading: isLoading,
      );

      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.w), color: Colors.white),
        child: Row(
          children: [
            CommodityHeader(
              commodityName: commodityName,
              commodityImage: commodityImage,
              baseColor: baseColor,
              textColor: textColor,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PriceColumn(
                      title: 'BID',
                      commodityName: commodityName,
                      currentPrice: priceModel.bidPrice,
                      previousPrice: priceModel.lowPrice,
                      titleColor: const Color(0xFF3F280A),
                      isHigh: false,
                      isLoading: priceModel.isLoading,
                    ),
                  ),
                  Expanded(
                    child: PriceColumn(
                      title: 'ASK',
                      commodityName: commodityName,
                      currentPrice: priceModel.askPrice,
                      previousPrice: priceModel.highPrice,
                      titleColor: const Color(0xFF3F280A),
                      isHigh: true,
                      isLoading: priceModel.isLoading,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
