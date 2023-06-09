import 'package:dio/dio.dart';

import '/model/cpu_model.dart';

class ApiCpu {
  static const String url = 'http://192.168.52.245:3000/cpu';

  Future<List<CpuModel>> getCpu() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<CpuModel> cpu =
          data.map<CpuModel>((json) => CpuModel.fromJson(json)).toList();
      return cpu;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
