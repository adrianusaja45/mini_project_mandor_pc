import 'package:dio/dio.dart';

import '/model/motherboard_model.dart';

class ApiMotherboard {
  static const String url = 'http://192.168.52.245:3000/mobo';

  Future<List<MotherboardModel>> getMobo() async {
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
