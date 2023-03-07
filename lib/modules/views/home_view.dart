import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../resources/app_colors.dart';
import '../providers/navigation_provider.dart';

class HomePage extends HookConsumerWidget {
  final Widget child;
  const HomePage({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);
    return Scaffold(
      body: Stack(
          children: [
            child,
            Positioned.fill(
              bottom: 10,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BottomNavigationBar(
                      backgroundColor: AppColors.primary,
                      // selectedItemColor: AppColors.primary,
                      showSelectedLabels: false,
                      showUnselectedLabels: false,
                      currentIndex: selectedIndex,
                      onTap: (index) {
                        ref.read(navigationProvider.notifier).selectedRoute(context: context, index: index);
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: const Icon(
                              Icons.newspaper,
                              size: 25,
                              color: Colors.white,
                            ),
                            activeIcon: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: const Icon(
                                  Icons.newspaper,
                                  size: 25,
                                )),
                            label: '',
                            backgroundColor: AppColors.primary),
                        BottomNavigationBarItem(
                            icon: const Icon(
                              Icons.bookmark_added_outlined,
                              size: 25,
                              color: Colors.white,
                            ),
                            activeIcon: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white),
                                child: const Icon(
                                  Icons.bookmark_added,
                                  size: 25,
                                )),
                            label: '',
                            backgroundColor: AppColors.primary),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
    );
  }
}
