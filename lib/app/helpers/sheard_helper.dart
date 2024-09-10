import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'sheard_var_app.dart';

TextEditingController firstNameController = TextEditingController();
TextEditingController lastNameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController confirmPasswordController = TextEditingController();

/// SHow Alert Dialog
Future<void> showAlertDialog(
    BuildContext context, String title, List<Widget> children) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: ListBody(
            children: children,
          ),
        ),
      );
    },
  );
}

/// Hide Keyboard
void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

/// Show SnackBar
void showSnackBar(
    {required BuildContext context, required String title, Color? color}) {
  Color backgroundColor = color ?? Colors.red;

  final snackBar = SnackBar(
    content: Text(title),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// fetch Current Locale
// fetchLocale() async {
//   SharedText.currentLocale = await DefaultSecuredStorage.getLang() ?? 'en';
//   var lang = await DefaultSecuredStorage.getLang() ?? 'en';
//   var countryCode = await DefaultSecuredStorage.getCountryCode() ?? 'us';

//   SharedText.userMap = await DefaultSecuredStorage.getUserMap() ?? '';

//   return Locale(lang, countryCode);
// }

/// Bottom Sheet
void checkoutSelectProfileBottomSheet(
    {required BuildContext context,
    required double height,
    required String titleKey,
    required Widget commonBody,
    TextStyle? textStyle,
    Color bgColor = Colors.white}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(AppConstants.bottomSheetBorderRadius),
      topRight: Radius.circular(AppConstants.bottomSheetBorderRadius),
    )),
    builder: (builder) {
      return Container(
        height: getWidgetHeight(height),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.pagePadding),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppConstants.bottomSheetBorderRadius),
            topRight: Radius.circular(AppConstants.bottomSheetBorderRadius),
          ),
        ),
        child: Column(
          children: [
            Text(titleKey,
                style: textStyle ??
                    Theme.of(context)
                        .textTheme
                        .headline4!
                        .apply(color: AppConstants.mainColor)),
            const SizedBox(height: AppConstants.pagePadding),
            Expanded(child: commonBody),
          ],
        ),
      );
    },
  );
}

/// Close App Alert
DateTime? currentBackPressTime;

onWillPop(BuildContext context) async {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
      now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
    currentBackPressTime = now;
    showTopSnackBar(
        context,
        const CustomSnackBar.info(
          message: 'Message',
          // message: getTranslated(context, 'lblTapAgainToLeave')!,
        ),
        displayDuration: const Duration(milliseconds: 1800));

    return Future.value(false);
  }
  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  return Future.value(true);
}

/// Calculate %
String calculatePercentage(String price, String discount) {
  String percent = ((double.parse(discount) * double.parse(price)) / (100))
      .toStringAsFixed(2);

  return percent;
}

/// Calculate Total Price
String calculateFinalPrice(String price, String discount) {
  String finalPrice =
      (double.parse(price) - double.parse(calculatePercentage(price, discount)))
          .toStringAsFixed(2);

  return finalPrice;
}

/// Get Widget Height
double getWidgetHeight(double height) {
  double currentHeight = SharedText.screenHeight * (height / 851);
  return currentHeight;
}

/// Get Widget Width
double getWidgetWidth(double width) {
  double currentWidth = SharedText.screenWidth * (width / 393);
  return currentWidth;
}

/// Get Space Height
SizedBox getSpaceHeight(double height) {
  double currentHeight = SharedText.screenHeight * (height / 851);
  return SizedBox(
    height: currentHeight,
  );
}

/// Get Space Width
SizedBox getSpaceWidth(double width) {
  double currentWidth = SharedText.screenWidth * (width / 393);
  return SizedBox(
    width: currentWidth,
  );
}

/// Get Random Items
int getRandomItems(int maxItems) {
  final random = Random();
  int colorInt = random.nextInt(maxItems);

  return colorInt;
}
