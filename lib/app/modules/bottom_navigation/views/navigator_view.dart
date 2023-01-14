import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/app/modules/bottom_navigation/controllers/navigator_controller.dart';
import 'package:newsapp/app/routes/app_pages.dart';

import '../../../resources/app_colors.dart';

class NavigatorView extends GetView<NavigatorController> {
  const NavigatorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App'),
        centerTitle: true,
        elevation: 0,
        actions: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: controller.isLoggedIn.value
                  ? GestureDetector(
                      onTap: () {
                        controller.userLogout();
                      },
                      child: const Icon(Icons.logout))
                  : GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: const Icon(Icons.login)),
            );
          })
        ],
      ),
      body: Obx(() {
        return Stack(
          children: [
            IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.pages,
            ),
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
                      currentIndex: controller.selectedIndex.value,
                      onTap: (index) {
                        controller.selectedIndex.value = index;
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
        );
      }),
    );
  }
}
