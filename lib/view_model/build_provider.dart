import 'package:flutter/material.dart';

import '../api/build_api.dart';
import '../model/build_model.dart';

enum RequestState { empty, loading, loaded, error }

class BuildProvider extends ChangeNotifier {
  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<SavedBuild> _builds = [];
  List<SavedBuild> get builds => _builds;

  String _message = '';
  String get message => _message;

  bool isSuccess = false;
  Future<void> fetchBuild() async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiBuild.getBuild();
      _builds = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //fetch by id

  Future<void> fetchBuildById(int id) async {
    _state = RequestState.loading;
    notifyListeners();
    try {
      final result = await ApiBuild.getBuildById(id);
      _builds = result;
      _state = RequestState.loaded;

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

//delete
  Future<void> deleteBuild(int id, int index) async {
    notifyListeners();
    try {
      final result = await ApiBuild.deleteBuild(id);
      _builds.remove(result);
      _builds.removeAt(index);
      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //post

  Future<void> postBuild(SavedBuild savedBuild) async {
    notifyListeners();
    try {
      final result = await ApiBuild.postBuild(savedBuild);
      _builds.add(result);

      isSuccess = true;
      debugPrint("HASIL : $result");
      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }

  //update

  Future<void> updateBuild(SavedBuild savedBuild) async {
    notifyListeners();
    try {
      final result = await ApiBuild.updateBuild(savedBuild);
      _builds.add(result);

      isSuccess = true;
      debugPrint("HASIL UPDATE : $result");

      notifyListeners();
    } catch (e) {
      _state = RequestState.error;
      _message = e.toString();
      notifyListeners();
    }
  }
}
