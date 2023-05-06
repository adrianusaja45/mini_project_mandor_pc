import 'package:flutter/material.dart';

import '../api/cpu_api.dart';
import '../model/cpu_model.dart';

enum RequestState { empty, loading, loaded, error }

class CpuProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<CpuModel> _cpu = [];
  List<CpuModel> get cpu => _cpu;

  String _message = '';
  String get message => _message;

  Future<void> fetchCpu() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiCpu().getCpu();
      _cpu = result;

      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
