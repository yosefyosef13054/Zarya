import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Whatssapp extends StatelessWidget {
  const Whatssapp({Key? key}) : super(key: key);

  void _openWhatsApp() async {
    String phone = '+923019279275';
    // await launch('https://wa.me/$phone');

    var whatsappUrl = "whatsapp://send?phone=$phone";
    await canLaunch(whatsappUrl)
        ? launch(whatsappUrl)
        : print(
            "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _openWhatsApp(),
      backgroundColor: Color.fromRGBO(37, 211, 102, 1),
      child: Image.asset(
        'assets/images/WhatsApp_icon.png',
        scale: 15,
      ),
    );
  }
}
