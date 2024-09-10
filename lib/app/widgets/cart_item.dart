import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';

class CartItem extends StatelessWidget {
  CartItem(
      {required this.image,
      required this.price,
      required this.quantity,
      required this.title,
      required this.view,
      required this.itemId,
      this.itemEarning = 0.0});
  final String image;
  final String title;
  final String price;
  final int quantity;
  final String view;
  final int itemId;
  final double itemEarning;

  var cartController = Get.put(CartController());
  var formatter = NumberFormat.decimalPattern();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var name = ''.obs;
    // item.name.
    for (var i = 0; i < title.length; i++) {
      if (title[i] == 'R' && title[i + 1] == 's') {
        break;
      }
      name.value = name.value + title[i];
    }
    return Container(
      // height: height * 0.15,
      padding: EdgeInsets.all(5),
      width: width,
      child: Card(
        elevation: 2,
        shadowColor: AppConstants.greyColor.withOpacity(0.4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// item image
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Container(
                height: height * 0.1,
                width: width * 0.35,
                child: image == '' ? Container() : Image.network(image),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.value,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    'qt'.tr + '   $quantity',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: view == 'shopping_cart'
                            ? AppConstants.lightMainColor
                            : AppConstants.greyColor),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 8.0, top: 40.0),
            //   child: Container(
            //     width: width * 0.15,
            //     height: height * 0.04,
            //     decoration: BoxDecoration(
            //       border: Border.all(
            //         color: AppConstants.greyColor,
            //       ),
            //       borderRadius: BorderRadius.circular(5.0),
            //       color: AppConstants.darkOffWhiteColor,
            //     ),
            //     child: Center(
            //         child: Text(
            //       '12Y',
            //       style: TextStyle(
            //         color: AppConstants.greyColor,
            //       ),
            //     )),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Rs. ${formatter.format(double.parse(price).toInt())}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: view == 'shopping_cart'
                            ? AppConstants.lightMainColor
                            : AppConstants.greyColor),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  view == 'shopping_cart'
                      ? InkWell(
                          onTap: () {
                            cartController.deleteItem(
                                itemId, price, itemEarning);
                          },
                          child: Icon(
                            Icons.delete,
                            color: AppConstants.greyColor,
                          ),
                        )
                      : SizedBox(
                          height: height * 0.025,
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
