import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/newtest_controller.dart';

class NewtestView extends GetView<NewtestController> {
  const NewtestView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NewtestView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NewtestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
