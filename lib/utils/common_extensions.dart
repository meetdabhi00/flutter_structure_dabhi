// ignore_for_file: unnecessary_this

import 'package:easy_localization/easy_localization.dart';

// Date Formatting Extension
// DateTime currentDate = DateTime.now();
// print(currentDate.format()); // Output: 2023-10-01
extension DateFormatting on DateTime {
  String format({String format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(this);
  }
}

// String Manipulation Extensions
// String snakeCase = 'hello_world';
// print(snakeCase.toCamelCase()); // Output: helloWorld
extension StringManipulation on String {
  String toCamelCase() {
    return this.replaceAllMapped(
        RegExp(r'_(\w)'), (match) => match.group(1)!.toUpperCase());
  }

  String truncate(int maxLength) {
    return (this.length <= maxLength)
        ? this
        : '${this.substring(0, maxLength)}...';
  }
}

// Localization Extensions
extension AppLocalizations on String {
  String translate(String key) {
    return tr(key);
  }
}

// Data Conversion Extensions
// String numericString = '42';
// print(numericString.toInt()); // Output: 42
extension DataConversion on String {
  int toInt() {
    return int.tryParse(this) ?? 0;
  }
}

// Validation Extensions
// String email = 'test@example.com';
// print(email.isValidEmail()); // Output: true
extension FormInputValidation on String {
  bool isValidEmail() {
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d]+(\.[a-zA-Z]+)+$')
        .hasMatch(this);
  }
}

// Currency Formatting Extension
// double price = 49.99;
// print(price.formatCurrency()); // Output: $49.99
extension CurrencyFormatting on num {
  String formatCurrency({String symbol = '\$', int decimalPlaces = 2}) {
    return '$symbol${this.toStringAsFixed(decimalPlaces)}';
  }
}

// List and Map Extensions
//  List<Map<String, dynamic>> data = [
//     {'name': 'Alice', 'age': 30},
//     {'name': 'Bob', 'age': 25},
//   ];
//   print(data.sortByField((entry) => entry['age'])); // Sorted by age
extension ListAndMapOperations<T> on List<T> {
  List<T> sortByField(Comparable Function(T) getField) {
    return List<T>.from(this)
      ..sort((a, b) => getField(a).compareTo(getField(b)));
  }
}

extension MapOperations<K, V> on Map<K, V> {
  List<V> valuesSortedBy(Comparable Function(V) getField) {
    return List<V>.from(this.values)
      ..sort((a, b) => getField(a).compareTo(getField(b)));
  }
}
