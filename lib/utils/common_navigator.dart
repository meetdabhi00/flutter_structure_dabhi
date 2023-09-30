import 'package:flutter_project_structure_meet/global.dart';

class CommonNavigator {
  CommonNavigator._();

  static void pop() {
    navigator.currentState?.pop();
  }

  static void pushName({required String routePath, Object? arguments}) {
    navigator.currentState?.pushNamed(
      routePath,
      arguments: arguments,
    );
  }
}
