import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:newsapp/modules/providers/firebase_provider.dart';

import '../views/news_view.dart';

final authProvider =
    StateNotifierProvider.family<AuthProvider, bool, BuildContext>(
        (ref, context) => AuthProvider(ref, context));

class AuthProvider extends StateNotifier<bool> {
  final Ref ref;
  final BuildContext context;

  AuthProvider(this.ref, this.context) : super(false);

  void login({required String email, required String password}) async {
    state = true;
    final auth = ref.watch(firebaseProvider);
    try {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        ref.read(authCheck.notifier).state = auth.currentUser;
        context.pop();
      });
      state = false;
    } on FirebaseAuthException catch (e) {
      state = false;
      Flushbar(
        title: "Login Failed",
        titleColor: Colors.red,
        message: e.message,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.red,
        ),
      ).show(context);
    }
  }

  void signOut() async {
    final auth = ref.watch(firebaseProvider);
    try {
      await auth.signOut().then((value) {
        ref.read(authCheck.notifier).state = auth.currentUser;
        Flushbar(
          title: "Sign Out",
          titleColor: Colors.green,
          message: "You have successfully signed out",
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 3),
          icon: const Icon(
            Icons.check,
            size: 30,
            color: Colors.green,
          ),
        ).show(context);
      });
    } on FirebaseAuthException catch (e) {
      Flushbar(
        title: "Login Failed",
        titleColor: Colors.red,
        message: e.message,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.error_outline,
          size: 30,
          color: Colors.red,
        ),
      ).show(context);
    }
  }
}
