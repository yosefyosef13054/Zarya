import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/models/product.dart';
import 'package:zarya/app/routes/app_pages.dart';

class ItemCard extends StatelessWidget {
  final Product item;
  var formatter = NumberFormat.decimalPattern();
  ItemCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var name = ''.obs;
    // item.name.
    for (var i = 0; i < item.name.length; i++) {
      if (item.name[i] == 'R' && item.name[i + 1] == 's') {
        break;
      }
      name.value = name.value + item.name[i];
    }
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.VIEW_ITEM, arguments: item);
      },
      child: Stack(
        children: [
          Card(
            elevation: 2,
            shadowColor: AppConstants.greyColor.withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// animal image
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0)),
                  child: Container(
                      width: double.infinity,
                      height: height * 0.18,
                      child: item.images.isEmpty
                          ? Container()
                          : CachedNetworkImage(
                              imageUrl: item.thumbnail,
                              // fit: BoxFit.c,
                            )),
                ),
                SizedBox(
                  height: 7,
                ),
                // Spacer(),

                /// item details
                Padding(
                  padding: const EdgeInsets.only(left: 14.0),
                  child: Text(
                    name.value.length > 15
                        ? name.value.substring(0, 15)
                        : name.value,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                // Spacer(),
                // Spacer(),
                SizedBox(
                  height: height * 0.015,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0, bottom: 0.0),
                      child: Text(
                        'Rs ' + formatter.format(item.price.toInt()),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.mainColor),
                      ),
                    ),
                    item.retailPrice == 0
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20)),
                              color: AppConstants.lightBlackColor,
                            ),
                            height: height * 0.03,
                            width: width * 0.2,
                            child: Center(
                                child: Text(
                              'Rs.${formatter.format((item.retailPrice - item.price).toInt())} OFF',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: AppConstants.lightWhiteColor),
                            )),
                          ),
                  ],
                )
              ],
            ),
          ),
          // item.retailPrice == 0
          //     ? Container()
          //     : Positioned(
          //         child: Container(
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.only(
          //                 topLeft: Radius.circular(20),
          //                 bottomLeft: Radius.circular(20)),
          //             color: AppConstants.lightBlackColor,
          //           ),
          //           height: height * 0.03,
          //           width: width * 0.2,
          //           child: Center(
          //               child: Text(
          //             'Rs.${formatter.format((item.retailPrice - item.price).toInt())} OFF',
          //             style: TextStyle(
          //                 fontWeight: FontWeight.w700,
          //                 fontSize: 10,
          //                 color: AppConstants.lightWhiteColor),
          //           )),
          //         ),
          //         bottom: 10,
          //         right: 4,
          //       ),
        ],
      ),
    );
  }
}
