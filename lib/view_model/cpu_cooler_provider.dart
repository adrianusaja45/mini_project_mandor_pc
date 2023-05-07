import 'package:flutter/material.dart';

import '../api/cpu_cooler_api.dart';
import '../model/cpu_cooler_model.dart';

enum RequestState { empty, loading, loaded, error }

class CpuCoolerProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<CpuCoolerModel> _cooler = [];
  List<CpuCoolerModel> get cooler => _cooler;

  String _message = '';
  String get message => _message;

  Future<void> fetchCooler() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiCooler().getCpuCooler();
      _cooler = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
