import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/model/build_model.dart';
import 'package:mini_project_mandor_pc/view/home_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/cpu_cooler_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/gpu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/motherboard_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/case_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/psu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/ram_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/storage_list_page.dart';
import 'package:mini_project_mandor_pc/view/widget/animation_page_route.dart';
import 'package:mini_project_mandor_pc/view/widget/custom_page_route.dart';
import 'package:mini_project_mandor_pc/view_model/build_provider.dart';
import 'package:mini_project_mandor_pc/view_model/gpu_provider.dart';
import 'package:mini_project_mandor_pc/view_model/psu_provider.dart';
import 'package:mini_project_mandor_pc/view_model/ram_provider.dart';
import 'package:mini_project_mandor_pc/view_model/storage_provider.dart';
import 'package:provider/provider.dart';
import '../view_model/case_provider.dart';
import '../view_model/cpu_cooler_provider.dart';
import '../view_model/cpu_provider.dart';
import '../view_model/motherboard_provider.dart';
import 'list_page/cpu_list_page.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  final List<String> _list = [
    'CPU',
    'GPU',
    'Motherboard',
    'RAM',
    'Storage',
    'PSU',
    'Case',
    'CPU Cooler'
  ];
  int? _cpuId;

  void _getCpuId(int? id) {
    setState(() {
      _cpuId = id;
    });
  }

  int? _psuId;

  void _getPsuId(int? id) {
    setState(() {
      _psuId = id;
    });
  }

  int? _casingId;
  void _getCasingId(int? id) {
    setState(() {
      _casingId = id;
    });
  }

  int? _coolerId;
  void _getCoolerId(int? id) {
    setState(() {
      _coolerId = id;
    });
  }

  int? _gpuId;
  void _getGpuId(int? id) {
    setState(() {
      _gpuId = id;
    });
  }

  int? _moboId;
  void _getMoboId(int? id) {
    setState(() {
      _moboId = id;
    });
  }

  int? _ramId;
  void _getRamId(int? id) {
    setState(() {
      _ramId = id;
    });
  }

  int? _storageId;
  void _getStorageId(int? id) {
    setState(() {
      _storageId = id;
    });
  }

  final titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<GpuProvider>(context, listen: false).fetchGpu());
    Future.microtask(
        () => Provider.of<MoboProvider>(context, listen: false).fetchMobo());
    Future.microtask(
        () => Provider.of<PsuProvider>(context, listen: false).fetchPsu());
    Future.microtask(
        () => Provider.of<RamProvider>(context, listen: false).fetchRam());
    Future.microtask(() =>
        Provider.of<StorageProvider>(context, listen: false).fetchStorage());
    Future.microtask(
        () => Provider.of<CpuProvider>(context, listen: false).fetchCpu());
    Future.microtask(() =>
        Provider.of<CpuCoolerProvider>(context, listen: false).fetchCooler());
    Future.microtask(
        () => Provider.of<CaseProvider>(context, listen: false).fetchCasing());

    Future.microtask(
        () => Provider.of<BuildProvider>(context, listen: false).fetchBuild());
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final buildId = ModalRoute.of(context)!.settings.arguments as int?;

    final build = Provider.of<BuildProvider>(context, listen: false).builds;
    int indexBuild = build.indexWhere((element) => element.id == buildId);

    debugPrint('buildId: $buildId');
    debugPrint('indexBuild: $indexBuild');

    final cpu = Provider.of<CpuProvider>(context, listen: false).cpu;
    int indexCpu = cpu.indexWhere((element) => element.id == _cpuId);

    final gpu = Provider.of<GpuProvider>(context, listen: false).gpu;
    int? indexGpu = gpu.indexWhere((element) => element.id == _gpuId);

    final psu = Provider.of<PsuProvider>(context, listen: false).psu;
    int indexPsu = psu.indexWhere((element) => element.id == _psuId);

    final casing = Provider.of<CaseProvider>(context, listen: false).casing;
    int indexCasing = casing.indexWhere((element) => element.id == _casingId);

    final cooler =
        Provider.of<CpuCoolerProvider>(context, listen: false).cooler;
    int indexCooler = cooler.indexWhere((element) => element.id == _coolerId);

    final mobo = Provider.of<MoboProvider>(context, listen: false).mobo;
    int indexMobo = mobo.indexWhere((element) => element.id == _moboId);

    final ram = Provider.of<RamProvider>(context, listen: false).ram;
    int indexRam = ram.indexWhere((element) => element.id == _ramId);

    final storage =
        Provider.of<StorageProvider>(context, listen: false).storage;
    int indexStorage =
        storage.indexWhere((element) => element.id == _storageId);

    Future<void> update() async {
      String title = titleController.text.trim();

      SavedBuild savedBuild =
          SavedBuild(id: buildId, titleBuild: title, buildItems: [
        _cpuId != null
            ? BuildItem(
                idPart: _cpuId,
                title: cpu[indexCpu].title,
                image: cpu[indexCpu].image,
                price: Price(
                    symbol: cpu[indexCpu].price.symbol.toString(),
                    value: cpu[indexCpu].price.value,
                    currency: cpu[indexCpu].price.currency.toString(),
                    raw: cpu[indexCpu].price.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[0].idPart,
                title: build[indexBuild].buildItems?[0].title,
                image: build[indexBuild].buildItems?[0].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[0]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[0].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[0]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[0]
                        .price
                        ?.raw
                        .toString())),
        _gpuId != null
            ? BuildItem(
                idPart: _gpuId,
                title: gpu[indexGpu].title,
                image: gpu[indexGpu].image,
                price: Price(
                    symbol: gpu[indexGpu].price.symbol.toString(),
                    value: gpu[indexGpu].price.value,
                    currency: gpu[indexGpu].price.currency.toString(),
                    raw: gpu[indexGpu].price.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[1].idPart,
                title: build[indexBuild].buildItems?[1].title,
                image: build[indexBuild].buildItems?[1].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[1]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[1].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[1]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[1]
                        .price
                        ?.raw
                        .toString())),
        _moboId != null
            ? BuildItem(
                idPart: _moboId,
                title: mobo[indexMobo].title,
                image: mobo[indexMobo].image,
                price: Price(
                    symbol: mobo[indexMobo].price?.symbol.toString(),
                    value: mobo[indexMobo].price?.value,
                    currency: mobo[indexMobo].price?.currency.toString(),
                    raw: mobo[indexMobo].price?.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[2].idPart,
                title: build[indexBuild].buildItems?[2].title,
                image: build[indexBuild].buildItems?[2].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[2]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[2].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[2]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[2]
                        .price
                        ?.raw
                        .toString())),
        _ramId != null
            ? BuildItem(
                idPart: _ramId,
                title: ram[indexRam].title,
                image: ram[indexRam].image,
                price: Price(
                    symbol: ram[indexRam].price.symbol.toString(),
                    value: ram[indexRam].price.value,
                    currency: ram[indexRam].price.currency.toString(),
                    raw: ram[indexRam].price.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[3].idPart,
                title: build[indexBuild].buildItems?[3].title,
                image: build[indexBuild].buildItems?[3].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[3]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[3].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[3]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[3]
                        .price
                        ?.raw
                        .toString())),
        _storageId != null
            ? BuildItem(
                idPart: _storageId,
                title: storage[indexStorage].title,
                image: storage[indexStorage].image,
                price: Price(
                    symbol: storage[indexStorage].price.symbol.toString(),
                    value: storage[indexStorage].price.value,
                    currency: storage[indexStorage].price.currency.toString(),
                    raw: storage[indexStorage].price.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[4].idPart,
                title: build[indexBuild].buildItems?[4].title,
                image: build[indexBuild].buildItems?[4].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[4]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[4].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[4]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[4]
                        .price
                        ?.raw
                        .toString())),
        _psuId != null
            ? BuildItem(
                idPart: _psuId,
                title: psu[indexPsu].title,
                image: psu[indexPsu].image,
                price: Price(
                    symbol: psu[indexPsu].price.symbol.toString(),
                    value: psu[indexPsu].price.value,
                    currency: psu[indexPsu].price.currency.toString(),
                    raw: psu[indexPsu].price.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[5].idPart,
                title: build[indexBuild].buildItems?[5].title,
                image: build[indexBuild].buildItems?[5].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[5]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[5].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[5]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[5]
                        .price
                        ?.raw
                        .toString())),
        _casingId != null
            ? BuildItem(
                idPart: _casingId,
                title: casing[indexCasing].title,
                image: casing[indexCasing].image,
                price: Price(
                    symbol: casing[indexCasing].price?.symbol.toString(),
                    value: casing[indexCasing].price?.value,
                    currency: casing[indexCasing].price?.currency.toString(),
                    raw: casing[indexCasing].price?.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[6].idPart,
                title: build[indexBuild].buildItems?[6].title,
                image: build[indexBuild].buildItems?[6].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[6]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[6].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[6]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[6]
                        .price
                        ?.raw
                        .toString())),
        _coolerId != null
            ? BuildItem(
                idPart: _coolerId,
                title: cooler[indexCooler].title,
                image: cooler[indexCooler].image,
                price: Price(
                    symbol: cooler[indexCooler].price?.symbol.toString(),
                    value: cooler[indexCooler].price?.value,
                    currency: cooler[indexCooler].price?.currency.toString(),
                    raw: cooler[indexCooler].price?.raw.toString()))
            : BuildItem(
                idPart: build[indexBuild].buildItems?[7].idPart,
                title: build[indexBuild].buildItems?[7].title,
                image: build[indexBuild].buildItems?[7].image,
                price: Price(
                    symbol: build[indexBuild]
                        .buildItems?[7]
                        .price
                        ?.symbol
                        .toString(),
                    value: build[indexBuild].buildItems?[7].price?.value,
                    currency: build[indexBuild]
                        .buildItems?[7]
                        .price
                        ?.currency
                        .toString(),
                    raw: build[indexBuild]
                        .buildItems?[7]
                        .price
                        ?.raw
                        .toString())),
      ]);

      var buildProvider = Provider.of<BuildProvider>(context, listen: false);

      await buildProvider.updateBuild(savedBuild);

      if (context.mounted) {
        if (buildProvider.isSuccess) {
          const snackBar = SnackBar(
              content: Text('Build updated successfully!',
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.blue);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacement(
              context, CustomPageRoute(child: const Home()));
        }
      }
    }

    Future<void> submit() async {
      String title = titleController.text.trim();

      SavedBuild savedBuild = SavedBuild(titleBuild: title, buildItems: [
        BuildItem(
            idPart: _cpuId,
            title: cpu[indexCpu].title,
            image: cpu[indexCpu].image,
            price: Price(
                symbol: cpu[indexCpu].price.symbol.toString(),
                value: cpu[indexCpu].price.value,
                currency: cpu[indexCpu].price.currency.toString(),
                raw: cpu[indexCpu].price.raw.toString())),
        BuildItem(
            idPart: _gpuId,
            title: gpu[indexGpu].title,
            image: gpu[indexGpu].image,
            price: Price(
                symbol: gpu[indexGpu].price.symbol.toString(),
                value: gpu[indexGpu].price.value,
                currency: gpu[indexGpu].price.currency.toString(),
                raw: gpu[indexGpu].price.raw.toString())),
        BuildItem(
            idPart: _moboId,
            title: mobo[indexMobo].title,
            image: mobo[indexMobo].image,
            price: Price(
                symbol: mobo[indexMobo].price?.symbol.toString(),
                value: mobo[indexMobo].price?.value,
                currency: mobo[indexMobo].price?.currency.toString(),
                raw: mobo[indexMobo].price?.raw.toString())),
        BuildItem(
            idPart: _ramId,
            title: ram[indexRam].title,
            image: ram[indexRam].image,
            price: Price(
                symbol: ram[indexRam].price.symbol.toString(),
                value: ram[indexRam].price.value,
                currency: ram[indexRam].price.currency.toString(),
                raw: ram[indexRam].price.raw.toString())),
        BuildItem(
            idPart: _storageId,
            title: storage[indexStorage].title,
            image: storage[indexStorage].image,
            price: Price(
                symbol: storage[indexStorage].price.symbol.toString(),
                value: storage[indexStorage].price.value,
                currency: storage[indexStorage].price.currency.toString(),
                raw: storage[indexStorage].price.raw.toString())),
        BuildItem(
            idPart: _psuId,
            title: psu[indexPsu].title,
            image: psu[indexPsu].image,
            price: Price(
                symbol: psu[indexPsu].price.symbol.toString(),
                value: psu[indexPsu].price.value,
                currency: psu[indexPsu].price.currency.toString(),
                raw: psu[indexPsu].price.raw.toString())),
        BuildItem(
            idPart: _casingId,
            title: casing[indexCasing].title,
            image: casing[indexCasing].image,
            price: Price(
                symbol: casing[indexCasing].price?.symbol.toString(),
                value: casing[indexCasing].price?.value,
                currency: casing[indexCasing].price?.currency.toString(),
                raw: casing[indexCasing].price?.raw.toString())),
        BuildItem(
            idPart: _coolerId,
            title: cooler[indexCooler].title,
            image: cooler[indexCooler].image,
            price: Price(
                symbol: cooler[indexCooler].price?.symbol.toString(),
                value: cooler[indexCooler].price?.value,
                currency: cooler[indexCooler].price?.currency.toString(),
                raw: cooler[indexCooler].price?.raw.toString())),
      ]);

      var buildProvider = Provider.of<BuildProvider>(context, listen: false);

      await buildProvider.postBuild(savedBuild);
      if (context.mounted) {
        if (buildProvider.isSuccess) {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        }
      }
    }

    if (buildId != null) {
      titleController.text = build[indexBuild].titleBuild as String;
    }

    var cpuPrice = _gpuId != null ? gpu[indexGpu].price.value : 0;
    var gpuPrice = _cpuId != null ? cpu[indexCpu].price.value : 0;
    var moboPrice = _moboId != null ? mobo[indexMobo].price?.value : 0;
    var ramPrice = _ramId != null ? ram[indexRam].price.value : 0;
    var storagePrice =
        _storageId != null ? storage[indexStorage].price.value : 0;
    var psuPrice = _psuId != null ? psu[indexPsu].price.value : 0;
    var casingPrice = _casingId != null ? casing[indexCasing].price?.value : 0;
    var coolerPrice = _coolerId != null ? cooler[indexCooler].price?.value : 0;

    var totalPrice = cpuPrice +
        gpuPrice +
        moboPrice! +
        ramPrice +
        storagePrice! +
        psuPrice +
        casingPrice! +
        coolerPrice!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: buildId != null
          ? SafeArea(
              child: Column(
                children: [
                  Container(
                    height: 643,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: ListView(
                      children: [
                        //CPU
                        Card(
                          child: ListTile(
                            leading: _cpuId != null
                                ? Image.network(
                                    cpu[indexCpu].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.network(
                                    build[indexBuild].buildItems![0].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _cpuId != null
                                ? Column(
                                    children: [
                                      Text(
                                        cpu[indexCpu].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text('USD ${cpu[indexCpu].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      CpuListPage(
                                                        callback: _getCpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![0].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![0].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      CpuListPage(
                                                        callback: _getCpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            onTap: () async {
                              if (_cpuId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CpuListPage(
                                              callback: _getCpuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //GPU
                        Card(
                          child: ListTile(
                            leading: _gpuId != null
                                ? Image.network(
                                    gpu[indexGpu].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.network(
                                    build[indexBuild].buildItems![1].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _gpuId != null
                                ? Column(
                                    children: [
                                      Text(
                                        gpu[indexGpu].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text('\$ ${gpu[indexGpu].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      GpuListPage(
                                                        callback: _getGpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![1].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![1].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      GpuListPage(
                                                        callback: _getGpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            // subtitle: Text(gpu.price.toString()),
                            onTap: () async {
                              if (_gpuId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GpuListPage(
                                              callback: _getGpuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                        //Motherboard
                        Card(
                          child: ListTile(
                            leading: _moboId != null
                                ? Image.network(
                                    mobo[indexMobo].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.network(
                                    build[indexBuild].buildItems![2].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _moboId != null
                                ? Column(
                                    children: [
                                      Text(mobo[indexMobo].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text(
                                          '\$ ${mobo[indexMobo].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      MoboListPage(
                                                        callback: _getMoboId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![2].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![2].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      MoboListPage(
                                                        callback: _getMoboId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            onTap: () async {
                              if (_moboId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MoboListPage(
                                              callback: _getMoboId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                        //RAM
                        Card(
                          child: ListTile(
                            leading: _ramId != null
                                ? Image.network(
                                    ram[indexRam].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.network(
                                    build[indexBuild].buildItems![3].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _ramId != null
                                ? Column(
                                    children: [
                                      Text(ram[indexRam].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text('\$ ${ram[indexRam].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      RamListPage(
                                                        callback: _getRamId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![3].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![3].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      RamListPage(
                                                        callback: _getRamId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            onTap: () async {
                              if (_ramId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RamListPage(
                                              callback: _getRamId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //Storage
                        Card(
                          child: ListTile(
                            leading: _storageId != null
                                ? Image.network(
                                    storage[indexStorage].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : Image.network(
                                    build[indexBuild].buildItems![4].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _storageId != null
                                ? Column(
                                    children: [
                                      Text(storage[indexStorage].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text(
                                          '\$ ${storage[indexStorage].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      StorageListPage(
                                                        callback: _getStorageId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![4].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![4].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      StorageListPage(
                                                        callback: _getStorageId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                            onTap: () async {
                              if (_storageId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StorageListPage(
                                              callback: _getStorageId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //PSU
                        Card(
                          child: ListTile(
                            leading: _psuId != null
                                ? Image.network(psu[indexPsu].image)
                                : Image.network(
                                    build[indexBuild].buildItems![5].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _psuId != null
                                ? Column(
                                    children: [
                                      Text(
                                        psu[indexPsu].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text('\$ ${psu[indexPsu].price.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        PsuListPage(
                                                          callback: _getPsuId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![5].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![5].price!.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        PsuListPage(
                                                          callback: _getPsuId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  ),
                            onTap: () async {
                              if (_psuId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => PsuListPage(
                                              callback: _getPsuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //Casing
                        Card(
                          child: ListTile(
                            leading: _casingId != null
                                ? Image.network(casing[indexCasing].image)
                                : Image.network(
                                    build[indexBuild].buildItems![6].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _casingId != null
                                ? Column(
                                    children: [
                                      Text(
                                        casing[indexCasing].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${casing[indexCasing].price?.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CaseListPage(
                                                          callback:
                                                              _getCasingId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![6].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![6].price!.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CaseListPage(
                                                          callback:
                                                              _getCasingId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  ),
                            onTap: () async {
                              if (_casingId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CaseListPage(
                                              callback: _getCasingId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //CPU Cooler
                        Card(
                          child: ListTile(
                            leading: _coolerId != null
                                ? Image.network(cooler[indexCooler].image)
                                : Image.network(
                                    build[indexBuild].buildItems![7].image!,
                                    width: 50,
                                    height: 50,
                                  ),
                            title: _coolerId != null
                                ? Column(
                                    children: [
                                      Text(
                                        cooler[indexCooler].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${cooler[indexCooler].price?.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CpuCoolerListPage(
                                                          callback:
                                                              _getCoolerId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        build[indexBuild].buildItems![7].title!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${build[indexBuild].buildItems![7].price!.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CpuCoolerListPage(
                                                          callback:
                                                              _getCoolerId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  ),
                            onTap: () async {
                              if (_coolerId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CpuCoolerListPage(
                                              callback: _getCoolerId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          //post data build provider and pop
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              backgroundColor: const Color(0xFFf5f8fa),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 20, 20, 0),
                                      child: Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(16),
                                            child: TextFormField(
                                              controller: titleController,
                                              decoration: const InputDecoration(
                                                hintText: 'Title',
                                                hintStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 88, 85, 85)),
                                                border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                update();
                                              },
                                              child: const Text('Submit'))
                                        ],
                                      ),
                                    ),
                                  ));
                        },
                        child: const Text('Submit Update')),
                  )
                ],
              ),
            )
          : SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  if (_cpuId != null ||
                      _gpuId != null ||
                      _moboId != null ||
                      _ramId != null ||
                      _storageId != null ||
                      _psuId != null ||
                      _casingId != null ||
                      _coolerId != null)
                    Text(
                      'Total Price: ${totalPrice.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.displayMedium,
                    )
                  else
                    Text(
                      'Total Price: 0',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 578,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 7,
                        ),
                      ],
                    ),
                    child: ListView(
                      children: [
                        //CPU
                        Card(
                          child: ListTile(
                            leading: _cpuId != null
                                ? Image.network(
                                    cpu[indexCpu].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.add),
                            title: _cpuId != null
                                ? Column(
                                    children: [
                                      Text(
                                        cpu[indexCpu].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text('\$ ${cpu[indexCpu].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      CpuListPage(
                                                        callback: _getCpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[0]),
                                      const Text('Click to choose CPU')
                                    ],
                                  ),
                            onTap: () async {
                              if (_cpuId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CpuListPage(
                                              callback: _getCpuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //GPU
                        Card(
                          child: ListTile(
                            leading: _gpuId != null
                                ? Image.network(
                                    gpu[indexGpu].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.add),
                            title: _gpuId != null
                                ? Column(
                                    children: [
                                      Text(gpu[indexGpu].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text('\$ ${gpu[indexGpu].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      GpuListPage(
                                                        callback: _getGpuId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[1]),
                                      const Text('Click to choose GPU')
                                    ],
                                  ),
                            // subtitle: Text(gpu.price.toString()),
                            onTap: () async {
                              if (_gpuId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => GpuListPage(
                                              callback: _getGpuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                        //Motherboard
                        Card(
                          child: ListTile(
                            leading: _moboId != null
                                ? Image.network(
                                    mobo[indexMobo].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.add),
                            title: _moboId != null
                                ? Column(
                                    children: [
                                      Text(mobo[indexMobo].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text(
                                          '\$ ${mobo[indexMobo].price?.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      MoboListPage(
                                                        callback: _getMoboId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[2]),
                                      const Text('Click to choose Motherboard')
                                    ],
                                  ),
                            onTap: () async {
                              if (_moboId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MoboListPage(
                                              callback: _getMoboId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                        //RAM
                        Card(
                          child: ListTile(
                            leading: _ramId != null
                                ? Image.network(
                                    ram[indexRam].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.add),
                            title: _ramId != null
                                ? Column(
                                    children: [
                                      Text(ram[indexRam].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text('\$ ${ram[indexRam].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      RamListPage(
                                                        callback: _getRamId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[3]),
                                      const Text('Click to choose RAM')
                                    ],
                                  ),
                            onTap: () async {
                              if (_ramId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RamListPage(
                                              callback: _getRamId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //Storage
                        Card(
                          child: ListTile(
                            leading: _storageId != null
                                ? Image.network(
                                    storage[indexStorage].image,
                                    width: 50,
                                    height: 50,
                                  )
                                : const Icon(Icons.add),
                            title: _storageId != null
                                ? Column(
                                    children: [
                                      Text(storage[indexStorage].title,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false),
                                      Text(
                                          '\$ ${storage[indexStorage].price.value}'),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await Navigator.push(
                                              context,
                                              SlidePageRoute(
                                                  builder: (context) =>
                                                      StorageListPage(
                                                        callback: _getStorageId,
                                                      )));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.swap_horiz),
                                            Text('Switch')
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[4]),
                                      const Text('Click to choose Storage')
                                    ],
                                  ),
                            onTap: () async {
                              if (_storageId == null) {
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => StorageListPage(
                                              callback: _getStorageId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //PSU
                        Card(
                          child: ListTile(
                            leading: _psuId != null
                                ? Image.network(psu[indexPsu].image)
                                : const Icon(Icons.add),
                            title: _psuId != null
                                ? Column(
                                    children: [
                                      Text(
                                        psu[indexPsu].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text('\$ ${psu[indexPsu].price.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        PsuListPage(
                                                          callback: _getPsuId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[5]),
                                      const Text('Click to choose PSU')
                                    ],
                                  ),
                            onTap: () async {
                              if (_psuId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => PsuListPage(
                                              callback: _getPsuId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //Casing
                        Card(
                          child: ListTile(
                            leading: _casingId != null
                                ? Image.network(casing[indexCasing].image)
                                : const Icon(Icons.add),
                            title: _casingId != null
                                ? Column(
                                    children: [
                                      Text(
                                        casing[indexCasing].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${casing[indexCasing].price?.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CaseListPage(
                                                          callback:
                                                              _getCasingId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[6]),
                                      const Text('Click to choose Casing')
                                    ],
                                  ),
                            onTap: () async {
                              if (_casingId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CaseListPage(
                                              callback: _getCasingId,
                                            )));
                              } else {}
                            },
                          ),
                        ),

                        //CPU Cooler
                        Card(
                          child: ListTile(
                            leading: _coolerId != null
                                ? Image.network(cooler[indexCooler].image)
                                : const Icon(Icons.add),
                            title: _coolerId != null
                                ? Column(
                                    children: [
                                      Text(
                                        cooler[indexCooler].title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                      ),
                                      Text(
                                          '\$ ${cooler[indexCooler].price?.value}'),
                                      ElevatedButton(
                                          onPressed: () async {
                                            await Navigator.push(
                                                context,
                                                SlidePageRoute(
                                                    builder: (context) =>
                                                        CpuCoolerListPage(
                                                          callback:
                                                              _getCoolerId,
                                                        )));
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: const [
                                              Icon(Icons.swap_horiz),
                                              Text('Switch')
                                            ],
                                          ))
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(_list[7]),
                                      const Text('Click to choose Cooler')
                                    ],
                                  ),
                            onTap: () async {
                              if (_coolerId == null) {
                                await Navigator.push(
                                    context,
                                    SlidePageRoute(
                                        builder: (context) => CpuCoolerListPage(
                                              callback: _getCoolerId,
                                            )));
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          //post data build provider and pop
                          showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              backgroundColor: const Color(0xFFf5f8fa),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(16),
                                          child: TextFormField(
                                            controller: titleController,
                                            decoration: const InputDecoration(
                                              hintText: 'Title',
                                              hintStyle: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 88, 85, 85)),
                                              border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              submit();
                                            },
                                            child: const Text('Submit'))
                                      ],
                                    ),
                                  )));
                        },
                        child: const Text('Submit')),
                  )
                ],
              ),
            ),
    );
  }
}
