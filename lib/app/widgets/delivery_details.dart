import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';

class DeliveryDetails extends StatefulWidget {
  DeliveryDetails(this.form);
  final GlobalKey<FormState> form;

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  var cartController = Get.find<CartController>();
  var formatter = NumberFormat.decimalPattern();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var cartController = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: widget.form,
        child: Container(
          height: height,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "cusname".tr,
                    style: TextStyle(
                        color: AppConstants.lightBlackColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 6),
              TextFormField(
                controller: cartController.customerNameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppConstants.mainColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  // labelText: 'Customer Name',
                  // labelStyle: TextStyle(
                  //     fontSize: 11,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppConstants.lightBlackColor),
                ),
                textInputAction: TextInputAction.next,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please provide a Customer name.';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   cartController.customerNameController.text = value!;
                //   cartController.update();
                // },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "cusphone".tr,
                    style: TextStyle(
                        color: AppConstants.lightBlackColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 6),

              TextFormField(
                controller: cartController.customerPhoneNoController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppConstants.mainColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  // labelText: 'Customer Phone Number',
                  // labelStyle: TextStyle(
                  //     fontSize: 11,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppConstants.lightBlackColor),
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter a phone Number.';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   cartController.customerPhoneNoController.text = value!;
                //   cartController.update();
                // },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "cusaddress".tr,
                    style: TextStyle(
                        color: AppConstants.lightBlackColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 6),

              TextFormField(
                controller: cartController.customerAddressController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppConstants.mainColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  // labelText: 'Customer Address',
                  // labelStyle: TextStyle(
                  //     fontSize: 11,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppConstants.lightBlackColor),
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter an address.';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   cartController.customerAddressController.text = value!;
                //   cartController.update();
                // },
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "cuscity".tr,
                    style: TextStyle(
                        color: AppConstants.lightBlackColor, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(height: 6),

              TextFormField(
                controller: cartController.customerCityController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    borderSide: BorderSide(color: AppConstants.mainColor),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  // labelText: 'Customer Address',
                  // labelStyle: TextStyle(
                  //     fontSize: 11,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppConstants.lightBlackColor),
                ),
                keyboardType: TextInputType.name,
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Please enter your city.';
                //   }
                //   return null;
                // },
                // onSaved: (value) {
                //   cartController.customerAddressController.text = value!;
                //   cartController.update();
                // },
              ),
              // Container(
              //   padding: EdgeInsets.only(left: 16, right: 16),
              //   decoration: BoxDecoration(
              //     border: Border.all(color: AppConstants.mainColor),
              //     borderRadius: BorderRadius.circular(50.0),
              //   ),
              //   child: DropdownButton(
              //     dropdownColor: AppConstants.lightWhiteColor,
              //     disabledHint: Text(
              //       'Customer City',
              //       style: TextStyle(
              //           fontSize: 11,
              //           fontWeight: FontWeight.w400,
              //           color: AppConstants.lightBlackColor),
              //     ),
              //     icon: Icon(Icons.arrow_drop_down),
              //     iconSize: 36,
              //     underline: SizedBox(),
              //     isExpanded: true,
              //     style: TextStyle(
              //       color: AppConstants.lightBlackColor,
              //       fontSize: 22,
              //     ),
              //     value: cartController.city.value,
              //     onChanged: (value) {
              //       setState(() {
              //         cartController.city.value = value as String;
              //       });
              //     },
              //     items: cartController.cities
              //         .map(
              //           (element) => DropdownMenuItem(
              //             child: Text(element.toString()),
              //             value: element,
              //           ),
              //         )
              //         .toList(),
              //   ),
              // ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, right: 10.0, top: 30.0),
                child: Row(
                  children: [
                    Text(
                      'totalitems'.tr,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.greyColor),
                    ),
                    Spacer(),
                    Text(
                      cartController.cartOrder.length.toString(),
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: AppConstants.greyColor),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 10.0, right: 10.0, top: 10.0),
                child: Row(
                  children: [
                    Text(
                      'totalearnings'.tr,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                    Spacer(),
                    Text(
                      'Rs. ${formatter.format(cartController.totalEarnings.value.toInt())}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
