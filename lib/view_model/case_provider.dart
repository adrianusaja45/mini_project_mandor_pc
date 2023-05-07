import 'package:flutter/material.dart';

import '../api/case_api.dart';
import '../model/case_model.dart';

enum RequestState { empty, loading, loaded, error }

class CaseProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<CaseModel> _casing = [];
  List<CaseModel> get casing => _casing;

  String _message = '';
  String get message => _message;

  Future<void> fetchCasing() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiCase().getCase();
      _casing = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
