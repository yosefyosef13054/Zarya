import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zarya/app/models/category.dart';
import 'package:zarya/app/modules/products/controllers/products_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';

class CategoryItem extends StatelessWidget {
  final Map<String, dynamic> item;
  var productController = Get.put(ProductsController());
  CategoryItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // String title = item.name.substring(0, 10) + '....';
    // int x = item.name.length;
    // print(x);
    return InkWell(
      onTap: () {
        productController.products.clear();
        print('hna item id ${item['id']}');
        productController.subCategoryName.value = item['name'];
        productController.getProducts(item['id'], true);
        Get.toNamed(Routes.PRODUCTS);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.network(
            item['image'],
            height: height * 0.075,
          ),
          // SizedBox(
          //   height: height * 0.01,
          // ),
          Text(
            item['name'].length >= 16
                ? item['name'].substring(0, 16) + '....'
                : item['name'],
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            // maxLines: 1,
          ),
        ],
      ),
    );
  }
}
