import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/constants/route_path.dart';
import 'package:flutter_project_structure_meet/model/post_model.dart';
import 'package:flutter_project_structure_meet/view/home_screen.dart';
import 'package:flutter_project_structure_meet/view/post_detail.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  log(settings.name.toString());
  switch (settings.name) {
    case RoutePath.home_screen:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const HomeScreen();
      });
    case RoutePath.post_detail:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        Post postArg = settings.arguments as Post;
        return PostDetail(
          post: postArg,
        );
      });
    default:
      return MaterialPageRoute<dynamic>(builder: (BuildContext context) {
        return const Scaffold();
      });
  }
}
