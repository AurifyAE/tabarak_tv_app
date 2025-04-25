// import 'dart:developer';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:fpdart/fpdart.dart';
// import 'package:get/get.dart';

// import '../core/constants/constants.dart';
// import '../core/utils/failure.dart';
// import '../core/utils/type_def.dart';
// import '../models/spot_rate_model.dart';

// class LiveRepository extends GetxService {
//   FutureEither<SpotRateModel> getSpotRate() async {
//     try {
//       final response = await Dio().get(
//         "${FirebaseConstants.baseUrl}get-spotrates/${FirebaseConstants.adminId}",
//         options: Options(headers: FirebaseConstants.headers, method: "GET"),
//       );

//       if (response.statusCode == 200) {
//         Map<String, dynamic> data = response.data;
//         log('yeah I got the data ');

//         if (data.containsKey("info") && data["info"] is Map) {
//           Map<String, dynamic> info = data["info"];

//           info.forEach((key, value) {
//             if (value is num) {}
//           });
//         }

//         final spotRateModel = SpotRateModel.fromMap(data);
//         return right(spotRateModel);
//       } else {
//         return left(Failure(response.statusCode.toString()));
//       }
//     } on DioException catch (e) {
//       log('$e.error');
//       log('$e.stackTrace');
//       log('$e.message');
//       log('$e.response');
//       return left(Failure("Dio EXCEPTION"));
//     } catch (e) {
//       if (kDebugMode) {
//         log(e.toString());
//       }
//       return left(Failure(e.toString()));
//     }
//   }
// }





import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/core/constants/constants.dart';

// import '../core/constant/constants.dart';
import '../core/constants/constants.dart';
import '../core/utils/failure.dart';
import '../core/utils/type_def.dart';
import '../models/spot_rate_model.dart';

class LiveRepository extends GetxService {
FutureEither<SpotRateModel> getSpotRate() async {
  try {
    final response = await Dio().get(
      "${FirebaseConstants.baseUrl}get-spotrates/${FirebaseConstants.adminId}",
      options: Options(headers: FirebaseConstants.headers, method: "GET"),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data;
      log('Spot rate data received: $data');

      // Debug: Print out the types of numeric fields
      if (data.containsKey('info') && data['info'] is Map) {
        Map<String, dynamic> info = data['info'];
        info.forEach((key, value) {
          if (key.contains('Spread') || key.contains('Margin')) {
            log('Key: $key, Value: $value, Type: ${value.runtimeType}');
          }
        });
      }

      try {
        final spotRateModel = SpotRateModel.fromMap(data);
        return right(spotRateModel);
      } catch (parseError) {
        log('Error parsing spot rate data: $parseError');
        log('Data causing error: $data');
        return left(Failure("Error parsing spot rate data: $parseError"));
      }
    } else {
      return left(Failure("HTTP Error: ${response.statusCode}"));
    }
  } on DioException catch (e) {
    log('Dio Error details:');
    log('Error: ${e.error}');
    log('Message: ${e.message}');
    log('Response: ${e.response}');
    return left(Failure("Network Error: ${e.message}"));
  } catch (e) {
    log('Unexpected error: $e');
    return left(Failure(e.toString()));
  }
}
}
