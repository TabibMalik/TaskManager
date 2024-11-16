import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:untitled/UI/controllers/auth.dart';
import 'package:untitled/UI/screens/sign_in_screen.dart';
import 'package:untitled/app.dart';
import '../models/network_response.dart';

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url}) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'token': AuthController.accessToken.toString(),
      };
      debugPrint(url); // Replaced invalid print call
      debugPrint(headers.toString()); // Replaced invalid print call
      final Response response = await get(uri, headers: headers);
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        if (decodeData['status'] == 'fail') {
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodeData['data'],
          );
        }
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        ); // Return successful response
      } else if (response.statusCode == 401) {
        await _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static Future<NetworkResponse> postRequest({
    required String url,
    Map<String, dynamic>? body,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'token': AuthController.accessToken.toString(),
      };
      debugPrint(url);
      final Response response = await post(
        uri,
        headers: headers,
        body: jsonEncode(body ?? {}), // Ensure body is non-null
      );
      printRequest(url, body ?? {}, headers); // Ensure body is non-null
      printResponse(url, response);
      if (response.statusCode == 200) {
        final decodeData = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodeData,
        );
      } else if (response.statusCode == 401) {
        await _moveToLogin();
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: 'Unauthenticated',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  static void printRequest(
      String url, Map<String, dynamic> body, Map<String, dynamic> headers) {
    debugPrint('REQUEST\nURL: $url\nBODY: $body\nHEADERS: $headers');
  }

  static void printResponse(String url, Response response) {
    debugPrint(
        'URL: $url\nRESPONSE CODE: ${response.statusCode}\nBODY: ${response.body}');
  }

  static Future<void> _moveToLogin() async {
    await AuthController.clearUserData();
    Navigator.pushAndRemoveUntil(
      TaskManager.navigatorKey.currentState!.context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
          (route) => false,
    );
  }
}
