import 'package:flutter/material.dart';

import '../api/ram_api.dart';
import '../model/ram_model.dart';

enum RequestState { empty, loading, loaded, error }

class RamProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<RamModel> _ram = [];
  List<RamModel> get ram => _ram;

  String _message = '';
  String get message => _message;

  Future<void> fetchRam() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiRam.getRam();
      _ram = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
