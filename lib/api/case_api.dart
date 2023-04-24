import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '/model/case_model.dart';

class ApiCase {
  static const String url = 'http://192.168.251.119:3000/case';

  static Future<List<CaseModel>> getCase() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<CaseModel> casing =
          data.map<CaseModel>((json) => CaseModel.fromJson(json)).toList();
      return casing;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
