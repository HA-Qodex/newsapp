import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Future appFlashbar(
    {required BuildContext context,
    required String title,
    required Color titleColor,
    required String message,
    required Icon icon}) {
  return Flushbar(
    title: title,
    titleColor: titleColor,
    message: message,
    duration: const Duration(seconds: 3),
    icon: icon
  ).show(context);
}
