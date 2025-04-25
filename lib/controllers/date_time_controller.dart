import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeController extends GetxController {
  var indiaTime = DateTime.now().obs;
  var londonTime = DateTime.now().toUtc().obs;
  var newYorkTime = DateTime.now().toUtc().subtract(Duration(hours: 4)).obs;
  var formattedTime = ''.obs;
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
    formattedTime.value =
        DateFormat('hh:mm:ss a\nEEEE\n dd MMM yyyy').format(indiaTime.value);
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
