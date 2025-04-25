import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:pulparambil_gold/app/widgets/center_view/commodities/commodities_rate.dart';
// import 'package:pulparambil_gold/app/widgets/center_view/spot_rate/live_rate.dart';

import '../../controllers/conectivity_controller.dart';
import '../../views/no_internet_view.dart';
import 'commodities/commodities_rate.dart';
import 'spot_rate/live_rate.dart';

class CenterView extends GetView<ConnectivityController> {
  const CenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ConnectivityController());

    return Expanded(
      flex: 8,
      child: GetX<ConnectivityController>(
        builder: (controller) {
          return controller.isConnected.value
              ? _buildConnectedView()
              : NoInternetView();
        },
      ),
    );
  }

  Widget _buildConnectedView() {
    return Row(
      children: const [
        CommoditiesRate(),
        LiveRate(),
      ],
    );
  }
}
