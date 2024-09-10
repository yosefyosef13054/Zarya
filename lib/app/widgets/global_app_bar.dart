import 'package:flutter/material.dart';
import 'package:zarya/app/constants/app_constants.dart';

import 'global_icon.dart';

class GlobalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool withDrawer;
  final bool withOutDrawerOrBack;
  final bool withProfile;
  final bool centerTitle;
  final GlobalKey? scaffoldKey;
  final bool withFavorite;
  final bool withShadow;
  final Widget? titleWidget;
  final String? sourcePage;
  final double? height;
  final double? elevation;

  const GlobalAppBar({
    Key? key,
    this.scaffoldKey,
    this.withDrawer = true,
    this.withShadow = true,
    this.withOutDrawerOrBack = false,
    this.titleWidget = const SizedBox(),
    this.withProfile = true,
    this.centerTitle = true,
    this.withFavorite = false,
    this.sourcePage = '',
    this.height = 75,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(double.infinity, height!),
      child: Container(
        decoration: withShadow
            ? BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppConstants.lightBlueShadowColor,
                  offset: Offset(0, 2.0),
                  blurRadius: 4.0,
                )
              ])
            : null,
        child: AppBar(
          backgroundColor: AppConstants.lightWhiteColor,
          elevation: this.elevation,
          centerTitle: centerTitle,
          toolbarHeight: height,

          leading: withOutDrawerOrBack
              ? SizedBox()
              : withDrawer
                  ? InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: globalIcon(
                        Icons.menu,
                        AppConstants.mainColor,
                        25,
                        30,
                      ),
                    )
                  : InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: globalIcon(
                        Icons.arrow_back_ios,
                        AppConstants.mainColor,
                        25,
                        30,
                      ),
                    ),
          title: titleWidget,

          // actions: [
          //   // if (withFavorite) CommonFavoriteIcon(doctorModel: doctorModel!),
          //   SizedBox(width: getWidgetWidth(15)),
          //   if (withProfile)
          //     GlobalAssetImageWidget(
          //       imageString: 'profile.png',
          //       height: 22,
          //       width: 22,
          //       onTapImage: () {},
          //     ),
          //   const SizedBox(width: 20),
          // ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
