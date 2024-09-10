import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/helpers/localization_service.dart';
import 'package:zarya/app/modules/categories/views/categories_view.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/category_type.dart';
import 'package:zarya/app/widgets/custom_button.dart';
import 'package:zarya/app/widgets/item_card.dart';
import 'package:zarya/app/widgets/whatsapp.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  startTime() async {
    controller.animatedFinish.value = true;
    controller.isAnimated.value = true;
    controller.startAnimation.value = true;
    //animation
    // Future.delayed(const Duration(milliseconds: 50), () {
    //   controller.isAnimated.value = true;
    // });
    // Future.delayed(const Duration(seconds: 1), () {
    //   categoryAnimation();
    //   controller.startAnimation.value = true;
    // });
  }

  categoryAnimation() async {
    //animation
    // Future.delayed(const Duration(milliseconds: 100), () {
    //   controller.animatedFinish.value = true;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        backgroundColor: AppConstants.darkOffWhiteColor,
        floatingActionButton:
            controller.isHome.value ? Whatssapp() : SizedBox(),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        appBar: AppBar(
          backgroundColor: AppConstants.darkOffWhiteColor,
          elevation: 2,
          toolbarHeight: 75,
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              if (controller.isHome.value)
                PopupMenuButton(
                  itemBuilder: (ctx) => [
                    // PopupMenuItem(
                    //   child: InkWell(
                    //     onTap: () async {
                    //       print(Get.locale!.languageCode);
                    //       Get.locale!.languageCode == 'ar'
                    //           ? LocalizationService().changeLocale('English')
                    //           : LocalizationService().changeLocale('Arabic');
                    //       print(Get.locale!.languageCode);
                    //     },
                    //     child: Text(
                    //       'Change Langauge',
                    //       style: TextStyle(
                    //         color: AppConstants.mainColor,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    PopupMenuItem(
                      child: InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('token');
                          prefs.remove('user');
                          Get.toNamed(Routes.ON_BOARDING);
                        },
                        child: Text(
                          'logout'.tr,
                          style: TextStyle(
                            color: AppConstants.mainColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Icon(
                      Icons.more_vert,
                      color: AppConstants.mainColor,
                      size: 30,
                    ),
                  ),
                  onSelected: (selectedValue) {},
                ),

              if (!controller.isHome.value && controller.startAnimation.value)
                Container(
                  height: 50,
                  width: width * 0.9,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                        top: 15,
                        left: controller.animatedFinish.value ? 0 : 200,
                        //animation
                        //  duration: Duration(milliseconds: 1000),
                        duration: Duration(milliseconds: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 8.0, left: 8.0),
                              child: InkWell(
                                onTap: () {
                                  controller.isHome.value =
                                      !controller.isHome.value;
                                  controller.isAnimated.value = false;
                                  controller.animatedFinish.value = false;
                                  controller.startAnimation.value = false;
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  color: AppConstants.mainColor,
                                  size: 25,
                                ),
                              ),
                            ),
                            Text(
                              'categories'.tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppConstants.mainColor),
                            ),
                            SizedBox(
                              width: width * .3,
                            ),
                            Icon(
                              Icons.apps,
                              size: 30,
                              color: AppConstants.mainColor,
                            ),
                            // Spacer(),
                            SizedBox(
                              width: 8,
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
                    ],
                  ),
                ),

              if (!controller.startAnimation.value)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: width * 0.4,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          //animation
                          //  duration: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 0),
                          top: 0,
                          left: controller.isAnimated.value ? 200 : 0,
                          child: CustomButton(
                            onPressed: () async {
                              controller.isHome.value =
                                  !controller.isHome.value;
                              startTime();
                              // categoryAnimation();
                            },
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.apps,
                                  size: 30,
                                  color: AppConstants.darkOffWhiteColor,
                                ),
                                Text(
                                  'categories'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            width: width * 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              //  controller.isAnimated.value?
              if (!controller.startAnimation.value)
                SizedBox(
                  width: width * 0.05,
                ),
              if (!controller.startAnimation.value)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 50,
                    width: width * 0.4,
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          //animation
                          // duration: Duration(milliseconds: 1000),
                          duration: Duration(milliseconds: 0),
                          top: 0,
                          left: controller.isAnimated.value ? 200 : 0,
                          // right: controller.isAnimated.value ? 20 : 0,
                          child: CustomButton(
                            onPressed: () {
                              Get.toNamed(Routes.CART);
                            },
                            widget: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.shopping_cart,
                                  size: controller.isHome.value ? 25 : 30,
                                  color: AppConstants.darkOffWhiteColor,
                                ),
                                Text(
                                  'mycart'.tr,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            width: width * 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        body: controller.isHome.value
            ? Obx(
                () => SafeArea(
                  child: controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          controller: controller.scrollController,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              // SizedBox(
                              //   height: height * 0.03,
                              // ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 25,
                                  ),
                                  Text(
                                    'Featured Items',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: GridView.builder(
                                  // controller: controller.scrollController,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: (170) / (220),
                                  ),
                                  itemBuilder: (ctx, pos) {
                                    return Center(
                                      child: ItemCard(
                                        item: controller.products[pos],
                                      ),
                                    );
                                  },
                                  itemCount: controller.products.length,
                                ),
                              ),
                              Obx(() => controller.pageloading.value == true
                                  ? Center(child: CircularProgressIndicator())
                                  : Container())
                            ],
                          ),
                        ),
                ),
              )
            : SafeArea(
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // CustomAppBar('Categories'),

                              AnimationLimiter(
                                child: ListView.builder(
                                    itemCount: controller.mainCategory.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(16.0),
                                    itemBuilder: (ctx, i) {
                                      return AnimationConfiguration
                                          .staggeredList(
                                        position: i,
                                        duration:
                                            const Duration(milliseconds: 600),
                                        child: SlideAnimation(
                                          verticalOffset: 50.0,
                                          child: FadeInAnimation(
                                            child: CategoryType(
                                                controller.mainCategory[i]),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
      ),
    );
  }
}
