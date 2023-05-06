import 'package:dio/dio.dart';

import '/model/case_model.dart';

class ApiCase {
  static const String url = 'http://192.168.174.109:3000/case';

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
