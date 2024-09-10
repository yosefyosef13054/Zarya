import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';
import 'package:zarya/app/modules/view_item/controllers/view_item_controller.dart';

class Quantity extends StatefulWidget {
  final double price;
  final int quantityLength;
  Quantity(this.price, this.quantityLength);
  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  List? index;
  var cartController = Get.find<CartController>();
  var viewItemController = Get.find<ViewItemController>();
  @override
  void initState() {
    index = List<int>.generate(widget.quantityLength, (i) => i + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Colors.white,
      focusColor: Colors.white,
      menuMaxHeight: Get.height * .3,

      // hint: Text('1'),
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: AppConstants.mainColor,
      ),
      iconSize: 20,
      underline: SizedBox(),
      isExpanded: false,
      style: TextStyle(
        color: AppConstants.mainColor,
        fontSize: 16,
      ),
      value: cartController.quantity.value,
      onChanged: (value) {
        setState(() {
          cartController.quantity.value = value as int;
          viewItemController.calcToalPrice(
              widget.price, cartController.quantity.value);
        });
      },
      items: index!
          .map(
            (element) => DropdownMenuItem(
              child: Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Text(element.toString()),
                ),
              ),
              value: element,
            ),
          )
          .toList(),
    );
  }
}
