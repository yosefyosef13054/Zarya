import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/models/cart.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:zarya/app/models/final_cart.dart';
import 'package:zarya/app/models/order.dart';
import 'package:zarya/app/routes/app_pages.dart';

class CartController extends GetxController {
  List<Cart> cartOrder = RxList();
  var orderId = 0.obs;
  var quantity = 1.obs;
  var orderSecquence = 0.obs;
  var totalOrderPrice = 0.0.obs;
  var totalEarnings = 0.0.obs;
  TextEditingController customerNameController = TextEditingController();
  TextEditingController customerPhoneNoController = TextEditingController();
  TextEditingController customerAddressController = TextEditingController();
  TextEditingController customerCityController = TextEditingController();
  // List cities = [
  //   'Lahore, Pakistan',
  //   'Hyderabad, Pakistan',
  //   'Faisalabad, Pakistan'
  // ];

  // var city = ''.obs;

  void firstOrder(itemId, optionId, commission, image, name, price, isProfit,
      itemEarning, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    print({
      "itemId": itemId,
      "quantity": quantity.value,
      "commission": commission,
      "optionId": optionId
    });
    var body = {
      "itemId": itemId,
      "quantity": quantity.value,
      "commission": commission,
      "optionId": optionId
    };
    final url = Uri.parse(AppConstants.urlBase + 'order');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${apiToken}',
    };
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
        Order order = Order(
          id: data['id'],
          total: data['total'],
          commission: data['commission'],
          shippingCharges: data['shippingCharges'],
          userId: data['userId'],
          merchantId: data['merchantId'],
          statusId: data['statusId'],
          customerName: data['customerName'],
          customerPhone: data['customerPhone'],
          customerAddress: data['customerAddress'],
          customerCity: data['customerCity'],
          cityId: data['cityId'],
          items: data['items'],
          placedAt: data['placedAt'],
          createdAt: data['createdAt'],
          updatedAt: data['updatedAt'],
          courierId: data['courierId'],
          trackingNumber: data['trackingNumber'],
          returnedForOrderId: data['returnedForOrderId'],
          discount: data['discount'],
          maxDiscount: data['maxDiscount'],
          paymentStatusId: data['paymentStatusId'],
          courierCharges: data['courierCharges'],
          pending: data['pending'],
          delivered: data['delivered'],
        );
        print(order.id);
        orderId.value = order.id;
      }
      itemEarning = isProfit ? itemEarning : 0;
      cartOrder.add(Cart(
        commission: commission,
        itemId: itemId,
        quantity: quantity.value,
        image: image,
        name: name,
        itemEarning: itemEarning.toDouble(),
        price: price,
      ));
      print('added');
      print(cartOrder[0].itemId);
      update();
      Get.toNamed(Routes.CART);
    } catch (error) {
      print(error);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Warning",
        desc: "The Item Is Out Of Stock",
        buttons: [
          DialogButton(
            child: Text(
              "OKAY",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  void calcTotalOrderPrice() {
    totalOrderPrice.value = 0.0;
    for (int i = 0; i < cartOrder.length; i++) {
      totalOrderPrice.value = totalOrderPrice.value + cartOrder[i].price;
    }
  }

  void addItem(itemId, optionId, commission, image, name, price, isProfit,
      itemEarning, context) async {
    print('add item $itemId');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    print({
      "itemId": itemId,
      "quantity": quantity.value,
      "commission": commission,
      "optionId": optionId
    });
    var body = {
      "itemId": itemId,
      "quantity": quantity.value,
      "commission": commission,
      "optionId": optionId
    };

    final url = Uri.parse(AppConstants.urlBase + 'order/$orderId/item');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $apiToken',
    };
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
      }
      itemEarning = isProfit ? itemEarning : 0;
      cartOrder.add(Cart(
        commission: commission,
        itemId: itemId,
        quantity: quantity.value,
        image: image,
        name: name,
        itemEarning: itemEarning.toDouble(),
        price: price,
      ));
      print('added');
      update();
      Get.toNamed(Routes.CART);
    } catch (error) {
      print(error);
      Alert(
        context: context,
        type: AlertType.error,
        title: "Warning",
        desc: "The Item Is Out Of Stock",
        buttons: [
          DialogButton(
            child: Text(
              "OKAY",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  void deleteItem(itemId, price, itemEarning) async {
    print('delete item');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;

    final url = Uri.parse(AppConstants.urlBase + 'order/$orderId/item/$itemId');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $apiToken',
    };
    try {
      final response = await http.delete(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
      }
      cartOrder.removeWhere((element) => element.itemId == itemId);
      print(itemEarning);
      totalEarnings.value -= itemEarning;
      totalOrderPrice.value -= double.parse(price);
      update();
    } catch (error) {
      print(error);
    }
  }

  void orderFull() async {
    print('full');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    List<Map<String, dynamic>> allOrder = RxList();
    for (int i = 0; i < cartOrder.length; i++) {
      // allOrder![i].itemId = cartOrder[i].itemId;
      // allOrder![i].quantity = cartOrder[i].quantity;
      // allOrder![i].commission = cartOrder[i].commission;
      allOrder.add({
        'commission': cartOrder[i].commission,
        'itemId': cartOrder[i].itemId,
        'quantity': cartOrder[i].quantity,
      });
    }
    print({'items': allOrder});
    var body = {
      "items": allOrder,
    };
    print('hnaa');
    final url = Uri.parse(AppConstants.urlBase + 'order/full');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $apiToken',
    };
    print('hnaa1');
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      print('hnaa2');
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
      }
      update();
    } catch (error) {
      print('hna error $error');
    }
  }

  void orderComplete() async {
    print('add item');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    print({
      "customerName": customerNameController.text,
      "customerPhone": customerPhoneNoController.text,
      "customerAddress": customerAddressController.text,
      "customerCity": customerCityController.text,
    });
    var body = {
      "customerName": customerNameController.text,
      "customerPhone": customerPhoneNoController.text,
      "customerAddress": customerAddressController.text,
      "customerCity": customerCityController.text,
    };
    print('order id hnaa$orderId');
    final url = Uri.parse(AppConstants.urlBase + 'order/$orderId/complete');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer $apiToken',
    };
    print(body);
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
      }
      update();
    } catch (error) {
      print(error);
    }
  }

  @override
  void onInit() {
    orderSecquence.value == 0;
    cartOrder.isNotEmpty ? print(cartOrder[0].itemId) : print('kk');
    // city.value = cities[0];
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
