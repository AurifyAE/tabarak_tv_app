import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/widgets/center_view/commodities/commodity_calculator.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/live_controller.dart';
import '../../../controllers/live_rate_controller.dart';
import 'commodity_calculator.dart';
import 'gold_value_card.dart';
import 'shimmer_card.dart';

class CommoditiesRate extends StatelessWidget {
  const CommoditiesRate({super.key});

  @override
  Widget build(BuildContext context) {
    final LiveRateController liveRateController =
        Get.find<LiveRateController>();
    final LiveController liveController = Get.find<LiveController>();

    return Expanded(
      flex: 3,
      child: Column(
        children: [
          SizedBox(height: 10.h),
          Expanded(
            child: _buildMainContainer(liveRateController, liveController),
          ),
          buildFooter(),
          SizedBox(height: 1.w), 
        ],
      ),
    );
  }

  Widget _buildMainContainer(
      LiveRateController liveRateController, LiveController liveController) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(10, 255, 255, 255),
          borderRadius: BorderRadius.circular(3.w),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding:  EdgeInsets.all(3.w),
              child: _buildCommoditiesGrid(
                  constraints, liveRateController, liveController),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCommoditiesGrid(BoxConstraints constraints,
      LiveRateController liveRateController, LiveController liveController) {
    double availableWidth = constraints.maxWidth;
    double availableHeight = constraints.maxHeight;

     double horizontalPadding = 3.w;
     double verticalPadding = 3.w;

    double gridWidth = availableWidth - (horizontalPadding * 2);
    double gridHeight = availableHeight - (verticalPadding * 2);

     double spacing = 2.w;
    double itemWidth = (gridWidth - spacing) / 2;
    double itemHeight = (gridHeight - spacing) / 2;

    return Obx(() {
      bool isLoading = liveRateController.marketData.isEmpty ||
          liveRateController.marketData['Gold'] == null ||
          liveController.spotRateModel.value == null;

      return GridView.custom(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          childAspectRatio: itemWidth / itemHeight,
        ),
        childrenDelegate: SliverChildListDelegate(
          isLoading
              ? _buildLoadingCards()
              : _buildDataCards(liveRateController, liveController),
        ),
      );
    });
  }

  List<Widget> _buildLoadingCards() {
    return [
      GoldValueShimmerCard(title: "999 TTBAR"),
      GoldValueShimmerCard(title: "995 KGBAR"),
      GoldValueShimmerCard(title: "9999 KGBAR"),
      GoldValueShimmerCard(title: "9999 GM"),
    ];
  }

  List<Widget> _buildDataCards(
      LiveRateController liveRateController, LiveController liveController) {
    final commodityService = CommodityCalculator();

    final goldData = liveRateController.marketData['Gold'];
    final spotRateModel = liveController.spotRateModel.value!;

    double baseBid =
        goldData['bid'] != null ? (goldData['bid'] as num).toDouble() : 0.0;

    double calculatedBidPrice = baseBid + spotRateModel.info.goldBidSpread;
    double calculatedAskPrice =
        calculatedBidPrice + 0.5 + spotRateModel.info.goldAskSpread;

    final commodities = spotRateModel.info.commodities;

    final ttbarCommodity = commodityService.findOrCreateCommodity(
        commodities, "Gold", "TTBAR", 999);

    final kgbar995Commodity = commodityService.findOrCreateCommodity(
        commodities, "Gold", "KGBAR", 995);

    final kgbar9999Commodity = commodityService.findOrCreateCommodity(
        commodities, "Gold", "KGBAR", 9999);

    final gmCommodity =
        commodityService.findOrCreateCommodity(commodities, "Gold", "GM", 9999);

    String ttbarValue = commodityService.calculateCommodityValue(
        calculatedAskPrice,
        ttbarCommodity.sellPremium,
        ttbarCommodity.weight,
        ttbarCommodity.purity,
        ttbarCommodity.sellCharge);

    String kgbar995Value = commodityService.calculateCommodityValue(
        calculatedAskPrice,
        kgbar995Commodity.sellPremium,
        kgbar995Commodity.weight,
        kgbar995Commodity.purity,
        kgbar995Commodity.sellCharge);

    String kgbar9999Value = commodityService.calculateCommodityValue(
        calculatedAskPrice,
        kgbar9999Commodity.sellPremium,
        kgbar9999Commodity.weight,
        kgbar9999Commodity.purity,
        kgbar9999Commodity.sellCharge);

    String gmValue = commodityService.calculateCommodityValue(
        calculatedAskPrice,
        gmCommodity.sellPremium,
        gmCommodity.weight,
        gmCommodity.purity,
        gmCommodity.sellCharge);

    return [
      GoldValueCard(title: "999 TTBAR", value: ttbarValue),
      GoldValueCard(title: "995 KGBAR", value: kgbar995Value),
      GoldValueCard(title: "9999 KGBAR", value: kgbar9999Value),
      GoldValueCard(title: "9999 GM", value: gmValue),
    ];
  }

  Widget buildFooter() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Powered by www.aurify.ae',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
