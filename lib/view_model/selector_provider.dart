import 'package:flutter/material.dart';

import '../api/case_api.dart';
import '../api/cpu_api.dart';
import '../api/cpu_cooler_api.dart';
import '../api/gpu_api.dart';
import '../api/motherboard_api.dart';
import '../api/psu_api.dart';
import '../api/ram_api.dart';
import '../api/storage_api.dart';
import '../model/case_model.dart';
import '../model/cpu_cooler_model.dart';
import '../model/cpu_model.dart';
import '../model/gpu_model.dart';
import '../model/motherboard_model.dart';
import '../model/psu_model.dart';
import '../model/ram_model.dart';
import '../model/storage_model.dart';

class SelectorProvider extends ChangeNotifier {
  List<CpuModel> _cpuList = [];
  List<GpuModel> _gpuList = [];
  List<RamModel> _ramList = [];
  List<MotherboardModel> _moboList = [];
  List<CaseModel> _caseList = [];
  List<PsuModel> _psuList = [];
  List<StorageModel> _storageList = [];
  List<CpuCoolerModel> _cpuCoolerList = [];

  double _currentBudget = 0;
  double get currentBudget => _currentBudget;

  Future<void> fetchCpu() async {
    _cpuList = await ApiCpu().getCpu();
    notifyListeners();
  }

  Future<void> fetchGpu() async {
    _gpuList = await ApiGpu().getGpu();
    debugPrint('gpuList: ${_gpuList[0].price.value}');
    notifyListeners();
  }

  Future<void> fetchRam() async {
    _ramList = await ApiRam().getRam();
    notifyListeners();
  }

  Future<void> fetchMobo() async {
    _moboList = await ApiMotherboard().getMobo();
    notifyListeners();
  }

  Future<void> fetchCase() async {
    _caseList = await ApiCase().getCase();
    notifyListeners();
  }

  Future<void> fetchPsu() async {
    _psuList = await ApiPsu().getPsu();
    notifyListeners();
  }

  Future<void> fetchStorage() async {
    _storageList = await ApiStorage().getStorage();
    notifyListeners();
  }

  Future<void> fetchCpuCooler() async {
    _cpuCoolerList = await ApiCooler().getCpuCooler();
    notifyListeners();
  }

  List<CpuModel> get cpuList => _cpuList;

  List<GpuModel> get gpuList => _gpuList;

  List<RamModel> get ramList => _ramList;

  List<MotherboardModel> get moboList => _moboList;

  List<CaseModel> get caseList => _caseList;

  List<PsuModel> get psuList => _psuList;

  List<StorageModel> get storageList => _storageList;

  List<CpuCoolerModel> get cpuCoolerList => _cpuCoolerList;

  //sort product by budget
  void onSliderBudgetValueChange(double value) {
    _currentBudget = value;
    notifyListeners();
  }

  List<dynamic> getSortedProducts(double totalBudget) {
    // calculate the budget for each product
    double cpuBudget = 0.2 * totalBudget;
    double gpuBudget = 0.2 * totalBudget;
    double ramBudget = 0.05 * totalBudget;
    double moboBudget = 0.2 * totalBudget;
    double caseBudget = 0.025 * totalBudget;
    double psuBudget = 0.2 * totalBudget;
    double storageBudget = 0.1 * totalBudget;
    double cpuCoolerBudget = 0.025 * totalBudget;

    // sort the products by price
    _cpuList.sort((a, b) => a.price.value.compareTo(b.price.value));
    _gpuList.sort((a, b) => a.price.value.compareTo(b.price.value));
    _ramList.sort((a, b) => a.price.value.compareTo(b.price.value));
    _moboList.sort((a, b) => a.price!.value.compareTo(b.price!.value));
    _caseList.sort((a, b) => a.price!.value.compareTo(b.price!.value));
    _psuList.sort((a, b) => a.price.value.compareTo(b.price.value));
    _storageList.sort((a, b) => a.price.value!.compareTo(b.price.value!));
    _cpuCoolerList.sort((a, b) => a.price!.value.compareTo(b.price!.value));

    // filter the products based on the budget
    List<CpuModel> filteredCPUs =
        _cpuList.where((cpu) => cpu.price.value <= cpuBudget).toList();
    List<GpuModel> filteredGPUs =
        _gpuList.where((gpu) => gpu.price.value <= gpuBudget).toList();
    List<RamModel> filteredRAMs =
        _ramList.where((ram) => ram.price.value <= ramBudget).toList();

    List<MotherboardModel> filteredMobos =
        _moboList.where((mobo) => mobo.price!.value <= moboBudget).toList();

    List<CaseModel> filteredCases = _caseList
        .where((caseItem) => caseItem.price!.value <= caseBudget)
        .toList();

    List<PsuModel> filteredPsus =
        _psuList.where((psu) => psu.price.value <= psuBudget).toList();

    List<StorageModel> filteredStorages = _storageList
        .where((storage) => storage.price.value! <= storageBudget)
        .toList();

    List<CpuCoolerModel> filteredCpuCoolers = _cpuCoolerList
        .where((cpuCooler) => cpuCooler.price!.value <= cpuCoolerBudget)
        .toList();

    // get the last item from each filtered product list
    List<dynamic> selectedProducts = [];
    if (filteredCPUs.isNotEmpty) {
      selectedProducts.add(filteredCPUs.last);
    }
    if (filteredGPUs.isNotEmpty) {
      selectedProducts.add(filteredGPUs.last);
    }

    if (filteredMobos.isNotEmpty) {
      selectedProducts.add(filteredMobos.last);
    }

    if (filteredRAMs.isNotEmpty) {
      selectedProducts.add(filteredRAMs.last);
    }

    if (filteredStorages.isNotEmpty) {
      selectedProducts.add(filteredStorages.last);
    }

    if (filteredPsus.isNotEmpty) {
      selectedProducts.add(filteredPsus.last);
    }
    if (filteredCases.isNotEmpty) {
      selectedProducts.add(filteredCases.last);
    }

    if (filteredCpuCoolers.isNotEmpty) {
      selectedProducts.add(filteredCpuCoolers.last);
    }
    return selectedProducts;
  }
}
