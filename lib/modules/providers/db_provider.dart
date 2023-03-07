import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/db/database_helper.dart';
import 'package:newsapp/models/news_model.dart';

final databaseProvider = FutureProvider.family<DatabaseProvider, BuildContext>(
    (ref, context) => DatabaseProvider(context: context));

class DatabaseProvider {
  DatabaseProvider({required this.context});

  final BuildContext context;

  Future<void> insertData({required NewsModel newsModel}) async {
    await DatabaseHelper.instance
        .insertData(newsModel)
        .then((value) => Flushbar(
              title: "Bookmarked",
              titleColor: Colors.green,
              message: "This news has been added to your bookmark",
              flushbarPosition: FlushbarPosition.TOP,
              duration: const Duration(seconds: 3),
              icon: const Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              ),
            ).show(context));
  }
}
