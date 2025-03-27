import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class NetworkService {

  static const String baseUrl = "http://mapp.rcinz.com";
  //static const String baseUrl = "http://localhost:8000";

  Future<http.StreamedResponse> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    var request =
    http.Request('GET', Uri.parse(baseUrl + url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> post(String url, dynamic requestBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {'Content-Type': 'application/json', "Authorization" : "Bearer $token"};
    var request = http.Request(
        'POST',
        Uri.parse(baseUrl + url));
    request.body = jsonEncode(requestBody);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> delete(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    var request =
    http.Request('DELETE', Uri.parse(baseUrl + url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> put(String url, dynamic requestBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {'Content-Type': 'application/json', "Authorization" : "Bearer $token"};
    var request = http.Request(
        'PUT',
        Uri.parse(baseUrl + url));
    request.body = jsonEncode(requestBody);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    if(token != null) {
      return !JwtDecoder.isExpired(token);
    }
    return false;
  }

}