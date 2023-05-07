import 'package:flutter/material.dart';

import '../api/motherboard_api.dart';
import '../model/motherboard_model.dart';

enum RequestState { empty, loading, loaded, error }

class MoboProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<MotherboardModel> _mobo = [];
  List<MotherboardModel> get mobo => _mobo;

  String _message = '';
  String get message => _message;

  Future<void> fetchMobo() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiMotherboard().getMobo();
      _mobo = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
