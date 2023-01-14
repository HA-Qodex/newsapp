import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/app/modules/news/controllers/news_controller.dart';

import '../../../resources/app_colors.dart';
import 'news_details_view.dart';

class NewsView extends StatelessWidget {
  NewsView({Key? key}) : super(key: key);

  final controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() {
          return Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Stack(
                children: [
                  CarouselSlider(
                    items: controller.newsSliderList.map((image) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          width: width,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(image.urlToImage.toString()),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 15.0, left: 10, right: 10),
                                child: Text(
                                  image.title.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14, color: Colors.white),
                                ),
                              )),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                        height: height * 0.25,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        autoPlayInterval: const Duration(seconds: 5),
                        viewportFraction: 1,
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        initialPage: 0,
                        onPageChanged: (index, _) {
                          controller.carouselIndex.value = index;
                        }),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 50,
                    left: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: controller.map<Widget>(
                          controller.newsSliderList, (index, directory) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Icon(Icons.circle,
                              size: 10,
                              color: controller.carouselIndex == index
                                  ? AppColors.primary
                                  : Colors.white),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child:
                controller.isLoading.value?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      const CircularProgressIndicator(),
                      const SizedBox(width: 15,),
                      Text('Loading...',style: GoogleFonts.roboto(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.grey),)
                    ],):
                ListView.builder(
                    itemCount: controller.newsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                () => NewsDetailsView(
                                    newsModel: controller.newsList[index]),
                                transition: Transition.rightToLeft,
                                curve: Curves.easeIn,
                                duration: const Duration(milliseconds: 300));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey.shade300)),
                            child: Row(
                              children: [
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl: controller
                                          .newsList[index].urlToImage
                                          .toString(),
                                      fit: BoxFit.fill,
                                      errorWidget: (context, error, _) =>
                                          const Icon(
                                        Icons.error_outline,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.newsList[index].title
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          DateFormat('dd MMM, yyyy').format(
                                              DateTime.parse(controller
                                                  .newsList[index].publishedAt
                                                  .toString())),
                                          style: GoogleFonts.lato(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                        Visibility(
                                          visible: !controller.bookmarkList.any((element) => element.title == controller
                                              .newsList[index].title),
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.bookmarkData(
                                                  controller.newsList[index],context: context);
                                            },
                                            child: const Icon(
                                              Icons.bookmark_add_outlined,
                                              color: Colors.grey,
                                              size: 25,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ))
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          );
        }),
      ),
    );
  }
}
