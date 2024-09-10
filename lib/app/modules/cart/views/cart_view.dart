import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/cart_item.dart';
import 'package:zarya/app/widgets/custom_appbar.dart';
import 'package:zarya/app/widgets/custom_button.dart';
import 'package:zarya/app/widgets/delivery_details.dart';
import 'package:zarya/app/widgets/order_confirmed.dart';
import 'package:zarya/app/widgets/shopping_cart.dart';
import 'package:zarya/app/widgets/whatsapp.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final _form = GlobalKey<FormState>();

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(controller.customerNameController.text);
    controller.orderComplete();
    controller.orderSecquence.value += 1;
    controller.update();
  }

  var homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GetBuilder<CartController>(
      init: CartController(),
      builder: (_) => Scaffold(
        backgroundColor: AppConstants.darkOffWhiteColor,
        bottomNavigationBar: controller.cartOrder.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 25.0),
                child: Row(
                  children: [
                    Whatssapp(),
                    SizedBox(
                      width: 30,
                    ),
                    controller.orderSecquence.value == 0
                        ? CustomButton(
                            onPressed: () {
                              homeController.isHome.value = true;
                              homeController.isAnimated.value = false;
                              homeController.animatedFinish.value = false;
                              homeController.startAnimation.value = false;
                              // controller.orderFull();
                              controller.orderSecquence.value += 1;
                              controller.update();
                              print(controller.orderSecquence.value);
                            },
                            widget: Text('proceed'.tr),
                          )
                        : controller.orderSecquence.value == 1
                            ? CustomButton(
                                onPressed: () {
                                  _saveForm();
                                },
                                widget: Text('placeorder'.tr))
                            : CustomButton(
                                onPressed: () {
                                  controller.cartOrder.clear();
                                  controller.orderSecquence.value = 0;
                                  Get.toNamed(Routes.HOME);
                                },
                                widget: Text('backhome'.tr)),
                  ],
                ),
              ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: controller.cartOrder.isEmpty
                ? Column(
                    children: [
                      CustomAppBar('mycart'.tr),
                      SizedBox(
                        height: height * 0.4,
                      ),
                      Center(
                        child: Text(
                          'emptycart'.tr,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: AppConstants.mainColor),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          controller.orderSecquence.value == 2
                              ? SizedBox(
                                  width: width * .05,
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: controller.orderSecquence.value != 2
                                ? InkWell(
                                    onTap: () {
                                      controller.orderSecquence.value == 0
                                          ? Navigator.of(context).pop()
                                          : controller.orderSecquence.value -=
                                              1;
                                      controller.update();
                                    },
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: AppConstants.mainColor,
                                      size: 25,
                                    ),
                                  )
                                : SizedBox(),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppConstants.mainColor,
                            child: CircleAvatar(
                              radius: 18,
                              child: Icon(
                                Icons.shopping_cart,
                                size: 20,
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: width * 0.235,
                            color: AppConstants.lightMainColor,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppConstants.mainColor,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  controller.orderSecquence.value >= 1
                                      ? AppConstants.mainColor
                                      : AppConstants.lightWhiteColor,
                              child: Icon(
                                Icons.list_alt,
                                size: 20,
                              ),
                            ),
                          ),
                          Container(
                            height: 2,
                            width: width * 0.235,
                            color: AppConstants.lightMainColor,
                          ),
                          CircleAvatar(
                            radius: 20,
                            backgroundColor: AppConstants.mainColor,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor:
                                  controller.orderSecquence.value == 2
                                      ? AppConstants.mainColor
                                      : AppConstants.lightWhiteColor,
                              child: Icon(
                                Icons.check,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.09,
                            ),
                            Text(
                              'shopcart'.tr,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.greyColor),
                            ),
                            SizedBox(
                              width: width * 0.15,
                            ),
                            Text(
                              'delvdetal'.tr,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.greyColor),
                            ),
                            SizedBox(
                              width: width * 0.15,
                            ),
                            Text(
                              'orderconf',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.greyColor),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      if (controller.orderSecquence.value == 0) ShoppingCart(),
                      if (controller.orderSecquence.value == 1)
                        DeliveryDetails(_form),
                      if (controller.orderSecquence.value == 2)
                        OredrConfirmed(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
