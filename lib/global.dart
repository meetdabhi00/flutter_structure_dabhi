import 'package:flutter/material.dart';
import 'package:flutter_project_structure_meet/model/post_model.dart';

// Navigator use without context ex.navigator.currentState?.pushNamed(RoutePath.post_detail);
final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();

List<Post> posts = [];
