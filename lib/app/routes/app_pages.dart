import 'package:get/get.dart';
import 'package:newsapp/app/modules/auth/views/login_view.dart';
import 'package:newsapp/app/modules/bottom_navigation/views/navigator_view.dart';

import '../modules/auth/bindings/auth_bindings.dart';
import '../modules/bottom_navigation/bindings/NavigatorBinding.dart';
import '../modules/news/bindings/news_binding.dart';
import '../modules/news/views/news_view.dart';

part 'app_routes.dart';

class AppPages{
  AppPages._();
  
  static const INITIAL = Routes.NAVIGATOR;
  static final routes = [
    GetPage(name: _Paths.NAVIGATOR, page: ()=> const NavigatorView(), binding: NavigatorBinding()),
    GetPage(name: _Paths.NEWS, page: ()=> NewsView(), binding: NewsBinding()),
    GetPage(name: _Paths.LOGIN, page: ()=> const LoginView(), binding: AuthBindings())
  ];
}