import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String base_url = 'https://dapi.kakao.com'; //iphone xr
String append_url = '/v2/search/image';
String apiKey = '674a1b4f779b6705f3dedad54ce63146'; //카카오개발자키 RESTAPI

abstract class BaseClass {
  ///
  /// HTTP GET
  ///
  Future<void> eGet(String primitive, Map<String, String>? params) async {
    String paramStr = '';
    params!.forEach((key, value) {
      paramStr += key + '=' + value + '&';
    });
    Uri uri = Uri.parse(base_url + append_url + '?' + paramStr);
    Map<String, String> keys = {"Authorization": "KakaoAK $apiKey"};
    await http
        .get(uri, headers: keys)
        .timeout(const Duration(seconds: 10))
        .then((response) {
      var statusCode = response.statusCode;
      Map body = json.decode(response.body);
      if (statusCode == 200) {
        actionPost(primitive, body);
      } else {
        debugPrint('eGet exception');
        throw Exception(' Failed to load Data ');
      }
    }).onError((error, stackTrace) {
      debugPrint('eGet onError' + error.toString());
      actionPost(primitive, null);
      return null;
    });
  }

  void actionPost(String primitive, dynamic response);
}
