import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/news/views/bookmarks_view.dart';

import '../../news/views/news_view.dart';

class NavigatorController extends GetxController{
  var selectedIndex = 0.obs;
  var isLoggedIn = false.obs;

  final pages = [
    NewsView(),
    BookmarkView()
  ];

  @override
  void onInit() {
    userLoginCheck();
    super.onInit();
  }

  void userLogout()async{
    await FirebaseAuth.instance.signOut();
    isLoggedIn.value = false;
  }

  void userLoginCheck(){
    isLoggedIn.value = FirebaseAuth.instance.currentUser != null ? true : false;
  }
}