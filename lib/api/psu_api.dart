import 'package:dio/dio.dart';

import '/model/psu_model.dart';

class ApiPsu {
  static const String url = 'http://192.168.174.109:3000/psu';

  static Future<List<PsuModel>> getPsu() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<PsuModel> psu =
          data.map<PsuModel>((json) => PsuModel.fromJson(json)).toList();
      return psu;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
