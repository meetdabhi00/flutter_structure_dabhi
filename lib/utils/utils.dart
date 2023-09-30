// ignore_for_file: avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/app_colors.dart';
import 'package:flutter_project_structure_meet/utils/common_navigator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Utils {
  //translations
  static String getString(String? key) {
    if (key != '') {
      return tr(key!);
    } else {
      return '';
    }
  }

  //showSnackBar
  static void showSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  static bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  static AppBar appBar({
    required BuildContext context,
    String? title,
    VoidCallback? backArrowTap,
    VoidCallback? actionButtonOnTap,
    IconData? actionButtonIcon,
    Widget? leftWidget,
    Widget? rightWidget,
    double? leadingWidth,
    bool? centerTitle,
    bool? actionButton,
  }) {
    return AppBar(
      toolbarHeight: 75.h,
      iconTheme: IconThemeData(color: AppColor.icon),
      backgroundColor: AppColor.appbarColor,
      leadingWidth: leadingWidth ?? 45,
      centerTitle: centerTitle,
      title: commonText(
        text: title ?? '',
        color: AppColor.appbarTextColor,
        fontSize: 30.sp,
      ),
      leading: leftWidget ?? backArrow(backArrowTap: backArrowTap),
      actions: [
        rightWidget ??
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: actionButtonOnTap,
                child: commonIcon(
                  actionButtonIcon ?? Icons.info_outline,
                  color: AppColor.icon,
                  size: 35.sp,
                ),
              ),
            ),
      ],
    );
  }

  static Widget backArrow({
    VoidCallback? backArrowTap,
    Color? backgroundColor,
    double? marginAllSide,
    double? paddingAllSide,
    double? borderRadius,
  }) {
    return GestureDetector(
      onTap: backArrowTap ?? () => CommonNavigator.pop(),
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Utils.commonIconButton(
          width: 50,
          icon: Icons.arrow_back_ios,
          iconColor: AppColor.icon,
          backgroundColor: backgroundColor,
          marginAllSide: marginAllSide,
          paddingAllSide: paddingAllSide,
          borderRadius: borderRadius,
        ),
      ),
    );
  }

  static Widget container({
    double? width,
    double? height,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? backgroundColor,
    AlignmentGeometry? alignment,
    double? marginAllSide,
    EdgeInsetsGeometry? margin,
    double? paddingAllSide,
    EdgeInsetsGeometry? padding,
    Widget? child,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin: margin ?? EdgeInsets.all(marginAllSide ?? 0),
      padding: padding ?? EdgeInsets.all(paddingAllSide ?? 0),
      alignment: alignment,
      decoration: BoxDecoration(
        borderRadius: boaderRadius(borderRadius ?? 0),
        color: backgroundColor ?? AppColor.white,
        border: borderColor != null
            ? Border.all(color: borderColor, width: borderWidth ?? 1.0)
            : null,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.circular(radius);
  }

  static Widget commonIconButton({
    required IconData icon,
    double? width,
    double? height,
    VoidCallback? onTap,
    Color? iconColor,
    Color? backgroundColor,
    double? iconSize,
    double? marginAllSide,
    double? paddingAllSide,
    double? borderRadius,
    AlignmentGeometry? alignment,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: container(
        width: width?.w,
        height: height?.h,
        margin: margin,
        padding: padding,
        marginAllSide: marginAllSide,
        paddingAllSide: paddingAllSide,
        borderRadius: borderRadius,
        backgroundColor: backgroundColor ?? Colors.transparent,
        alignment: alignment ?? Alignment.center,
        child: Center(
          child: Utils.commonIcon(
            size: iconSize,
            icon,
            color: iconColor ?? AppColor.white,
          ),
        ),
      ),
    );
  }

  static Widget commonText({
    String? text,
    bool? bold = false,
    Color? color,
    double? fontSize,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      overflow: overflow ?? TextOverflow.ellipsis,
      maxLines: maxLines ?? 1,
      style: TextStyle(
        color: color ?? AppColor.textColor,
        fontSize: fontSize?.sp ?? 20.sp,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  static Widget commonIcon(
    IconData icon, {
    Color? color,
    double? size,
  }) {
    return Icon(
      icon,
      color: color ?? AppColor.black,
      size: size?.sp,
    );
  }

  static Widget sizedBox({
    double? width,
    double? height,
    Widget? child,
  }) {
    return SizedBox(
      height: height?.h,
      width: width?.w,
      child: child,
    );
  }

  static Widget imageOrSvg({
    required String path,
    AlignmentGeometry? alignment,
    Color? color,
    double? height,
    double? width,
    BoxFit? fit,
  }) {
    return path.split('.').last == 'svg'
        ? SvgPicture.asset(
            path,
            alignment: alignment ?? Alignment.center,
            colorFilter:
                ColorFilter.mode(color ?? Colors.black, BlendMode.dstIn),
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            placeholderBuilder: (context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        : Image.asset(
            path,
            alignment: alignment ?? Alignment.center,
            height: height,
            width: width,
            fit: fit ?? BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return commonIcon(Icons.error_outline);
            },
          );
  }

  static void commonPrint(String text) {
    if (kDebugMode) {
      print(text);
    }
    return print(text);
  }

  //   static void toast(String text) {
  //   Fluttertoast.showToast(
  //     msg: text,
  //     toastLength: Toast.LENGTH_SHORT,
  //     gravity: ToastGravity.BOTTOM,
  //     timeInSecForIosWeb: 1,
  //     backgroundColor: Colors.black,
  //     textColor: Colors.white,
  //     fontSize: 26.0.sp,
  //   );
  // }
}
