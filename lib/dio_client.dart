import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eassets/loginscreen.dart';
import 'package:eassets/urlscreen.dart';
import 'package:eassets/utility.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;


class DioClient {
  static String? token;

  static late Dio dio;

  static Future<http.Response> get(String uri,
      {Map<String, dynamic>? data}) async {
    try {
      token = await Utility.getSharedPreferences(API_TOKEN);
      Map<String, String> headers = {};
      if (token != null) {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + token!
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
      }

      var url;
      if (data != null) {
        String queryString = Uri(queryParameters: data).query;
        var requestUrl = UrlConstantscreen.BASE_URL + uri + '?' + queryString;

        url = Uri.parse(requestUrl);

      } else {
        url = Uri.parse(UrlConstantscreen.BASE_URL + uri);
      }
      final response = await http.get(url, headers: headers);

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {
      throw e;
    }
  }

  static Future<http.Response> post(String uri, {body}) async {
    try {
      token = await Utility.getSharedPreferences(API_TOKEN);
      Map<String, String> headers = {};
      if (token != null) {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          HttpHeaders.authorizationHeader: 'Bearer ' + token!
        };
      } else {
        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        };
      }

      var url = Uri.parse(UrlConstantscreen.BASE_URL + uri);

      final response = await http.post(url, headers: headers, body: body);

      debugPrint("Status Code "+  response.statusCode.toString());

      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException("Unable to process the data");
    } catch (e) {


      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => AlertPage(
      //           message: "Network error, Check your connectivity",
      //         )));
      // AlertPage
      //

      throw e;
    }
  }

}

class Dio {
}

