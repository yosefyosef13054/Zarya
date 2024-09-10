// import 'dart:convert';
// import 'package:dio/dio.dart' as dioo;
// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HttpService extends GetxService {
//   static const urlBase = 'https://zarya-backend.herokuapp.com/';

//   String apiToken = "";
//   dioo.Dio dio = new dioo.Dio();

//   Future<HttpService> init() async {
//     dio.options.baseUrl = urlBase;
//     dio.options.connectTimeout = 5000; //5s
//     dio.options.receiveTimeout = 3000;

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     apiToken = prefs.getString("token")!;

//     // print('HTTP Service Intiated ...');

//     return this;
//   }

//   setApiToken(token) async {
//     await setUserToken(token);
//     this.apiToken = token;
//   }

//   // getApiToken() async {
//   //   var token = await getToken();
//   //   return token;
//   // }

//   Future<dioo.Response> postUrl(endPoint, body) async {
//     return dio.post(urlBase + endPoint,
//         data: body,
//         options: dioo.Options(
//             validateStatus: (status) => true,
//             contentType: dioo.Headers.formUrlEncodedContentType,
//             headers: {'Authorization': 'Bearer $apiToken'}));
//   }

//   Future<dioo.Response> postUrlUpload(endPoint, body,
//       {required Function onSendProgress,
//       required Function onRecieveProgress}) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     apiToken = prefs.getString("token")!;

//     return dio.post(urlBase + endPoint,
//         data: body,
//         options: dioo.Options(
//             contentType: dioo.Headers.formUrlEncodedContentType,
//             headers: {'Authorization': 'Bearer $apiToken'}));
//   }

//   Future<dioo.Response> pos(endPoint, body) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     apiToken = prefs.getString("token")!;
//     // print('URL ${urlBase + endPoint}');
//     // print(body);
//     return dio.post(urlBase + endPoint,
//         data: body,
//         options: dioo.Options(headers: {'Authorization': 'Bearer $apiToken'}));
//   }

//   Future<dioo.Response> get(endPoint) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     apiToken = prefs.getString("token")!;
//     print(apiToken);
//     print('URL ${urlBase + endPoint}');
//     return dio.get(urlBase + endPoint,
//         // queryParameters: body,
//         options: dioo.Options(headers: {'Authorization': 'Bearer $apiToken'}));
//   }

//   Future<dioo.Response> appget(endPoint) async {
//     return dio.get(
//       endPoint,
//     );
//   }
// }
