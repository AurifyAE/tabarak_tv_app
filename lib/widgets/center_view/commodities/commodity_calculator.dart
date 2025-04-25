import 'dart:developer' as dev;
import 'dart:math';

import '../../../models/commodity.dart';

class CommodityCalculator {
  Commodity findOrCreateCommodity(
      List<dynamic> commodities, String metal, String weight, int purity,
      {double? premium}) {
    dev.log('Finding commodity: metal=$metal, weight=$weight, purity=$purity, premium=$premium');
    
    dynamic foundCommodity;

    try {
      // Simple search for any commodity
      for (var commodity in commodities) {
        if (commodity.metal == metal && commodity.weight == weight) {
          dev.log('Found exact match for ${commodity.metal}, ${commodity.weight}');
          return Commodity.fromDynamic(commodity);
        }
      }

      dev.log('No exact match found, searching for closest match');
      foundCommodity = commodities.firstWhere(
          (c) => c.metal == metal && (c.weight == weight || weight == "GM"),
          orElse: () => commodities.firstWhere((c) => c.metal == metal,
              orElse: () => commodities.first));
    } catch (e) {
      dev.log('Error finding commodity: $e');
      foundCommodity = commodities.first;
    }

    dev.log('Using base commodity: ${foundCommodity.metal}, ${foundCommodity.weight}, ${foundCommodity.purity}');
    Commodity baseCommodity = Commodity.fromDynamic(foundCommodity);

    // Remove sell premium for KGBAR
    double? finalPremium = weight == "KGBAR" ? 0 : premium;
    
    Commodity result = baseCommodity.copyWith(
        purity: purity, weight: weight, sellPremium: finalPremium);
    dev.log('Created new commodity: ${result.metal}, ${result.weight}, ${result.purity}, premium=${result.sellPremium}');
    
    return result;
  }

  double calculatePurityPower(dynamic purity) {
    String purityStr = purity.toString();
    int digitCount = purityStr.length;
    double powerOfTen = pow(10, digitCount).toDouble();
    double result = purity / powerOfTen;
    
    dev.log('Purity calculation: purity=$purity, digits=$digitCount, power=$powerOfTen, result=$result');
    return result;
  }

  double getUnitMultiplier(String weight) {
    switch (weight) {
      case "GM":
        return 1.0;
      case "KG":
        return 1000.0;
      case "KGBAR":
        return 1000.0; // Changed from 999.0 to be consistent with KG
      case "TTB":
      case "TTBAR":
        return 116.64;
      case "TOLA":
        return 11.664;
      case "OZ":
        return 31.1034768;
      default:
        return 1.0;
    }
  }

  String formatValue(double value, String weight) {
    if (weight == "GM") {
      return value.toStringAsFixed(2);
    } else {
      return value.toStringAsFixed(0);
    }
  }

  String calculateCommodityValue(double askPrice, double sellPremium,
      String weight, int purity, double sellCharge) {
    dev.log('Calculating commodity value: askPrice=$askPrice, sellPremium=$sellPremium, weight=$weight, purity=$purity, sellCharge=$sellCharge');
    
    // Apply zero premium for KGBAR
    double effectiveSellPremium = weight == "KGBAR" ? 0 : sellPremium;
    
    double cat = askPrice + effectiveSellPremium;
    double askNow = (cat / 31.103) * 3.674;
    double unitMultiplier = getUnitMultiplier(weight);
    double purityFactor = calculatePurityPower(purity);
    
    double rateNow = askNow * unitMultiplier * purityFactor + sellCharge;
    
    // Removed KGBAR-specific adjustment that was adding 210.0
    
    dev.log('rateNow before formatting: $rateNow');
    String formattedPrice = formatValue(rateNow, weight);
    dev.log('Final formatted price: $formattedPrice');
    
    return formattedPrice;
  }

  // int _ensureIntPurity(dynamic purity) {
  //   if (purity is int) {
  //     return purity;
  //   } else if (purity is double) {
  //     return purity.toInt();
  //   } else if (purity is String) {
  //     return int.tryParse(purity) ?? 999;
  //   } else {
  //     return 999;
  //   }
  // }

}