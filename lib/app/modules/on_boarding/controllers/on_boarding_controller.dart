import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/helpers/dio_api.dart';

class OnBoardingController extends GetxController {
  var phoneController = TextEditingController();
  var phoneNumber = ''.obs;
  var isError = false.obs;

  void phoneLogin(phone) async {
    print({"phoneNumber": phone});
    print(phoneNumber.value);
    var body = {"phoneNumber": phone};
    final url = Uri.parse(AppConstants.urlBase + 'login');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      json.decode(json.encode(response.body));
      update();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
