import 'package:dio/dio.dart';

import '/model/ram_model.dart';

class ApiRam {
  static const String url = 'http://192.168.52.245:3000/ram';

  Future<List<RamModel>> getRam() async {
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
