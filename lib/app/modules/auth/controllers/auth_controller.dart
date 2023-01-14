import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/news/controllers/news_controller.dart';

import '../../../../data/database/database_helper.dart';
import '../../../../data/models/news_model.dart';
import '../../../routes/app_pages.dart';
import '../../bottom_navigation/controllers/navigator_controller.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var passConfController = TextEditingController().obs;
  var firebaseAuth = FirebaseAuth.instance.obs;
  var firebaseDB = FirebaseFirestore.instance.obs;
  var loginPage = true.obs;
  var isLoading = false.obs;

  Future<void> userLogin({required BuildContext context}) async {
    if (!GetUtils.isEmail(emailController.value.text)) {
      Flushbar(
        title: "Invalid Email",
        titleColor: Colors.red,
        message: "Please enter a valid email",
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.red,
        ),
      ).show(context);
    } else if (passwordController.value.text.length < 6) {
      Flushbar(
        title: "Invalid Password",
        titleColor: Colors.red,
        message: "Please enter a valid password",
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.red,
        ),
      ).show(context);
    } else if (loginPage.value
        ? false
        : passwordController.value.text != passConfController.value.text) {
      Flushbar(
        title: "Password didn\'t match",
        titleColor: Colors.red,
        message: "Please confirm password",
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.red,
        ),
      ).show(context);
    } else {
      isLoading.value = true;
      try {
        loginPage.value
            ? await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: emailController.value.text,
                    password: passwordController.value.text)
                .then((value) async {
                Get.find<NavigatorController>().userLoginCheck();
                await dataSync();
                isLoading.value = false;
                Get.back();
              })
            : await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: emailController.value.text,
                    password: passwordController.value.text)
                .then((value){
                Get.find<NavigatorController>().userLoginCheck();
                isLoading.value = false;
                Get.back();
              });
      } on FirebaseAuthException catch (e) {
        isLoading.value = false;
        Flushbar(
          title: "Login Failed",
          titleColor: Colors.red,
          message: e.toString(),
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.error_outline,
            size: 30,
            color: Colors.red,
          ),
        ).show(context);
      }
    }
  }

  Future<void> dataSync() async {
    await DatabaseHelper.instance.deleteTableData();
    if (firebaseAuth.value.currentUser != null) {
      QuerySnapshot querySnapshot = await firebaseDB.value
          .collection(firebaseAuth.value.currentUser!.uid)
          .get();
      final allData = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      for (var doc in allData) {
        await DatabaseHelper.instance.insertData(NewsModel(
            title: doc['title'],
            description: doc['description'],
            urlToImage: doc['urlToImage'],
            publishedAt: doc['publishedAt'].toDate()));
      }
      Get.find<NewsController>().fetchBookmark();
    }
  }
}
