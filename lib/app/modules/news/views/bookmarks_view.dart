import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/app/modules/bottom_navigation/controllers/navigator_controller.dart';

import '../controllers/news_controller.dart';
import 'news_details_view.dart';

class BookmarkView extends StatelessWidget {
  BookmarkView({Key? key}) : super(key: key);

  final controller = Get.put(NewsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Obx(() {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
              itemCount: controller.bookmarkList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                              () =>
                              NewsDetailsView(
                                  newsModel: controller.bookmarkList[index]),
                          transition: Transition.rightToLeft,
                          curve: Curves.easeIn,
                          duration: const Duration(milliseconds: 300));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 64,
                            width: 64,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: controller
                                    .bookmarkList[index].urlToImage
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
                                    controller.bookmarkList[index].title
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
                                                .bookmarkList[index].publishedAt
                                                .toString())),
                                        style: GoogleFonts.lato(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Obx(() {
                                        return Visibility(
                                          visible: Get
                                              .find<NavigatorController>()
                                              .isLoggedIn
                                              .value,
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.deleteBookmark(
                                                  controller
                                                      .bookmarkList[index], context: context);
                                            },
                                            child: const Icon(
                                              Icons.delete_forever,
                                              color: Colors.grey,
                                              size: 25,
                                            ),
                                          ),
                                        );
                                      })
                                    ],
                                  )
                                ],
                              ))
                        ],
                      ),
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }
}
