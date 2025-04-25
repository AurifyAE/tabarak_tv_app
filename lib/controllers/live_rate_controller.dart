import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
// import 'package:pulparambil_gold/app/core/constants/constants.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

// import '../core/constant/constants.dart';
import '../core/constants/constants.dart';
import '../models/commodity_model.dart';
import '../models/server_details_model.dart';
import '../models/live_rate_model.dart';

class LiveRateController extends GetxController {
  IO.Socket? _socket;
  final Rx<LiveRateModel?> liveRateModel = Rx<LiveRateModel?>(null);
  final RxMap marketData = {}.obs;
  final RxString serverLink = 'https://capital-server-9ebj.onrender.com'.obs;
  final RxBool isServerLinkLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeConnection();
  }

  void initializeConnection() async {
    try {
      final link = await fetchServerLink();
      if (link.isNotEmpty) {
        serverLink.value = link;
        isServerLinkLoaded.value = true;
        await initializeSocketConnection(link: link);
        log('Connection initialized succesfully');
      } else {
        await initializeSocketConnection(link: serverLink.value);
      }
    } catch (e) {
      log("Error initializing connection: $e");

      await initializeSocketConnection(link: serverLink.value);
    }
  }

  Future<List<String>> fetchCommodityArray() async {
    try {
      const id = "IfiuH/ko+rh/gekRvY4Va0s+aGYuGJEAOkbJbChhcqo=";
      final response = await http.get(
        Uri.parse('${FirebaseConstants.baseUrl}get-commodities/${FirebaseConstants.adminId}'),
        headers: {
          'X-Secret-Key': id,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final commodity = CommodityModel.fromMap(json.decode(response.body));
        log('commodities fetched successfully');
        log('###-------------------------------${response.body}-----------------------------------###');
        return commodity.commodities;
      } else {
        log("Failed to fetch commodity array: ${response.statusCode}");
        return ["Gold", "Silver"];
      }
    } catch (e) {
      log("Error fetching commodity array: $e");
      return ["Gold", "Silver"];
    }
  }

  Future<String> fetchServerLink() async {
    try {
      final response = await http.get(
        Uri.parse('${FirebaseConstants.baseUrl}get-server'),
        headers: {
          'X-Secret-Key': FirebaseConstants.secretKey,
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final serverDetails = ServerModel.fromMap(json.decode(response.body));
        log('Server URL fetched successfully');
        return serverDetails.info.serverUrl;
      } else {
        log("Failed to load server link: ${response.statusCode}");
        return serverLink.value;
      }
    } catch (e) {
      log("Error fetching server link: $e");
      return serverLink.value;
    }
  }

  Future<void> initializeSocketConnection({required String link}) async {
    try {
      _socket = IO.io(link, {
        'transports': ['websocket'],
        'autoConnect': true, // Ensure auto connection
        'forceNew': true, // Ensure new connection
        'reconnection': true, // Allow reconnection
        'query': {'secret': 'aurify@123'},
      });

      _socket?.onConnect((_) async {
        log('Connected to WebSocket server');
        try {
          List<String> commodityArray = await fetchCommodityArray();
          _requestMarketData(commodityArray);
          log('Server initialized');
        } catch (e) {
          log("Error fetching commodity array: $e");
          _requestMarketData(["Gold", "Silver"]);
        }
      });

      _socket?.on('market-data', (data) {
        if (data is Map<String, dynamic> && data['symbol'] is String) {
          Map<String, dynamic> processedData = Map<String, dynamic>.from(data);

          processedData.forEach((key, value) {
            if (value is num && value is! double) {
              processedData[key] = value.toDouble();
            }
          });

          marketData[processedData['symbol']] = processedData;

          try {
            liveRateModel.value = LiveRateModel.fromJson(marketData);
          } catch (e) {
            log("Error parsing market data: $e");
            log("Data that caused the error: $processedData");
          }
        } else {
          log("Received invalid market data format");
        }
      });

      _socket?.onConnectError((data) => log('Connection Error: $data'));
      _socket?.onDisconnect((_) => log('Disconnected from WebSocket server'));

      _socket?.connect();
    } catch (e) {
      log("Socket connection error: $e");
    }
  }

  void _requestMarketData(List<String> symbols) {
    try {
      _socket?.emit('request-data', [symbols]);
    } catch (e) {
      log("Error requesting market data: $e");
    }
  }

  void reconnect() {
    try {
      _socket?.disconnect();
      initializeConnection();
    } catch (e) {
      log("Error reconnecting: $e");
    }
  }

  @override
  void onClose() {
    _socket?.disconnect();
    super.onClose();
  }
}
