import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/models/cart.dart';
import 'package:zarya/app/models/category.dart';
import 'package:zarya/app/models/main_category.dart';
import 'package:zarya/app/models/product.dart';
import 'package:zarya/app/modules/cart/controllers/cart_controller.dart';

class HomeController extends GetxController {
  var cartController = Get.put(CartController());
  ScrollController scrollController = new ScrollController();
  List<MainCategory> mainCategory = RxList();
  // List<Category> categories = RxList();
  var isHome = true.obs;
  var isAnimated = false.obs;
  var animatedFinish = false.obs;
  var startAnimation = false.obs;
  var pageloading = false.obs;
  var marker = ''.obs;
  var isLoading = false.obs;
  List<Product> products = RxList();

  void getProducts() async {
    var urlEnd = marker.value == ''
        ? 'v2/item/search?size=8&categoryId=&marker='
        : 'v2/item/search?size=8&categoryId=&marker=$marker';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token")!;
    final url = Uri.parse(AppConstants.urlBase + urlEnd);
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${apiToken}',
    };
    try {
      // products.clear();
      final response = await http.get(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data.length);
        for (int i = 0; i < data["items"].length; i++) {
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
        }
        marker.value = data["marker"];
        print('hnaaa1');
      }
      print('hnaaa2');
      update();
    } catch (error) {
      print(error);
    }
  }

  void getCategories() async {
    mainCategory.clear();
    isLoading.value = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token");
    final url = Uri.parse(AppConstants.urlBase + 'v2/category');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${apiToken}',
    };
    try {
      final response = await http.get(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data.length);
        for (int i = 0; i < data.length; i++) {
          mainCategory.add(
            MainCategory(
              commissionDefault: data[i]['commissionDefault'],
              commissionMax: data[i]['commissionMax'],
              commissionMin: data[i]['commissionMin'],
              id: data[i]['id'],
              image: data[i]['image'],
              name: data[i]['name'],
              statusId: data[i]['statusId'],
              sortOrder: data[i]['sortOrder'],
              children: data[i]['children'],
            ),
          );
          print('first add');
          // for (var j = 0; j < data[i]['children'].length; j++) {
          //   categories.add(
          //     Category(
          //       commissionDefault: data[i]['children'][j]['commissionDefault'],
          //       commissionMax: data[i]['children'][j]['commissionMax'],
          //       commissionMin: data[i]['children'][j]['commissionMin'],
          //       id: data[i]['children'][j]['id'],
          //       image: data[i]['children'][j]['image'],
          //       name: data[i]['children'][j]['name'],
          //       statusId: data[i]['children'][j]['statusId'],
          //       parentId: data[i]['children'][j]['parentId'],
          //       sortOrder: data[i]['children'][j]['sortOrder'],
          //     ),
          //   );
          // }
        }
      }
      getProducts();
      getOrders();
      update();
      isLoading.value = false;
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  void getOrders() async {
    cartController.cartOrder.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var apiToken = prefs.getString("token");
    final url = Uri.parse(AppConstants.urlBase + 'order');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${apiToken}',
    };
    try {
      final response = await http.get(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data['items'].length);
        for (int i = 0; i < data['items'].length; i++) {
          cartController.cartOrder.add(Cart(
            commission: data['items'][i]['commission'],
            itemId: data['items'][i]['itemId'],
            quantity: data['items'][i]['quantity'],
            image: '',
            name: data['items'][i]['name'],
            price: data['items'][i]['price'],
          ));
          print('added');
        }
        cartController.orderId.value = data['id'];
      }
      update();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  @override
  void onInit() {
    mainCategory.clear();
    // products.clear();
    scrollController.addListener(() {
      // print('hnaa');
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        pageloading.value = true;
        getProducts();
        pageloading.value = true;
      }
    });
    getCategories();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }
}
