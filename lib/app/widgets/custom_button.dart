import 'package:flutter/material.dart';
import 'package:zarya/app/constants/app_constants.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  final Widget widget;
  final double width;

  const CustomButton({
    required this.onPressed,
    required this.widget,
    this.width = 247,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: widget,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppConstants.mainColor),
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
        elevation: MaterialStateProperty.all<double>(0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              50.0,
            ),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(Size(width, 48)),
      ),
    );
  }
}
