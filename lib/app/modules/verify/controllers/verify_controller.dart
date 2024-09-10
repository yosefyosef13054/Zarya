import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/helpers/dio_api.dart';
import 'package:zarya/app/helpers/helper.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

class VerifyController extends GetxController {
  var otpCode = ''.obs;
  var token = ''.obs;

  void phoneLoginOtp(phone, context) async {
    // print({"phoneNumber": phone, "otpCode": otpCode.value});
    var body = {
      "phoneNumber": phone.toString(),
      "otpCode": otpCode.value.toString()
    };
    final url = Uri.parse(AppConstants.urlBase + 'login');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
    };
    try {
      final response =
          await http.post(url, headers: userHeader, body: json.encode(body));
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        // print(data['token']);
        token.value = data['token'];
        // setUserToken(data['token']);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var apiToken = prefs.setString("token", data['token']);
        userInfo();
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: "Warning",
          desc: 'Wrong OTP code',
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
      update();

      Get.toNamed(Routes.HOME);
      var homeController = Get.put(HomeController());
      homeController.onInit();
    } catch (error) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Warning",
        desc: error.toString(),
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
      print(error);
      throw (error);
    }
  }

  void userInfo() async {
    final url = Uri.parse(AppConstants.urlBase + 'user/me');
    Map<String, String> userHeader = {
      "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': 'Bearer ${token.value}',
    };
    try {
      final response = await http.get(url, headers: userHeader);
      print(response.body);
      if (response.body.isNotEmpty) {
        final data = json.decode(response.body);
        print(data);
        setUserData(data);
      }
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
