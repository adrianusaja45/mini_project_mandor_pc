import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/view/list_page/cpu_cooler_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/gpu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/motherboard_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/case_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/psu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/ram_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/storage_list_page.dart';
import 'package:mini_project_mandor_pc/view/widget/animation_page_route.dart';
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

  @override
  void initState() {
    // TODO: implement initState
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
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      body: Column(
        children: [
          Container(
            height: 600,
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
                              Text('Rating : ${cpu[indexCpu].rating}'),
                              Text(
                                  'Total Rating : ${cpu[indexCpu].ratingsTotal}'),
                              Text('USD ${cpu[indexCpu].price.value}'),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          builder: (context) => CpuListPage(
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
                              Text(gpu[indexGpu].title),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          builder: (context) => GpuListPage(
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
                              Text(mobo[indexMobo].title),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          builder: (context) => MoboListPage(
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
                              Text(ram[indexRam].title),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          builder: (context) => RamListPage(
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
                              Text(storage[indexStorage].title),
                              ElevatedButton(
                                onPressed: () async {
                                  await Navigator.push(
                                      context,
                                      SlidePageRoute(
                                          builder: (context) => StorageListPage(
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
                              Text('Rating : ${psu[indexPsu].rating}'),
                              Text('USD ${psu[indexPsu].price.value}'),
                              ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        SlidePageRoute(
                                            builder: (context) => PsuListPage(
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
                              Text('Rating : ${casing[indexCasing].rating}'),
                              Text('USD ${casing[indexCasing].price?.value}'),
                              ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        SlidePageRoute(
                                            builder: (context) => CaseListPage(
                                                  callback: _getCasingId,
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
                              Text('Rating : ${cooler[indexCooler].rating}'),
                              Text('USD ${cooler[indexCooler].price?.value}'),
                              ElevatedButton(
                                  onPressed: () async {
                                    await Navigator.push(
                                        context,
                                        SlidePageRoute(
                                            builder: (context) =>
                                                CpuCoolerListPage(
                                                  callback: _getCoolerId,
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
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child:
                ElevatedButton(onPressed: () {}, child: const Text('Submit')),
          )
        ],
      ),
    );
  }
}
