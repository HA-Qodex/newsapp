import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/routes/app_pages.dart';
import 'package:newsapp/data/models/news_model.dart';

import '../../../../data/database/database_helper.dart';
import '../../../../data/services/news_service.dart';

class NewsController extends GetxController {
  var newsList = <NewsModel>[].obs;
  var bookmarkList = <NewsModel>[].obs;
  var newsSliderList = <NewsModel>[].obs;
  var carouselIndex = 0.obs;
  var firebaseAuth = FirebaseAuth.instance.obs;
  var firebaseDB = FirebaseFirestore.instance.obs;
  var isLoading = false.obs;

  List<Tile> map<Tile>(List list, Function function) {
    List<Tile> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(function(i, list[i]));
    }
    return result;
  }

  @override
  void onInit() {
    getNews();
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
  }

  void getNews() {
    isLoading.value = true;
    NewsService().getData(onSuccess: (data) {
      newsList.assignAll(data);
      newsSliderList.assignAll(newsList.getRange(15, 25));
      isLoading.value = false;
      fetchBookmark();
    }, onError: (error) {
      isLoading.value = false;
      debugPrint('--------------------- News error $error');
    });
  }

  void bookmarkData(NewsModel newsModel, {required BuildContext context}){
    if (firebaseAuth.value.currentUser != null) {
      firebaseDB.value
          .collection(firebaseAuth.value.currentUser!.uid)
          .doc(newsModel.title)
          .set({
        "title": newsModel.title,
        "description": newsModel.description,
        "urlToImage": newsModel.urlToImage,
        "publishedAt": newsModel.publishedAt
      });
      DatabaseHelper.instance.insertData(NewsModel(
          title: newsModel.title,
          description: newsModel.description,
          urlToImage: newsModel.urlToImage,
          publishedAt: newsModel.publishedAt));
      Flushbar(
        title: "Done",
        titleColor: Colors.green,
        message: "News saved to bookmark",
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.check,
          size: 30,
          color: Colors.green,
        ),
      ).show(context);
      fetchBookmark();
    } else {
      Get.toNamed(Routes.LOGIN);
    }
  }

  void fetchBookmark() async {
    bookmarkList.assignAll(await DatabaseHelper.instance.fetchData());
  }

  void deleteBookmark(NewsModel newsModel, {required BuildContext context}){
    if (firebaseAuth.value.currentUser != null) {
      firebaseDB.value
          .collection(firebaseAuth.value.currentUser!.uid)
          .doc(newsModel.title)
          .delete();
      DatabaseHelper.instance.deleteData(newsModel);
      Flushbar(
        title: "Done",
        titleColor: Colors.green,
        message: "News removed from bookmark",
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.check,
          size: 30,
          color: Colors.green,
        ),
      ).show(context);
      fetchBookmark();
    }
  }
}
