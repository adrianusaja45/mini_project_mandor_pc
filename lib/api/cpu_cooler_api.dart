import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '/model/cpu_cooler_model.dart';

class ApiCooler {
  static const String url = 'http://192.168.52.245:3000/cpuCooler';

  Future<List<CpuCoolerModel>> getCpuCooler() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<CpuCoolerModel> cpuCooler = data
          .map<CpuCoolerModel>((json) => CpuCoolerModel.fromJson(json))
          .toList();
      return cpuCooler;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
