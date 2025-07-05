// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:e_commerce_admin_panel/utils/contants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = mainUrl;

  Future<http.Response> getData({required String endUrl}) async {
    final url = Uri.parse('$mainUrl/$endUrl');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print('success');
        return response;
      } else {
        print("error");
        return http.Response(
          json.encode({'error': 'error with status ${response.statusCode}'}),
          response.statusCode,
        );
      }
    } catch (e) {
      return http.Response(json.encode({'message': '$e'}), 500);
    }
  }

  Future<http.Response> addData({
    required String endUrl,
    required dynamic data,
  }) async {
    final url = Uri.parse('$mainUrl/$endUrl');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return response;
    } catch (e) {
      print('Error: $e');
      return http.Response(json.encode({'message': e.toString()}), 500);
    }
  }

  Future<http.Response> updateData({
    required String endUrl,
    required dynamic data,
    required String itemId,
  }) async {
    final url = Uri.parse('$mainUrl/$endUrl/$itemId');
    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return response;
    } catch (e) {
      print('$e');
      return http.Response(json.encode({'message':e.toString()}), 500);
    }
  }

  Future<http.Response> deleteData({
    required String endUrl,
    required String itemId,
  }) async {
    final url = Uri.parse('$mainUrl/$endUrl/$itemId');
    try {
      final response = await http.delete(url);
      return response;
    } catch (e) {
      print('$e');
      return http.Response(json.encode({'message':e.toString()}), 500);
    }
  }
}
