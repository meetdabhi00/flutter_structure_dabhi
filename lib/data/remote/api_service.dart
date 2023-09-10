import 'package:flutter/cupertino.dart';
import 'package:flutter_project_structure_meet/data/remote/api_end_point.dart';
import 'package:flutter_project_structure_meet/data/remote/network_api_service.dart';
import 'package:flutter_project_structure_meet/model/post_model.dart';

class ApiService {
  final NetworkApiService _apiService = NetworkApiService();

  Future<List<Post>> fetchPost() async {
    try {
      final response = await _apiService.get(ApiEndPoints().postes);
      List<dynamic> jsonResponse = response;
      List<Post> posts =
          jsonResponse.map<Post>((e) => Post.fromJson(e)).toList();
      return posts;
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
