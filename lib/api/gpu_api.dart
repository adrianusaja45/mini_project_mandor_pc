import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '/model/gpu_model.dart';

class ApiGpu {
  static const String url = 'http://192.168.241.166:3000/gpu';

  static Future<List<GpuModel>> getGpu() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<GpuModel> gpu =
          data.map<GpuModel>((json) => GpuModel.fromJson(json)).toList();
      return gpu;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
