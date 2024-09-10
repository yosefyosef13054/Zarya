import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/models/product.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';

class ProductsController extends GetxController {
  ScrollController scrollController = new ScrollController();
  List<Product> products = RxList();
  var homeController = Get.find<HomeController>();
  var isLoading = false.obs;
  var newid = 0.obs;
  var categoryName = ''.obs;
  var subCategoryName = ''.obs;
  var categoryId = 0.obs;
  var marker = ''.obs;
  var isNewCategory = false.obs;
  void getProducts(id, isFirst) async {
    if (isFirst) isLoading.value = true;
    if (isFirst) newid.value = id;
    if (isFirst) marker.value = '';
    print(id);
    var urlEnd = marker.value == ''
        ? 'v2/item/search?size=8&categoryId=$id&marker='
        : 'v2/item/search?size=8&categoryId=$id&marker=$marker';
    print(urlEnd);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    final url = Uri.parse(AppConstants.urlBase + urlEnd);
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${apiToken}',
      "Connection": "Keep-Alive",
    };
    try {
      // products.clear();
      final response = await http.get(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data['items'].length);
        for (int i = 0; i < data["items"].length; i++) {
          if (data["items"][i]["nextCategoryStarted"] == true) {
            categoryId.value = data["items"][i]['categoryId'];
            print(categoryId.value);
            categoryName.value = homeController.mainCategory
                .where((element) => element.id == categoryId.value)
                .first
                .name;
          }
          products.add(Product(
            id: data["items"][i]['id'],
            name: data["items"][i]['name'],
            categoryId: data["items"][i]['categoryId'],
            childCategoryId: data["items"][i]['childCategoryId'],
            description: data["items"][i]['description'],
            price: data["items"][i]['price'],
            quantity: data["items"][i]['quantity'],
            statusId: data["items"][i]['statusId'],
            thumbnail: data["items"][i]['thumbnail'],
            options: data["items"][i]['options'],
            images: data["items"][i]['images'],
            sortOrder: data["items"][i]['sortOrder'],
            retailPrice: data["items"][i]['retailPrice'],
            marker: data["marker"],
            nextCategoryStarted: data["items"][i]["nextCategoryStarted"],
          ));
          isNewCategory.value = data["items"][i]["nextCategoryStarted"];
        }
        marker.value = data["marker"];
        // categoryId.value = data["items"][0]['categoryId'];
        // print(categoryId.value);
        // categoryName.value = homeController.mainCategory
        //     .where((element) => element.id == categoryId.value)
        //     .first
        //     .name;
        print(categoryName.value);
        print('hnaaa1');
      }
      print('hnaaa2');
      update();
      isLoading.value = false;
    } catch (error) {
      print(error);
    }
  }

  var pageloading = false.obs;
  @override
  void onInit() {
    scrollController.addListener(() {
      // print('hnaa');
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageloading.value = true;
        getProducts(newid.value, false);
        pageloading.value = true;
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
