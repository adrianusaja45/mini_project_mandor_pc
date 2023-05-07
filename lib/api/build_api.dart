import 'package:dio/dio.dart';

import '../model/build_model.dart';

class ApiBuild {
  static const url = 'http://192.168.52.245:3000/builds';

  static Future<List<SavedBuild>> getBuild() async {
    final response = await Dio().get(url);
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<SavedBuild> builds =
          data.map<SavedBuild>((json) => SavedBuild.fromJson(json)).toList();
      return builds;
    } else {
      throw Exception('Failed to load data');
    }
  }

  //fetch by id

  static Future<List<SavedBuild>> getBuildById(int id) async {
    final response = await Dio().get('$url/$id');
    print('response: $response');
    if (response.statusCode == 200) {
      final List<dynamic> data = response.data;
      final List<SavedBuild> builds =
          data.map<SavedBuild>((json) => SavedBuild.fromJson(json)).toList();
      return builds;
    } else {
      throw Exception('Failed to load data');
    }
  }

//post
  static Future<SavedBuild> postBuild(SavedBuild savedBuild) async {
    final response = await Dio().post(url, data: savedBuild.toJson());
    print('response: $response');
    if (response.statusCode == 201) {
      print('response: ${response.data}');
      return SavedBuild.fromJson(response.data);
    } else {
      throw Exception('Failed to post data');
    }
  }

  //delete
  static Future<SavedBuild> deleteBuild(int id) async {
    final response = await Dio().delete('$url/$id');
    print('response: $response');
    if (response.statusCode == 200) {
      return SavedBuild.fromJson(response.data);
    } else {
      throw Exception('Failed to delete data');
    }
  }

  //update

  static Future<SavedBuild> updateBuild(SavedBuild savedBuild) async {
    final response =
        await Dio().put('$url/${savedBuild.id}', data: savedBuild.toJson());
    print('response: $response');
    if (response.statusCode == 200) {
      return SavedBuild.fromJson(response.data);
    } else {
      throw Exception('Failed to update data');
    }
  }
}
