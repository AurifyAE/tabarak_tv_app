import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/controllers/date_time_controller.dart';

import '../controllers/date_time_controller.dart';

class DateTimeBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DateTimeController>(() => DateTimeController());
  }
}