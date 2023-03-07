import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/news_model.dart';

import '../../resources/app_colors.dart';

class DetailsView extends StatelessWidget {
  final NewsModel newsModel;
  final String tag;
  const DetailsView({Key? key, required this.newsModel, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Hero(
            tag: "photo$tag",
            child: Container(
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
                    GestureDetector(onTap: (){
                      context.pop();
                    },child: const Icon(Icons.arrow_back_ios_new, color: Colors.white,))
                  ],),
                ),
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

                  GestureDetector(
                    onTap: (){
                    },
                    child: const Icon(Icons.bookmark_add_outlined,
                      color: Colors.grey,
                      size: 25,),
                  )

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
