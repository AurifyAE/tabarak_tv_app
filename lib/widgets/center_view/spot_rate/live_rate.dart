// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';

// import '../../../controllers/live_controller.dart';
// import '../../../controllers/live_rate_controller.dart';
// import 'live_rate_card.dart';

// class LiveRate extends StatelessWidget {
//   const LiveRate({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     // Initialize controllers
//     // final liveRateController = Get.find<LiveRateController>();
//     final liveController = Get.find<LiveController>();
    
//     // Ensure we fetch spot rates if needed
//     if (liveController.spotRateModel.value == null && !liveController.isLoading.value) {
//       liveController.getSpotRate();
//     }
    
//     return Expanded(
//       flex: 2,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 'Spot rate (\$)',
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//                 child: LiveRateCard(
//                   commodityName: 'Gold', 
//                   commodityImage: Image.asset('assets/images/goldBar.png'),
//                   bidPrice: 0.0,
//                   askPrice: 0.0,
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//                 child: LiveRateCard(
//                   commodityName: 'Silver', 
//                   commodityImage: Image.asset('assets/images/silverBar.png'),
//                   bidPrice: 0.0,
//                   askPrice: 0.0,
//                 ),
//               ),
//             ),
//             SizedBox(height: 1.w)  
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../controllers/live_controller.dart';
import '../../../controllers/live_rate_controller.dart';
import '../../../core/utils/price_calculator.dart';
import '../../../models/price_change_state.dart';
import 'price_animation_controller.dart';

class LiveRate extends StatelessWidget { 
  const LiveRate({super.key});

  @override
  Widget build(BuildContext context) {
    final liveController = Get.find<LiveController>();
    final liveRateController = Get.find<LiveRateController>();
    
    // Ensure we fetch spot rates if needed
    if (liveController.spotRateModel.value == null && !liveController.isLoading.value) {
      liveController.getSpotRate();
    }
    
    // Check if socket connection exists and reconnect if needed
    if (liveRateController.marketData.isEmpty) {
      liveRateController.initializeConnection();
    }
    
    return Expanded(
      flex: 2,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFBDB394), // Beige background color
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF8D7E5F),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFF8D7E5F), // Brown header color
                ),
                child: Center(
                  child: Text(
                    'SPOT RATE',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              // Price Table
              Expanded(
                child: Column(
                  children: [
                    // Column Headers
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      child: Row(
                        children: [
                          Spacer(flex: 3),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'BID ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\$',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ASK ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[300],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\$',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Gold Row
                    Expanded(
                      child: SpotRateRow(
                        commodityName: 'Gold',
                        metalName: 'GOLD',
                        useRedBackground: true,
                      ),
                    ),
                    
                    // Divider
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: Colors.black.withOpacity(0.2),
                        height: 1,
                      ),
                    ),
                    
                    // Silver Row
                    Expanded(
                      child: SpotRateRow(
                        commodityName: 'Silver',
                        metalName: 'SILVER',
                        useRedBackground: false,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Footer
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                color: const Color(0xFF3C4226), // Dark green footer
                child: Center(
                  child: Text(
                    'Powered by www.aurify.ae',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SpotRateRow extends StatelessWidget {
  final String commodityName;
  final String metalName;
  final bool useRedBackground;
  
  const SpotRateRow({
    Key? key, 
    required this.commodityName,
    required this.metalName,
    required this.useRedBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final liveController = Get.find<LiveController>();
    final liveRateController = Get.find<LiveRateController>();
    
    return Obx(() {
      bool isLoading = liveRateController.marketData.isEmpty ||
          liveRateController.marketData[commodityName] == null ||
          liveController.spotRateModel.value == null;

      final data = isLoading ? null : liveRateController.marketData[commodityName];
      final spotRateModel = liveController.spotRateModel.value;

      final priceModel = PriceCalculator.calculatePrices(
        commodityName: commodityName,
        marketData: data,
        spotRateModel: spotRateModel,
        isLoading: isLoading,
      );

      return Row(
        children: [
          // Commodity Name
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                metalName,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          
          // BID Price
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main Price
                isLoading
                    ? SpotRateLoadingBox()
                    : SpotRatePriceBox(
                        price: priceModel.bidPrice,
                        commodityName: commodityName,
                        priceType: 'BID',
                        useRedBackground: useRedBackground,
                      ),
                
                // Previous Price
                SizedBox(height: 4),
                isLoading
                    ? LoadingIndicator()
                    : PreviousPriceRow(
                        price: priceModel.lowPrice,
                        isHigher: false,
                      ),
              ],
            ),
          ),
          
          // ASK Price
          Expanded(
            flex: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main Price
                isLoading
                    ? SpotRateLoadingBox()
                    : SpotRatePriceBox(
                        price: priceModel.askPrice,
                        commodityName: commodityName,
                        priceType: 'ASK',
                        useRedBackground: useRedBackground,
                      ),
                
                // High Price
                SizedBox(height: 4),
                isLoading
                    ? LoadingIndicator()
                    : PreviousPriceRow(
                        price: priceModel.highPrice,
                        isHigher: true,
                      ),
              ],
            ),
          ),
        ],
      );
    });
  }
}

class SpotRatePriceBox extends StatelessWidget {
  final double price;
  final String commodityName;
  final String priceType;
  final bool useRedBackground;

  const SpotRatePriceBox({
    Key? key,
    required this.price,
    required this.commodityName,
    required this.priceType, 
    required this.useRedBackground,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final animationController = PriceAnimationController(
      commodityName: commodityName,
      priceType: priceType,
    );

    animationController.updatePrice(price);

    return Obx(() {
      PriceChangeState state = animationController.currentState;
      
      // Set default background color based on commodity and price type
      Color bgColor;
      Color textColor;

      if (useRedBackground) {
        // Red background for GOLD as shown in the image
        bgColor = const Color(0xFFFF0000);
        textColor = Colors.white;
      } else {
        // White background for SILVER as shown in the image
        bgColor = Colors.white;
        textColor = Colors.black;
      }
      
      // Momentarily change color during price animation
      if (state == PriceChangeState.increase) {
        bgColor = Colors.green;
        textColor = Colors.white;
      } else if (state == PriceChangeState.decrease) {
        bgColor = Colors.red;
        textColor = Colors.white;
      }
      
      return Container(
        width: 100.w,
        height: 36,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: Colors.black.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            price.toStringAsFixed(commodityName == 'Gold' ? 2 : 3),
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      );
    });
  }
}

class SpotRateLoadingBox extends StatelessWidget {
  const SpotRateLoadingBox({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 36,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Center(
        child: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 1),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          child: Container(
            height: 20,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }
}

class PreviousPriceRow extends StatelessWidget {
  final double price;
  final bool isHigher;
  
  const PreviousPriceRow({
    Key? key,
    required this.price,
    required this.isHigher,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8D7), // Light beige color for the price indicator
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isHigher ? Icons.arrow_upward : Icons.arrow_downward,
            color: isHigher ? Colors.green : Colors.red,
            size: 12,
          ),
          SizedBox(width: 4),
          Text(
            price.toStringAsFixed(price >= 100 ? 2 : 3),
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE8E8D7),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        interval: const Duration(seconds: 1),
        color: Colors.white,
        colorOpacity: 0.3,
        enabled: true,
        child: Container(
          height: 16,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}