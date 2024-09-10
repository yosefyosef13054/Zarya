import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/helpers/localization_service.dart';

import 'app/helpers/dio_api.dart';
import 'app/modules/cart/controllers/cart_controller.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // Get.put(HttpService());
  prefs.containsKey('token') ? Get.put(HomeController()) : print('home');
  Get.put(CartController());
  runApp(
    GetMaterialApp(
      title: "Zarya",
      locale: LocalizationService.locale,
      fallbackLocale: Locale('en'),
      translations: LocalizationService(),
      debugShowCheckedModeBanner: false,
      initialRoute: prefs.containsKey('token') ? Routes.HOME : AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
