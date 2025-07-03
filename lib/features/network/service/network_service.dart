import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// PRODUCTION APPLICATION

class NetworkService {
  static const String baseUrl = "http://mapp.rcinz.com";
  static const String productionGstBaseUrl = "https://api.whitebooks.in";

  //static const String baseUrl = "http://localhost:8000";

  Future<http.StreamedResponse> get(String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    var request = http.Request('GET', Uri.parse(baseUrl + url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> post(String url, dynamic requestBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    var request = http.Request('POST', Uri.parse(baseUrl + url));
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
    var request = http.Request('DELETE', Uri.parse(baseUrl + url));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> put(String url, dynamic requestBody) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    var headers = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token"
    };
    var request = http.Request('PUT', Uri.parse(baseUrl + url));
    request.body = jsonEncode(requestBody);
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<bool> isTokenValid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("auth_token");
    if (token != null) {
      return !JwtDecoder.isExpired(token);
    }
    return false;
  }

  Future<http.StreamedResponse> authorizeGst(dynamic requestBody, String url) async {
    Map<String, String> headers = {
      'accept': '*/*',
      'username': requestBody['usrname'],
      'password': requestBody['pwd'],
      'ip_address': requestBody['ipAddress'],
      'client_id': requestBody['clId'],
      'client_secret': requestBody['clSec'],
      'gstin': requestBody['gstin']
    };

    var request = http.Request(
        'GET',
        Uri.parse(
            '$url/einvoice/authenticate?email=${requestBody['email']}'));
    request.bodyFields = {};
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    return response;
  }
}
