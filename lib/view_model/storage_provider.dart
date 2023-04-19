import 'package:flutter/material.dart';

import '../api/storage_api.dart';
import '../model/storage_model.dart';

enum RequestState { empty, loading, loaded, error }

class StorageProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<StorageModel> _storage = [];
  List<StorageModel> get storage => _storage;

  String _message = '';
  String get message => _message;

  Future<void> fetchStorage() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiStorage.getStorage();
      _storage = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
