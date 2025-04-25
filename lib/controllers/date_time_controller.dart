import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  var indiaTime = DateTime.now().obs;
  var londonTime = DateTime.now().toUtc().obs;
  var newYorkTime = DateTime.now().toUtc().subtract(Duration(hours: 4)).obs;
  var formattedTime = ''.obs;
  var formattedDate = ''.obs;
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();
    _updateTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    final now = DateTime.now();
    indiaTime.value = now;
    londonTime.value = now.toUtc();
    newYorkTime.value = now.toUtc().subtract(Duration(hours: 4));
    
    // Format to match the image style: "08:35 PM" for time
    formattedTime.value = DateFormat('hh:mm a').format(indiaTime.value);
    
    // Format to match the image style: "THURSDAY, 24 APRIL 2025" for date
    formattedDate.value = DateFormat('EEEE, dd MMMM yyyy').format(indiaTime.value).toUpperCase();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}