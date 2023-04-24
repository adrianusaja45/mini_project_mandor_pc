import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/model/psu_model.dart';
import 'package:mini_project_mandor_pc/view/detail_page/psu_detail.dart';

import 'package:mini_project_mandor_pc/view/list_page/cpu_cooler_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/gpu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/motherboard_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/case_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/psu_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/ram_list_page.dart';
import 'package:mini_project_mandor_pc/view/list_page/storage_list_page.dart';
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
  List<String> _list = [
    'CPU',
    'GPU',
    'Motherboard',
    'RAM',
    'Storage',
    'PSU',
    'Case',
    'CPU Cooler'
  ];

  int? _psuId;

  void _getId(int? id) {
    setState(() {
      _psuId = id;
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
    // if (_id != null) {
    // final gpu = Provider.of<GpuProvider>(context, listen: false)
    //     .gpu
    //     .firstWhere((element) => element.id == _id);
    // final mobo = Provider.of<MoboProvider>(context, listen: false)
    //     .mobo
    //     .firstWhere((element) => element.id == _id);
    // final ram = Provider.of<RamProvider>(context, listen: false)
    //     .ram
    //     .firstWhere((element) => element.id == _id);
    final psu = Provider.of<PsuProvider>(context, listen: false).psu;

    int index = psu.indexWhere((element) => element.id == _psuId);
    // final storage = Provider.of<StorageProvider>(context, listen: false)
    //     .storage
    //     .firstWhere((element) => element.id == _id);
    // final cpu = Provider.of<CpuProvider>(context, listen: false)
    //     .cpu
    //     .firstWhere((element) => element.id == _id);
    // final cooler = Provider.of<CpuCoolerProvider>(context, listen: false)
    //     .cooler
    //     .firstWhere((element) => element.id == _id);
    // final casing = Provider.of<CaseProvider>(context, listen: false)
    //     .casing
    //     .firstWhere((element) => element.id == _id);

    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: ListView(
          children: [
            Card(
              child: ListTile(
                title: Text(_list[0]),
                // subtitle: Text(cpu.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CpuListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[1]),
                // subtitle: Text(gpu.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GpuListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[2]),
                // subtitle: Text(mobo.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MoboListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[3]),
                // subtitle: Text(ram.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RamListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[4]),
                // subtitle: Text(storage.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StorageListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                leading: _psuId != null
                    ? Image.network(psu[index].image)
                    : const Icon(Icons.add),
                title: _psuId != null
                    ? Column(
                        children: [
                          Text(
                            psu[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                          Text('Rating : ${psu[index].rating}'),
                          Text('USD ${psu[index].price.value}')
                        ],
                      )
                    : Column(
                        children: [
                          Text(_list[5]),
                          const Text('Click to choose PSU')
                        ],
                      ),
                onTap: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _psuId != null
                              ? const PsuDetailPage()
                              : PsuListPage(
                                  callback: _getId,
                                )));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[6]),
                // subtitle: Text(cooler.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CpuCoolerListPage()));
                },
              ),
            ),
            Card(
              child: ListTile(
                title: Text(_list[7]),
                // subtitle: Text(casing.price.toString()),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CaseListPage()));
                },
              ),
            ),
          ],
        ));
  }
}
