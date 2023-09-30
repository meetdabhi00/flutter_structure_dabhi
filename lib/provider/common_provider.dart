import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/translation_constants.dart';
import 'package:flutter_project_structure_meet/utils/common_navigator.dart';
import 'package:flutter_project_structure_meet/utils/utils.dart';

class CommonProvider extends ChangeNotifier {
  late StreamSubscription subscription;
  bool isNoInterNetAlertShow = false;
  bool isInterNetConnected = true;

  void internetCheck({required BuildContext context}) {
    subscription = Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) async {
        if (result.name == 'none') {
          isInterNetConnected = false;
        } else {
          isInterNetConnected = true;
        }
        if (isNoInterNetAlertShow && isInterNetConnected) {
          CommonNavigator.pop();
          isNoInterNetAlertShow = false;
        }
        if (!isInterNetConnected && !isNoInterNetAlertShow) {
          isNoInterNetAlertShow = true;
          if (!Platform.isIOS) {
            return showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => AlertDialog(
                title: Text(
                  Utils.getString(TranslationConstants.no_connection),
                ),
                content: Text(
                  Utils.getString(TranslationConstants.please_check_internet),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
          showCupertinoDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(
                Utils.getString(TranslationConstants.no_connection),
              ),
              content: Text(
                Utils.getString(TranslationConstants.please_check_internet),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text('OK'),
                ),
              ],
            ),
          );
          notifyListeners();
        }
      },
    );
  }
}
