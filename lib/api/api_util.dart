import 'package:flutter/cupertino.dart';

abstract class ApiUtil {
  Future<void> get(
      {String? url,
      Map<String, String>? headers,
      VoidCallback? callback(
          bool? status, String? message, Map<String, dynamic>? response)});
}
