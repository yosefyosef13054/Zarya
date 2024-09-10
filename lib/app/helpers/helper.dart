import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

String? code;
String? get helperLocal => code == null ? 'en' : code;

getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token').toString();
}

getUserData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map<String, dynamic> jsonData = jsonDecode(prefs.getString('user')!);
  if (jsonData.isNotEmpty) {
    return jsonData;
  } else
    return null;
}

setUserData(data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String user = jsonEncode(data);
  //print(user);
  return prefs.setString('user', user);
}

setUserToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('token', token);
}

setPushToken(token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString('push_token', token);
}

getpushToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('push_token');
}
