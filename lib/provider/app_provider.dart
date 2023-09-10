import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/data/remote/api_service.dart';
import 'package:flutter_project_structure_meet/global.dart';
import 'package:flutter_project_structure_meet/model/post_model.dart';

class AppProvider extends ChangeNotifier {
  bool isLoading = false;

  Future<void> updateIsLoading(bool value) async {
    await Future.delayed(const Duration(microseconds: 1));
    isLoading = value;
    notifyListeners();
  }

  void fetchPosts() async {
    updateIsLoading(true);
    try {
      List<Post> response = await ApiService().fetchPost();
      if (response.isNotEmpty) {
        posts = response;
      }
    } catch (e) {
      log(e.toString());
    }
    updateIsLoading(false);
    notifyListeners();
  }
}
