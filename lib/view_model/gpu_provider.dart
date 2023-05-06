import 'package:flutter/material.dart';

import '../api/gpu_api.dart';
import '../model/gpu_model.dart';

enum RequestState { empty, loading, loaded, error }

class GpuProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<GpuModel> _gpu = [];
  List<GpuModel> get gpu => _gpu;

  String _message = '';
  String get message => _message;

  Future<void> fetchGpu() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiGpu().getGpu();
      _gpu = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
