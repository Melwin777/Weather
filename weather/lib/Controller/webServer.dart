import 'dart:convert';

import 'package:get/get.dart';

class WebServer extends GetConnect {
 Future<Response> gett(String url) => get(url, 
      );
  Future<Response> postUser(String url, Map data) =>
      post(url, jsonEncode(data), contentType: 'application/json', );
  Future<Response> putUser(String url, Map data) =>
      put(url, jsonEncode(data), contentType: 'application/json', );
}