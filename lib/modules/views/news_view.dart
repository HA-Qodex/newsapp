import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/modules/providers/db_provider.dart';
import 'package:newsapp/modules/providers/firebase_provider.dart';
import 'package:newsapp/routes/route_name.dart';
import 'package:newsapp/services/news_provider_service.dart';

import '../providers/auth_provider.dart';

final authCheck = StateProvider<User?>((ref) {
  return ref.watch(firebaseProvider).currentUser;
});

final newsProvider =
    FutureProvider((ref) => ref.watch(newsProviderService).getNews());
final sliderIndex = StateProvider<int>((ref) => 0);

class NewsView extends HookConsumerWidget {
  const NewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final news = ref.watch(newsProvider);
    final user = ref.watch(authCheck);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: user?.email != null
                  ? GestureDetector(
                      onTap: () async {
                        ref.read(authProvider(context).notifier).signOut();
                      },
                      child: const Icon(
                        Icons.logout,
                        size: 25,
                      ))
                  : GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.login);
                      },
                      child: const Icon(
                        Icons.login,
                        size: 25,
                      )),
            );
          })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            news.when(
                data: (data) {
                  return Stack(
                    children: [
                      CarouselSlider(
                        items: data.map((image) {
                          return Builder(builder: (BuildContext context) {
                            return Container(
                              width: width,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        image.urlToImage.toString()),
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
                            autoPlayAnimationDuration:
                                const Duration(seconds: 1),
                            initialPage: 0,
                            onPageChanged: (index, _) {
                              ref.read(sliderIndex.notifier).state = index;
                            }),
                      ),
                    ],
                  );
                },
                error: (error, _) => const Icon(Icons.error),
                loading: () => const CircularProgressIndicator()),
            const SizedBox(
              height: 15,
            ),
            Expanded(
                child: news.when(
                    data: (data) => ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: GestureDetector(
                              onTap: () {
                                context.pushNamed('details',
                                    params: {"hero": index.toString()},
                                    extra: data[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: Colors.grey.shade300)),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      height: 64,
                                      width: 64,
                                      child: Hero(
                                        tag: "photo$index",
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: data[index]
                                                .urlToImage
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
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data[index].title.toString(),
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
                                                  DateTime.parse(data[index]
                                                      .publishedAt
                                                      .toString())),
                                              style: GoogleFonts.lato(
                                                  fontSize: 12,
                                                  color: Colors.grey),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                ref.read(databaseProvider(context)).value?.insertData(newsModel: NewsModel(title: data[index].title, description: data[index].description, urlToImage: data[index].urlToImage, publishedAt: data[index].publishedAt));
                                              },
                                              child: const Icon(
                                                Icons.bookmark_add_outlined,
                                                color: Colors.grey,
                                                size: 25,
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
                    error: (error, _) => const Icon(Icons.error),
                    loading: () => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Loading...',
                              style: GoogleFonts.roboto(
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.grey),
                            )
                          ],
                        ))),
          ],
        ),
      ),
    );
  }
}
