import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/category_type.dart';
import 'package:zarya/app/widgets/custom_appbar.dart';

import '../controllers/categories_controller.dart';

class CategoriesView extends GetView<CategoriesController> {
  var homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.darkOffWhiteColor,
        elevation: 2,
        // toolbarHeight: 75,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: AppConstants.mainColor,
                    size: 25,
                  ),
                ),
              ),
              // SizedBox(
              //   width: width * 0.05,
              // ),
              Expanded(
                child: Text(
                  'Categories',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: AppConstants.mainColor),
                ),
              ),
              // Spacer(),
              AnimatedContainer(
                duration: Duration(microseconds: 50),
                child: Icon(
                  Icons.apps,
                  size: 30,
                  color: AppConstants.mainColor,
                ),
              ),
              SizedBox(
                width: width * 0.05,
              ),
              AnimatedContainer(
                duration: Duration(microseconds: 50),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.CART);
                  },
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: AppConstants.mainColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // PreferredSize(
      //   child: CustomAppBar('Categories'),
      //   preferredSize: Size(double.infinity, 65),
      // ),
      backgroundColor: AppConstants.darkOffWhiteColor,
      body: SafeArea(
        child: Obx(
          () => homeController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // CustomAppBar('Categories'),
                      ListView.builder(
                          itemCount: homeController.mainCategory.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(16.0),
                          itemBuilder: (ctx, i) {
                            return CategoryType(homeController.mainCategory[i]);
                          }),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
