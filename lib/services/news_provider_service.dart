
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/services/api_repository.dart';

import '../models/news_model.dart';


final newsProviderService = Provider((ref) => NewsProviderService());

class NewsProviderService {

  Future<List<NewsModel>> getNews() {
    final String url =
        "/v2/everything?q=apple&from=$startDate&to=$currentDate&sortBy=popularity&apiKey=$apiKey";
    return dio()
        .get(url)
        .then((response) => (response.data["articles"] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList())
        .catchError((e) {
      debugPrint("------------------------>> $e");
      throw Exception("News error $e");
    });
  }

  Future<List<NewsModel>> getSlider() {
    final String url =
        "/v2/everything?q=apple&from=$startDate&to=$currentDate&sortBy=popularity&apiKey=$apiKey";
    return dio()
        .get(url)
        .then((response) => (response.data["articles"] as List)
        .map((e) => NewsModel.fromJson(e))
        .toList().getRange(20, 30).toList())
        .catchError((e) {
      debugPrint("------------------------>> $e");
      throw Exception("Slider error $e");
    });
  }

}