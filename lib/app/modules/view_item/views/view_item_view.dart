import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:share_plus/share_plus.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/models/product.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/custom_appbar.dart';
import 'package:zarya/app/widgets/custom_button.dart';
import 'package:zarya/app/widgets/item_images.dart';
import 'package:zarya/app/widgets/quantity.dart';
import 'package:zarya/app/widgets/whatsapp.dart';
import 'package:http/http.dart' as http;
import '../controllers/view_item_controller.dart';

class ViewItemView extends GetView<ViewItemController> {
  final dataArguments = Get.arguments as Product;
  var cartController = Get.find<CartController>();
  var formatter = NumberFormat.decimalPattern();
  final List<String> imgList = [
    'assets/images/image 5.png',
  ];
  List<String> images = [];

  void getImages() {
    for (var i = 0; i < dataArguments.images.length; i++) {
      images.add(dataArguments.images[i]['url']);
    }
  }

  var expand = false.obs;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var name = ''.obs;
    var isLong = dataArguments.description.length >= 40;
    var desc = isLong
        ? dataArguments.description.substring(0, 40)
        : dataArguments.description;
    // var isQuantity = dataArguments.options.isNotEmpty
    //     ? dataArguments.options[controller.selectedAge.value - 1]['quantity']
    //     : dataArguments.quantity;
    // item.name.
    for (var i = 0; i < dataArguments.name.length; i++) {
      if (dataArguments.name[i] == 'R' && dataArguments.name[i + 1] == 's') {
        break;
      }
      name.value = name.value + dataArguments.name[i];
    }
    getImages();
    return GetBuilder<ViewItemController>(builder: (ctx) {
      return Scaffold(
        appBar: PreferredSize(
          child: CustomAppBar(name.value),
          preferredSize: Size(double.infinity, 65),
        ),
        backgroundColor: AppConstants.darkOffWhiteColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20.0, bottom: 25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Whatssapp(),
              SizedBox(
                width: width * 0.05,
              ),
              CustomButton(
                onPressed: () {
                  // if (dataArguments.options.isNotEmpty) {
                  controller.calcToalPrice(
                      dataArguments.price, cartController.quantity.value);
                  showBottomSheet(context, width);
                  // }
                  // else {
                  //   Alert(
                  //     context: context,
                  //     type: AlertType.error,
                  //     title: "Warning",
                  //     desc: "The Item Is Out Of Stock",
                  //     buttons: [
                  //       DialogButton(
                  //         child: Text(
                  //           "OKAY",
                  //           style: TextStyle(color: Colors.white, fontSize: 20),
                  //         ),
                  //         onPressed: () => Navigator.pop(context),
                  //         width: 120,
                  //       )
                  //     ],
                  //   ).show();
                  // }
                },
                widget: Text('sellitem'.tr),
              ),
            ],
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25,
                ),
                // Center(
                //   child: Container(
                //     margin: EdgeInsets.all(5.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //       child: Image.network(
                //         dataArguments.image,
                //         fit: BoxFit.contain,
                //         width: width,
                //         height: height * 0.3,
                //       ),
                //     ),
                //   ),
                // ),
                // Image.network(dataArguments.image),
                // ItemImages(),
                // Center(
                //   child: Container(
                //     margin: EdgeInsets.all(5.0),
                //     child: ClipRRect(
                //       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                //       child: Image.network(
                //         dataArguments.image,
                //         fit: BoxFit.fill,
                //         width: width,
                //         height: height * 0.3,
                //       ),
                //     ),
                //   ),
                // ),
                ItemImages(
                    images,
                    height,
                    width,
                    dataArguments.images.isEmpty ? true : false,
                    dataArguments.name,
                    dataArguments.description),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Rs ' +
                            formatter
                                .format(dataArguments.price.toInt())
                                .toString(),
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.lightBlackColor),
                      ),
                    ),
                    dataArguments.retailPrice == 0
                        ? Container()
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: AppConstants.lightBlackColor,
                            ),
                            height: 33,
                            width: width * 0.2,
                            child: Center(
                                child: Text(
                              'Rs.${formatter.format((dataArguments.retailPrice - dataArguments.price).toInt())} OFF',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                  color: AppConstants.lightWhiteColor),
                            )),
                          ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: InkWell(
                        onTap: () async {
                          final url = Uri.parse(dataArguments.thumbnail);
                          final response = await http.get(url);
                          final bytes = response.bodyBytes;

                          final temp = await getTemporaryDirectory();
                          final path = '${temp.path}/image.jpg';
                          File(path).writeAsBytesSync(bytes);
                          Share.shareFiles([path],
                              text: '$name \n${dataArguments.description}');
                        },
                        child: Icon(
                          Icons.share,
                          color: AppConstants.mainColor,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    for (int i = 1; i <= dataArguments.options.length; i++)
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.selectedAge.value = i;
                              controller.update();
                            },
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: controller.selectedAge.value == i
                                  ? AppConstants.lightBlackColor
                                  : AppConstants.lightWhiteColor,
                              child: Center(
                                child: Text(
                                  dataArguments.options[i - 1]['name'],
                                  style: TextStyle(
                                      color: controller.selectedAge.value == i
                                          ? AppConstants.lightWhiteColor
                                          : AppConstants.lightBlackColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            expand.value ? dataArguments.description : desc,
                            maxLines: 50,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.greyColor),
                          ),
                        ),
                        //dd
                        isLong == true
                            ? Align(
                                alignment: Alignment.topRight,
                                child: InkWell(
                                  onTap: () {
                                    expand.value = !expand.value;
                                    print(expand.value);
                                  },
                                  child: Icon(
                                    expand.value
                                        ? Icons.keyboard_arrow_up
                                        : Icons.keyboard_arrow_down,
                                    color: AppConstants.mainColor,
                                    size: 35,
                                  ),
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                ),
                // ListTile(
                //   leading: Text(
                //     'Seller Price',
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                //   ),
                //   trailing: Text(
                //     formatter.format(dataArguments.price.toInt()),
                //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                //   ),
                // ),
              ],
            ),
          ),
        )),
      );
    });
  }

  void showBottomSheet(context, width) => showModalBottomSheet(
        backgroundColor: AppConstants.darkOffWhiteColor,
        enableDrag: false,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        context: context,
        builder: (ctx) {
          controller.isDeliver.value = false;
          cartController.quantity.value = 1;
          var quantities = dataArguments.options.isNotEmpty
              ? dataArguments.options[controller.selectedAge.value - 1]
                  ['quantity']
              : dataArguments.quantity;
          print(quantities);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Transform.scale(
                      scale: 0.7,
                      child: CupertinoSwitch(
                          activeColor: AppConstants.mainColor,
                          value: controller.isDeliver.value,
                          onChanged: (value) {
                            controller.isDeliver.value = value;
                            if (controller.isDeliver.value) {
                              controller.totalPrice.value +=
                                  controller.profit.value;
                              // cartController.totalEarnings.value +=
                              //     controller.profit.value;
                            }
                            if (!controller.isDeliver.value) {
                              controller.totalPrice.value -=
                                  controller.profit.value;
                              // cartController.totalEarnings.value -=
                              //     controller.profit.value;
                            }
                          }),
                    ),
                    title: Text(
                      'customerkod'.tr,
                      style: TextStyle(color: AppConstants.greyColor),
                    ),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, bottom: 10.0, right: 20.0),
                    child: Row(
                      children: [
                        Text(
                          'wholeprice'.tr,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppConstants.greyColor),
                        ),
                        Spacer(),
                        Text(
                          'Rs.' + formatter.format(dataArguments.price.toInt()),
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppConstants.greyColor),
                        ),
                      ],
                    ),
                  ),
                  controller.isDeliver.value
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 18.0, right: 12.0),
                          child: !controller.isProfit.value
                              ? InkWell(
                                  onTap: () {
                                    controller.isProfit.value =
                                        !controller.isProfit.value;
                                    print(controller.isProfit.value);
                                  },
                                  child: Container(
                                    // width: width * 0.85,
                                    decoration: BoxDecoration(
                                        color: AppConstants.lightWhiteColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        )),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.0,
                                            bottom: 10.0,
                                            right: 10.0,
                                            top: 10.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              'profit'.tr,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppConstants.mainColor),
                                            ),
                                            Spacer(),
                                            Text(
                                              'Rs.${controller.profit.value}',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppConstants.mainColor),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Icon(
                                              controller.isProfit.value
                                                  ? Icons.arrow_forward_ios
                                                  : Icons.arrow_back_ios,
                                              color: AppConstants.mainColor,
                                              size: 15,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Container(
                                      width: width * 0.65,
                                      decoration: BoxDecoration(
                                          color: AppConstants.lightWhiteColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          )),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              bottom: 10.0,
                                              right: 10.0,
                                              top: 10.0),
                                          child: InkWell(
                                            onTap: () {
                                              controller.isProfit.value =
                                                  !controller.isProfit.value;
                                              print(controller.isProfit.value);
                                            },
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Seller Profit',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppConstants
                                                          .mainColor),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'Rs.${controller.profit.value}',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppConstants
                                                          .mainColor),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Icon(
                                                  controller.isProfit.value
                                                      ? Icons.arrow_forward_ios
                                                      : Icons.arrow_back_ios,
                                                  color: AppConstants.mainColor,
                                                  size: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    CircleAvatar(
                                      radius: 12.5,
                                      backgroundColor:
                                          AppConstants.lightWhiteColor,
                                      child: InkWell(
                                        onTap: () {
                                          controller.profit.value -= 10;
                                          controller.totalPrice.value -= 10;
                                        },
                                        child: Icon(Icons.remove,
                                            color: AppConstants.mainColor),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.025,
                                    ),
                                    CircleAvatar(
                                      radius: 12.5,
                                      child: InkWell(
                                        onTap: () {
                                          controller.profit.value += 10;
                                          controller.totalPrice.value += 10;
                                        },
                                        child: Icon(Icons.add),
                                      ),
                                    ),
                                  ],
                                ),
                        )
                      : SizedBox(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, bottom: 10.0, right: 20.0, top: 10.0),
                    child: Row(
                      children: [
                        Text(
                          'total'.tr,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Text(
                          'Rs.' +
                              formatter
                                  .format(controller.totalPrice.value.toInt()),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, bottom: 10.0, right: 10.0, top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        quantities == 1 || cartController.quantity.value == 1
                            ? SizedBox()
                            : CircleAvatar(
                                radius: 12.5,
                                backgroundColor: AppConstants.lightWhiteColor,
                                child: InkWell(
                                  onTap: () {
                                    // controller.profit.value -= 10;
                                    // controller.totalPrice.value -= 10;
                                    cartController.quantity.value--;
                                    controller.calcToalPrice(
                                        dataArguments.price,
                                        cartController.quantity.value);
                                  },
                                  child: Icon(Icons.remove,
                                      color: AppConstants.mainColor),
                                ),
                              ),
                        Column(
                          children: [
                            // Text(
                            //   'Qty',
                            //   style: TextStyle(
                            //       fontSize: 16,
                            //       fontWeight: FontWeight.w400,
                            //       color: AppConstants.greyColor),
                            // ),
                            Text(
                              cartController.quantity.value.toString(),
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppConstants.mainColor),
                            ),
                            // Quantity(
                            //     dataArguments.price,
                            //     dataArguments.options.isNotEmpty
                            //         ? dataArguments.options[
                            //                 controller.selectedAge.value - 1]
                            //             ['quantity']
                            //         : dataArguments.quantity),
                          ],
                        ),
                        quantities == cartController.quantity.value
                            ? SizedBox()
                            : CircleAvatar(
                                radius: 12.5,
                                child: InkWell(
                                  onTap: () {
                                    // controller.profit.value += 10;
                                    // controller.totalPrice.value += 10;
                                    cartController.quantity.value++;
                                    controller.calcToalPrice(
                                        dataArguments.price,
                                        cartController.quantity.value);
                                  },
                                  child: Icon(Icons.add),
                                ),
                              ),
                        CustomButton(
                          width: width * 0.6,
                          onPressed: () {
                            var optionId = dataArguments.options.isNotEmpty
                                ? dataArguments.options[
                                    controller.selectedAge.value - 1]['id']
                                : '';
                            if (cartController.cartOrder.isEmpty) {
                              cartController.firstOrder(
                                  dataArguments.id,
                                  optionId,
                                  10.0,
                                  dataArguments.images.isEmpty
                                      ? ''
                                      : dataArguments.images[0]['url'],
                                  dataArguments.name,
                                  controller.totalPrice.value,
                                  controller.isDeliver.value,
                                  controller.profit.value,
                                  context);
                            } else {
                              var isElement = cartController.cartOrder
                                  .where((element) =>
                                      element.itemId == dataArguments.id)
                                  .isNotEmpty;
                              print(isElement);
                              if (isElement) {
                                cartController.cartOrder
                                    .where((element) =>
                                        element.itemId == dataArguments.id)
                                    .first
                                    .quantity += cartController.quantity.value;
                                Get.toNamed(Routes.CART);
                              } else {
                                cartController.addItem(
                                  dataArguments.id,
                                  optionId,
                                  controller.profit.value,
                                  dataArguments.images.isEmpty
                                      ? ''
                                      : dataArguments.images[0]['url'],
                                  dataArguments.name,
                                  controller.totalPrice.value,
                                  controller.isDeliver.value,
                                  controller.profit.value,
                                  context,
                                );
                              }
                            }
                            print(controller.profit.value);
                            controller.isDeliver.value
                                ? cartController.totalEarnings.value +=
                                    controller.profit.value
                                : cartController.totalEarnings.value += 0;
                            Navigator.of(context).pop();
                          },
                          widget: Text(
                            'additemfor'.tr +
                                '  Rs. ${formatter.format(controller.totalPrice.value.toInt())}',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppConstants.lightWhiteColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      );
}
