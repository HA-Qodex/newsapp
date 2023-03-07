import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationProvider, int>(
    (ref) => NavigationProvider());

class NavigationProvider extends StateNotifier<int> {
  NavigationProvider() : super(0);

  void selectedRoute({required BuildContext context, required int index}) {
    state = index;
    switch (state) {
      case 0:
        context.goNamed('news');
        break;
      case 1:
        context.goNamed('bookmark');
        break;
      default:
    }
  }
}
