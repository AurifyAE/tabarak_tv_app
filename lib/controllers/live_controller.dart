import 'dart:developer';

import 'package:get/get.dart';

import '../models/spot_rate_model.dart';
import '../repositories/live_repository.dart';

class LiveController extends GetxController {
  final LiveRepository _repository = Get.find<LiveRepository>();
  final Rx<SpotRateModel?> spotRateModel = Rx<SpotRateModel?>(null);
  final RxBool isLoading = false.obs;

  Future<SpotRateModel?> getSpotRate() async {
    isLoading.value = true;
    final res = await _repository.getSpotRate();
    log('Getting spot rate');
    
    res.fold(
      (l) {
        log("###ERROR###");
        log(l.message);
      },
      (r) {
        spotRateModel.value = r;
      },
    );
    
    isLoading.value = false;
    return spotRateModel.value;
  }
}
