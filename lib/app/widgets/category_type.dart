import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/models/main_category.dart';
import 'package:zarya/app/modules/home/controllers/home_controller.dart';
import 'package:zarya/app/widgets/category_item.dart';

class CategoryType extends StatelessWidget {
  final MainCategory item;
  CategoryType(this.item);
  var homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: (170) / (240),
            ),
            itemBuilder: (ctx, pos) {
              return GetBuilder<HomeController>(
                init: HomeController(), // INIT IT ONLY THE FIRST TIME
                builder: (_) => CategoryItem(
                  item: item.children[pos],
                ),
              );
            },
            itemCount: item.children.length,
          ),
        ],
      ),
    );
  }
}
