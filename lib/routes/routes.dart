import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/modules/views/auth/login_view.dart';
import 'package:newsapp/modules/views/news_view.dart';
import 'package:newsapp/routes/route_name.dart';
import 'package:path/path.dart';
import '../modules/views/bookmark_view.dart';
import '../modules/views/details_view.dart';
import '../modules/views/home_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter =
    GoRouter(initialLocation: '/', navigatorKey: _rootNavigatorKey, routes: [
  ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
            path: '/',
            name: AppRoute.news,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: const NewsView(),
                transitionDuration: const Duration(milliseconds: 300),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(-1.0, 0.0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeIn)),
                          ),
                          child: child,
                        ))),
        GoRoute(
            path: '/bookmark',
            name: AppRoute.bookmark,
            parentNavigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state) => CustomTransitionPage(
                child: const BookmarkView(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        SlideTransition(
                          position: animation.drive(
                            Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeIn)),
                          ),
                          child: child,
                        ))),
      ]),
  GoRoute(
      path: '/detail/:hero',
      name: AppRoute.details,
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => DetailsView(
            newsModel: state.extra as NewsModel,
            tag: state.params['hero']!,
          )),
  GoRoute(
    path: '/${AppRoute.login}',
    name: AppRoute.login,
    parentNavigatorKey: _rootNavigatorKey,
    builder: (context, state) => const LoginView()
  )
]);
