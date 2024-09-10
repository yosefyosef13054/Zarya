import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/item_card.dart';
import 'package:zarya/app/widgets/whatsapp.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppConstants.darkOffWhiteColor,
      floatingActionButton: Whatssapp(),
      appBar: AppBar(
        backgroundColor: AppConstants.darkOffWhiteColor,
        elevation: 2,
        toolbarHeight: 75,
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Obx(
                  () => Text(
                    controller.categoryName.value.length > 17
                        ? controller.categoryName.value.substring(0, 17) + '...'
                        : controller.categoryName.value,
                    maxLines: 3,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppConstants.mainColor),
                  ),
                ),
              ),
              // Spacer(),
              IconButton(
                onPressed: () {
                  var homeController = Get.put(HomeController());
                  homeController.isHome.value = !homeController.isHome.value;
                  homeController.isAnimated.value = false;
                  homeController.animatedFinish.value = false;
                  homeController.startAnimation.value = false;
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.home,
                  size: 30,
                  color: AppConstants.mainColor,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.apps,
                  size: 30,
                  color: AppConstants.mainColor,
                ),
              ),

              IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CART);
                },
                icon: Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: AppConstants.mainColor,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Obx(
        () => SafeArea(
            child: controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.subCategoryName.value,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: (170) / (220),
                                ),
                                itemBuilder: (ctx, pos) {
                                  return Center(
                                    child: Stack(
                                      children: [
                                        Padding(
                                          padding: controller.products[pos]
                                                  .nextCategoryStarted
                                              ? EdgeInsets.only(top: 15.0)
                                              : EdgeInsets.all(0),
                                          child: ItemCard(
                                            item: controller.products[pos],
                                          ),
                                        ),
                                        controller.products[pos]
                                                    .nextCategoryStarted &&
                                                pos != 0
                                            ? Positioned(
                                                top: 0,
                                                child: Text(
                                                  controller
                                                      .subCategoryName.value,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            : SizedBox(),
                                      ],
                                    ),
                                  );
                                },
                                itemCount: controller.products.length,
                              ),
                              Obx(() => controller.pageloading.value == true
                                  ? Center(child: CircularProgressIndicator())
                                  : Container())
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  )),
      ),
    );
  }
}
