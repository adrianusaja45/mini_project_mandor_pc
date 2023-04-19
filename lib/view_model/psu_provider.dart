import 'package:flutter/material.dart';

import '../api/psu_api.dart';
import '../model/psu_model.dart';

enum RequestState { empty, loading, loaded, error }

class PsuProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<PsuModel> _psu = [];
  List<PsuModel> get psu => _psu;

  String _message = '';
  String get message => _message;

  Future<void> fetchPsu() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiPsu.getPsu();
      _psu = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
