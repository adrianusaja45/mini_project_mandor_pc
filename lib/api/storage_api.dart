import 'package:dio/dio.dart';

import '/model/storage_model.dart';

class ApiStorage {
  static const String url = 'http://192.168.52.245:3000/storage';

  Future<List<StorageModel>> getStorage() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<StorageModel> storage = data
          .map<StorageModel>((json) => StorageModel.fromJson(json))
          .toList();
      return storage;
    } else {
      throw Exception('Failed to load data');
    }
  }
}
