import 'package:get/get.dart';
import 'package:zarya/app/widgets/quantity.dart';

class ViewItemController extends GetxController {
  var selectedAge = 1.obs;
  var isDeliver = false.obs;
  var isProfit = false.obs;
  var profit = 50.obs;
  var totalPrice = 0.0.obs;
  // var quantity = 1.obs;

  void calcToalPrice(price, quantity) {
    totalPrice.value = 0.0;
    totalPrice.value += price * quantity;
    update();
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
