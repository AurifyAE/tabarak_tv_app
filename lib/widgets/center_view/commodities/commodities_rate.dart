import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/live_controller.dart';
import '../../../controllers/live_rate_controller.dart';
import 'commodity_calculator.dart';

class CommoditiesList extends StatelessWidget {
  final liveRateController = Get.find<LiveRateController>();
  final liveController = Get.find<LiveController>();
  
  CommoditiesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(3.w),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFBEA369), // Base gold color for background
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Obx(() {
          bool isLoading = liveRateController.marketData.isEmpty ||
              !liveRateController.marketData.containsKey('Gold') ||
              liveController.spotRateModel.value == null;

          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF7D6B42),
                  ),
                )
              : _buildCommodityList();
        }),
      ),
    );
  }

  Widget _buildCommodityList() {
    final goldData =
        liveRateController.marketData['Gold'] as Map<String, dynamic>?;
    final spotRateModel = liveController.spotRateModel.value;
    final commodityService = CommodityCalculator();

    if (goldData == null || spotRateModel == null) {
      return const Center(
          child: Text('No data available', 
          style: TextStyle(color: Colors.white)));
    }

    double baseBid =
        goldData['bid'] != null ? (goldData['bid'] as num).toDouble() : 0.0;
    double calculatedBidPrice = baseBid + spotRateModel.info.goldBidSpread;
    double calculatedAskPrice =
        calculatedBidPrice + 0.5 + spotRateModel.info.goldAskSpread;

    final commodities = spotRateModel.info.commodities;
    
    // Gold with different purities
    final gmGold24K = commodityService.findOrCreateCommodity(
        commodities, "Gold", "GM", 999); // 24K = 999 fine
    final gmGold22K = commodityService.findOrCreateCommodity(
        commodities, "Gold", "GM", 916); // 22K = 916 fine
    final gmGold21K = commodityService.findOrCreateCommodity(
        commodities, "Gold", "GM", 875); // 21K = 875 fine
    final gmGold18K = commodityService.findOrCreateCommodity(
        commodities, "Gold", "GM", 750); // 18K = 750 fine

    // Gold prices for different purities
    final price24K = double.parse(commodityService.calculateCommodityValue(
        calculatedAskPrice,
        gmGold24K.sellPremium,
        gmGold24K.weight,
        gmGold24K.purity,
        gmGold24K.sellCharge));
        
    final price22K = double.parse(commodityService.calculateCommodityValue(
        calculatedAskPrice,
        gmGold22K.sellPremium,
        gmGold22K.weight,
        gmGold22K.purity,
        gmGold22K.sellCharge));
        
    final price21K = double.parse(commodityService.calculateCommodityValue(
        calculatedAskPrice,
        gmGold21K.sellPremium,
        gmGold21K.weight,
        gmGold21K.purity,
        gmGold21K.sellCharge));
        
    final price18K = double.parse(commodityService.calculateCommodityValue(
        calculatedAskPrice,
        gmGold18K.sellPremium,
        gmGold18K.weight,
        gmGold18K.purity,
        gmGold18K.sellCharge));

    final goldPurities = [
      {
        'name': 'GOLD',
        'karat': '24K',
        'unit': '1 GM',
        'price': price24K
      },
      {
        'name': 'GOLD',
        'karat': '22K',
        'unit': '1 GM',
        'price': price22K
      },
      {
        'name': 'GOLD',
        'karat': '21K',
        'unit': '1 GM',
        'price': price21K
      },
      {
        'name': 'GOLD',
        'karat': '18K',
        'unit': '1 GM',
        'price': price18K
      },
    ];

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.5.h),
            decoration: const BoxDecoration(
              color: Color(0xFF91754B), // Darker gold for header
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Text(
                      'COMMODITY',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'UNIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    'ASK (AED)',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          
          // List of gold purities
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: goldPurities.length,
            itemBuilder: (context, index) {
              final item = goldPurities[index];
              return _buildGoldRow(
                item['name'] as String,
                item['karat'] as String,
                item['unit'] as String,
                _formatPrice(item['price'] as double),
              );
            },
          ),
        ],
      ),
    );
  }

  String _formatPrice(double price) {
    return price.toStringAsFixed(2);
  }

  Widget _buildGoldRow(String name, String karat, String unit, String price) {
    return Container(
      height: 7.h,
      decoration: const BoxDecoration(
        color: Color(0xFFAA9366), // Lighter gold for rows
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    karat,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Text(
              unit,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              price,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}