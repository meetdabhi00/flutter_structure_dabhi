import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    bool? backArrow,
    String? title,
    bool? actionButton,
    VoidCallback? backArrowTap,
    VoidCallback? actionButtonOnTap,
    IconData? actionButtonIcon,
  }) {
    return AppBar(
      toolbarHeight: 75.h,
      iconTheme: IconThemeData(
        color: AppColor.icon,
      ),
      backgroundColor: AppColor.appbarColor,
      leadingWidth: backArrow == true ? 45 : 0,
      leading: backArrow == true
          ? GestureDetector(
              onTap: backArrowTap ??
                  () {
                    Navigator.pop(context);
                  },
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Utils.commonIconButton(
                  icon: Icons.arrow_back_ios,
                  iconColor: AppColor.icon,
                  bgColor: AppColor.appbarColor,
                ),
              ),
            )
          : const SizedBox(),
      centerTitle: false,
      title: Text(
        title ?? '',
        style: TextStyle(
          color: AppColor.appbarTextColor,
          fontSize: 30.sp,
        ),
      ),
      actions: [
        actionButton == true
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: actionButtonOnTap,
                  icon: Icon(
                    actionButtonIcon ?? Icons.info_outline,
                    color: AppColor.icon,
                    size: 35.sp,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  static Container container({
    double? width,
    double? height,
    bool? isBorder = false,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    Color? color,
    AlignmentGeometry? alignment,
    double? marginAllSide,
    bool? isMarginAllSide = true,
    EdgeInsetsGeometry? margin,
    double? paddingAllSide,
    bool? isPaddingAllSide = true,
    EdgeInsetsGeometry? padding,
    Widget? child,
  }) {
    return Container(
      width: width?.w,
      height: height?.h,
      margin:
          isMarginAllSide == true ? EdgeInsets.all(marginAllSide ?? 0) : margin,
      padding: isPaddingAllSide == true
          ? EdgeInsets.all(marginAllSide ?? 0)
          : padding,
      alignment: alignment,
      decoration: BoxDecoration(
        border: isBorder == true
            ? Border.all(
                color: borderColor ?? AppColor.grey,
                width: borderWidth ?? 1.0,
              )
            : null,
        borderRadius: boaderRadius(borderRadius ?? 0),
        color: color ?? AppColor.white,
      ),
      child: child,
    );
  }

  static BorderRadius boaderRadius(double radius) {
    return BorderRadius.all(Radius.circular(radius));
  }

  static GestureDetector commonIconButton({
    double? width,
    double? height,
    VoidCallback? onTap,
    IconData? icon,
    Color? iconColor,
    Color? bgColor,
    double? iconSize,
    bool? isBgColor = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: container(
        width: width ?? 50,
        height: height,
        marginAllSide: 1,
        paddingAllSide: 5,
        borderRadius: 5,
        color: isBgColor == true ? bgColor ?? const Color(0XFF0096FF) : null,
        alignment: Alignment.center,
        child: Center(
          child: Utils.commonIcon(
            iconSize: iconSize,
            icon ?? Icons.arrow_back_ios,
            color: iconColor ?? AppColor.white,
          ),
        ),
      ),
    );
  }

  static Text commonText({
    String? text,
    bool? bold = false,
    Color? color,
    double? fontSize,
  }) {
    return Text(
      text ?? '',
      style: TextStyle(
        color: color ?? AppColor.textColor,
        fontSize: fontSize?.sp ?? 20.sp,
        fontWeight: bold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  static Icon commonIcon(
    IconData icon, {
    Color? color,
    double? iconSize,
  }) {
    return Icon(
      icon,
      color: color ?? AppColor.black,
      size: iconSize?.sp ?? 32.sp,
    );
  }

  static SizedBox sizedBox({
    double? width,
    double? height,
    Widget? child,
  }) {
    return SizedBox(
      height: height != null ? height.h : height,
      width: width != null ? width.w : width,
      child: child,
    );
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
