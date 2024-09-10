import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: AppConstants.darkOffWhiteColor,
      elevation: 2,
      // toolbarHeight: 75,
      titleSpacing: 0.0,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: AppConstants.mainColor,
                size: 25,
              ),
            ),
            // SizedBox(
            //   width: width * 0.05,
            // ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppConstants.mainColor),
              ),
            ),
            // Spacer(),
            IconButton(
              onPressed: () {
                var homeController = Get.put(HomeController());
                homeController.isHome.value = true;
                homeController.isAnimated.value = false;
                homeController.animatedFinish.value = false;
                homeController.startAnimation.value = false;
                Get.toNamed(Routes.HOME);
              },
              icon: Icon(
                Icons.home,
                size: 30,
                color: AppConstants.mainColor,
              ),
            ),
            Icon(
              Icons.apps,
              size: 30,
              color: AppConstants.mainColor,
            ),
            SizedBox(
              width: width * 0.05,
            ),
            InkWell(
              onTap: () {
                Get.toNamed(Routes.CART);
              },
              child: Icon(
                Icons.shopping_cart,
                size: 30,
                color: AppConstants.mainColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
