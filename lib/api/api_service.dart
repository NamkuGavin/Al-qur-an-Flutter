import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:alquran_project/api/api_url.dart';
import 'dart:convert';

import 'package:alquran_project/api/api_util.dart';

class ApiService extends ApiUtil implements ApiUrl {
  static final ApiService _apiService = ApiService._singleTon();

  factory ApiService() => _apiService;

  ApiService._singleTon();

  @override
  Future<void> get(
      {String? url,
      Map<String, String>? headers,
      Function(bool status, String message, Map<String, dynamic> response)?
          callback}) async {
    http.get(Uri.parse(url!), headers: headers).then((value) {
      callback!(value.statusCode == 200,
          value.statusCode == 200 ? "sukses" : "gagal", jsonDecode(value.body));
    }).catchError((error) {
      callback!(false, error.toString(), {});
    }).timeout(Duration(seconds: 30), onTimeout: () {
      callback!(false, "Timeout", {});
    });
  }
}
