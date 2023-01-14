import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/app/modules/news/controllers/news_controller.dart';
import 'package:newsapp/app/resources/app_colors.dart';
import 'package:newsapp/data/models/news_model.dart';

import '../../bottom_navigation/controllers/navigator_controller.dart';

class NewsDetailsView extends GetView<NewsController> {
  const NewsDetailsView({Key? key, required this.newsModel}) : super(key: key);
  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.4,
            decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(newsModel.urlToImage.toString()),
                    fit: BoxFit.fill)),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 25.0, left: 15),
                child: Row(children: [
                  GestureDetector(onTap: (){Get.back();},child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,))
                ],),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: IntrinsicHeight(
              child: Row(children: [
                const VerticalDivider(color: AppColors.primary, thickness: 3,),
                const SizedBox(width: 5,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsModel.title.toString(),
                        style: GoogleFonts.roboto(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        DateFormat('dd MMM, yyyy').format(
                            DateTime.parse(newsModel.publishedAt
                                .toString())),
                        style: GoogleFonts.lato(
                            fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return controller.bookmarkList.any((element) => element.title == newsModel.title) ?
                  Visibility(
                    visible: Get
                        .find<NavigatorController>()
                        .isLoggedIn
                        .value,
                    child: GestureDetector(
                      onTap: (){
                        controller.deleteBookmark(
                            newsModel, context: context);
                      },

                      child: const Icon(Icons.delete_forever,
                        color: Colors.grey,
                        size: 25,),
                    ),
                  ) :
                  GestureDetector(
                    onTap: (){
                      controller.bookmarkData(
                          newsModel,context: context);
                    },
                    child: const Icon(Icons.bookmark_add_outlined,
                      color: Colors.grey,
                      size: 25,),
                  );
                })

              ],),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              newsModel.description.toString(),
              textAlign: TextAlign.justify,
              style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
