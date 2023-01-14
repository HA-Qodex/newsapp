
import 'package:get/get.dart';
import 'package:newsapp/app/modules/news/controllers/news_controller.dart';

class NewsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(() => NewsController());
  }

}