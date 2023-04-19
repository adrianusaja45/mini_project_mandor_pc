import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '/model/motherboard_model.dart';

class ApiMotherboard {
  static const String url = 'http://192.168.241.166:3000/psu';

  static Future<List<MotherboardModel>> getMobo() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<MotherboardModel> mobo = data
          .map<MotherboardModel>((json) => MotherboardModel.fromJson(json))
          .toList();
      return mobo;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
