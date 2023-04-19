import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '/model/ram_model.dart';

class ApiRam {
  static const String url = 'http://192.168.241.166:3000/ram';

  static Future<List<RamModel>> getRam() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<RamModel> ram =
          data.map<RamModel>((json) => RamModel.fromJson(json)).toList();
      return ram;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
