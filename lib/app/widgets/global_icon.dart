import 'package:flutter/material.dart';

InkWell globalIcon(
  IconData iconData,
  Color color,
  double mobileSize,
  double tabletSize, {
  final Function()? onTapIcon,
}) =>
    InkWell(
      onTap: onTapIcon,
      child: Icon(iconData, color: color, size: 30),
    );
