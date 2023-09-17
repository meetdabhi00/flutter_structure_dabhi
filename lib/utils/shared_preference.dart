import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPref._();

  late SharedPreferences shared;

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    shared = prefs;
  }

  // Singleton instance
  static final SharedPref _singleton = SharedPref._();

  // Singleton accessor
  static SharedPref get instance => _singleton;
}
