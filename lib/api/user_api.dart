import 'package:dio/dio.dart';

import '../model/user_model.dart';

class ApiUser {
  final String urlRegister = 'http://192.168.52.245:3000/register';
  final String urlLogin = 'http://192.168.52.245:3000/login';

  // Future<User> registerUser(User user) async {
  //   final response = await Dio().post(urlRegister, data: user.toJson());
  //   print('response: $response');
  //   if (response.statusCode == 201) {
  //     print('response: ${response.data}');
  //     return User.fromJson(response.data);
  //   } else {
  //     throw Exception('Failed to post data');
  //   }
  // }

  Future<User> loginUser(String name, String password) async {
    final response = await Dio().post(urlLogin, data: {
      'name': name,
      'password': password,
    });

    if (response.statusCode == 201) {
      print('response: ${response.data}');
      return User.fromJson(response.data);
    } else {
      throw Exception('Failed to login');
    }
  }
}
