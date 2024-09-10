import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:zarya/app/constants/app_constants.dart';
import 'package:zarya/app/modules/on_boarding/controllers/on_boarding_controller.dart';
import 'package:zarya/app/routes/app_pages.dart';
import 'package:zarya/app/widgets/custom_button.dart';
import 'package:zarya/app/widgets/global_app_bar.dart';
import 'package:zarya/app/widgets/global_icon.dart';

import '../controllers/verify_controller.dart';

class VerifyView extends GetView<VerifyController> {
  var loginController = Get.find<OnBoardingController>();
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.05),
                      Align(
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: globalIcon(
                            Icons.arrow_back_ios,
                            AppConstants.mainColor,
                            25,
                            30,
                          ),
                        ),
                      ),
                      // GlobalAppBar(
                      //   withDrawer: false,
                      //   withProfile: false,
                      //   withShadow: false,
                      // ),

                      SizedBox(height: height * 0.05),

                      ///otp title
                      Text(
                        "Enter OTP",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: height * 0.04),

                      Text(
                        "We have sent you a code on your",
                        style: TextStyle(
                            color:
                                AppConstants.lightBlackColor.withOpacity(0.7)),
                      ),
                      Text(
                        "phone number ${loginController.phoneNumber}.",
                        style: TextStyle(
                            color:
                                AppConstants.lightBlackColor.withOpacity(0.7)),
                      ),

                      ///Spacer
                      SizedBox(height: height * 0.05),

                      ///pin code text feild
                      Container(
                        width: MediaQuery.of(context).size.width * .8,
                        child: PinCodeTextField(
                          appContext: context,
                          keyboardType: TextInputType.number,
                          autoFocus: true,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(20),
                            fieldHeight: height * 0.1,
                            fieldWidth: width * 0.15,
                            activeColor: AppConstants.mainColor,
                            inactiveColor:
                                AppConstants.greyColor.withOpacity(.5),
                          ),
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.fade,
                          animationDuration: Duration(milliseconds: 300),
                          // Pass it heres
                          onChanged: (value) {
                            controller.otpCode.value = value;
                            print(controller.otpCode.value);
                          },
                        ),
                      ),

                      ///Spacer

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Transform.rotate(
                              angle: 90 * math.pi / 90,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.replay,
                                  color: AppConstants.mainColor,
                                ),
                              ),
                            ),
                            Text(
                              'Resend code in 40s',
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      CustomButton(
                        onPressed: () {
                          controller.phoneLoginOtp(
                              loginController.phoneNumber, context);
                        },
                        widget: Text(
                          'LOGIN',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
