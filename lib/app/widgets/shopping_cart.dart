import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';

import 'cart_item.dart';

class ShoppingCart extends StatelessWidget {
  ShoppingCart({Key? key}) : super(key: key);

  var cartController = Get.put(CartController());
  var formatter = NumberFormat.decimalPattern();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    cartController.calcTotalOrderPrice();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GetBuilder<CartController>(
          init: CartController(),
          builder: (_) => Container(
            height: height * .45,
            child: ListView.builder(
                itemCount: cartController.cartOrder.length,
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemBuilder: (ctx, i) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: GetBuilder<CartController>(
                      init: CartController(), // INIT IT ONLY THE FIRST TIME
                      builder: (_) => CartItem(
                        image: cartController.cartOrder[i].image,
                        title: cartController.cartOrder[i].name,
                        price: cartController.cartOrder[i].price.toString(),
                        quantity: cartController.cartOrder[i].quantity,
                        itemId: cartController.cartOrder[i].itemId,
                        itemEarning: cartController.cartOrder[i].itemEarning,
                        view: 'shopping_cart',
                      ),
                    ),
                  );
                }),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '${cartController.cartOrder.length} ' + 'itemsqt'.tr,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 11,
                color: AppConstants.lightBlackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, bottom: 10.0, right: 10.0, top: 10.0),
          child: Row(
            children: [
              Text(
                'delv'.tr,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppConstants.greyColor),
              ),
              Spacer(),
              Text(
                'Rs.200',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppConstants.greyColor),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, bottom: 10.0, right: 10.0, top: 10.0),
          child: Row(
            children: [
              Text(
                'total'.tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Spacer(),
              Text(
                'Rs. ${formatter.format((cartController.totalOrderPrice.value + 200.toInt()))}',
                // 'Rs. ${cartController.totalEarnings.value.toInt()} ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: Center(
              child: Text(
                  'totalearning'.tr +
                      ' Rs. ${(formatter.format(cartController.totalEarnings.value.toInt()))}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))),
        ),
      ],
    );
  }
}
