import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../models/news_model.dart';
import 'dart:developer' as developer;

class NewsController extends GetxController {
  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString debugInfo = ''.obs; // Add debug info for UI visibility

  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    fetchNews();
  }
  
  // Add this helper method to log and store debug information
  void _logDebug(String message) {
    developer.log(message, name: 'NewsController');
    debugInfo.value += "$message\n";
  }

  Future<void> fetchNews() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      debugInfo.value = ''; // Clear previous debug info
      
      _logDebug('Starting news fetch...');
      
      // Try both endpoints to see which one works
      final endpoints = [
        'https://api.aurify.ae/device/get-news/680a4d98a7ef7568049a3a2e',
        'https://api.aurify.ae/user/get-news/680a4d98a7ef7568049a3a2e'
      ];
      
      Map<String, dynamic>? responseData;
      String usedEndpoint = '';
      
      for (var endpoint in endpoints) {
        _logDebug('Trying endpoint: $endpoint');
        
        try {
          final response = await _dio.get(
            endpoint,
            options: Options(
              headers: {
                'X-Secret-Key': 'IfiuH/ko+rh/gekRvY4Va0s+aGYuGJEAOkbJbChhcqo=',
              },
              receiveTimeout: const Duration(seconds: 10),
              sendTimeout: const Duration(seconds: 10),
            ),
          );
          
          _logDebug('Response status: ${response.statusCode}');
          
          if (response.statusCode == 200) {
            responseData = response.data;
            usedEndpoint = endpoint;
            _logDebug('Success with endpoint: $endpoint');
            break;  // We got a successful response, no need to try the other endpoint
          }
        } catch (e) {
          _logDebug('Failed with endpoint $endpoint: $e');
        }
      }
      
      if (responseData == null) {
        _logDebug('All endpoints failed');
        errorMessage.value = 'Failed to connect to server';
        return;
      }
      
      _logDebug('Response data structure: ${responseData.keys.toList()}');
      _logDebug('Success flag: ${responseData['success']}');
      
      if (responseData['success'] == true && responseData['news'] != null) {
        _logDebug('News data type: ${responseData['news'].runtimeType}');
        
        if (responseData['news'] is List) {
          final List<dynamic> newsContainers = responseData['news'];
          _logDebug('News containers count: ${newsContainers.length}');
          
          List<NewsModel> allNews = [];
          
          for (int i = 0; i < newsContainers.length; i++) {
            var container = newsContainers[i];
            _logDebug('Container $i structure: ${container.keys.toList()}');
            
            if (container['news'] != null) {
              _logDebug('Container $i news type: ${container['news'].runtimeType}');
              
              if (container['news'] is List) {
                final List<dynamic> newsItems = container['news'];
                _logDebug('Container $i news items count: ${newsItems.length}');
                
                for (int j = 0; j < newsItems.length; j++) {
                  var newsItem = newsItems[j];
                  _logDebug('News item $j structure: ${newsItem.keys.toList()}');
                  _logDebug('News item $j title: ${newsItem['title']}');
                  
                  allNews.add(NewsModel.fromJson(newsItem));
                }
              } else {
                _logDebug('Container $i news is not a List');
              }
            } else {
              _logDebug('Container $i has no news field');
            }
          }
          
          _logDebug('Total news items collected: ${allNews.length}');
          newsList.value = allNews;
          
          if (newsList.isEmpty) {
            _logDebug('News list is empty after processing');
            errorMessage.value = 'No news available';
          } else {
            _logDebug('News list populated successfully');
            for (var news in newsList) {
              _logDebug('News item: ${news.id} - ${news.title}');
            }
          }
        } else if (responseData['news'] is Map) {
          // Handle case where 'news' might be an object not an array
          _logDebug("News is a Map object, not a List");
          
          // Try to extract news directly if it's in a different format
          if (responseData['news']['news'] != null && responseData['news']['news'] is List) {
            final List<dynamic> newsItems = responseData['news']['news'];
            _logDebug('Direct news items count: ${newsItems.length}');
            
            newsList.value = newsItems.map((item) => NewsModel.fromJson(item)).toList();
            _logDebug('News list length: ${newsList.length}');
          } else {
            errorMessage.value = 'Invalid news format';
          }
        } else {
          _logDebug('News data is in an unexpected format');
          errorMessage.value = 'Invalid news format';
        }
      } else {
        _logDebug('No news data in response');
        errorMessage.value = 'No news available';
      }
    } catch (e) {
      _logDebug('Error fetching news: $e');
      errorMessage.value = 'Error: ${e.toString()}';
    } finally {
      isLoading.value = false;
      _logDebug('Fetch completed. News count: ${newsList.length}, Error: ${errorMessage.value}');
    }
  }

  void refreshNews() {
    fetchNews();
  }
  
  // Add a debugging widget to show in your UI for testing
  Widget buildDebugInfo() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('News Count: ${newsList.length}'),
        Text('Is Loading: ${isLoading.value}'),
        Text('Error: ${errorMessage.value}'),
        const Divider(),
        Text('Debug Log:', style: const TextStyle(fontWeight: FontWeight.bold)),
        Container(
          height: 200,
          color: Colors.black12,
          child: SingleChildScrollView(
            child: Text(debugInfo.value),
          ),
        ),
      ],
    ));
  }
}