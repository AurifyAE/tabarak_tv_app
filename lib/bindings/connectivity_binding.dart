import 'package:get/get.dart';

import '../controllers/conectivity_controller.dart';
// import 'package:pulparambil_gold/app/controllers/conectivity_controller.dart';

class ConnectivityBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityController());
  }
}