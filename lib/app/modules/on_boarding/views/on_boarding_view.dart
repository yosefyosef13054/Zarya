import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/helpers/sheard_helper.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/custom_button.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  final _form = GlobalKey<FormState>();

  void saveForm(context) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      controller.isError.value = true;
      return;
    }
    _form.currentState!.save();
    print(controller.phoneController.text);
    controller.phoneLogin(controller.phoneController.text);
    Get.toNamed(Routes.VERIFY);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.13),

                ///logo of app
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 35,
                        child: Image.asset('assets/images/Logo.png',
                            fit: BoxFit.fitHeight,
                            height: height * 0.5,
                            width: width),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'aapkae'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                      Text(
                        'digwholstore'.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 24),
                      ),
                    ],
                  ),
                ),

                ///Spacer
                SizedBox(height: 40),

                ///phone title
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "phonenum".tr,
                      style: TextStyle(
                          color: AppConstants.lightBlackColor, fontSize: 14),
                    ),
                  ],
                ),

                ///Spacer
                SizedBox(height: 6),

                ///phone textForm to take data
                Obx(
                  () => Container(
                    width: width,
                    child: Form(
                      key: _form,
                      child: TextFormField(
                        controller: controller.phoneController,
                        autofocus: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a Phone Number.';
                          }
                          if (value.contains('*')) {
                            return 'Not a valid number.';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          controller.phoneNumber.value = value;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: AppConstants.errorColor),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40.0),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                          hintText: "0334-3210987",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: controller.isError.value
                                      ? AppConstants.errorColor
                                      : AppConstants.lightHintText
                                          .withOpacity(0.5),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                          fillColor: AppConstants.buttonBackgroundColor
                              .withOpacity(.5),
                          focusColor: AppConstants.buttonBackgroundColor
                              .withOpacity(.5),
                          filled: true,
                        ),
                        maxLines: 1,
                        minLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ),
                ),

                ///Spacer
                SizedBox(height: 20),

                Center(
                    child: CustomButton(
                  onPressed: () {
                    saveForm(context);
                  },
                  widget: Text(
                    'proceed'.tr,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                )),
                // SizedBox(height: height * 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
