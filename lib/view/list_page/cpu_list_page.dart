import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '/view_model/cpu_provider.dart';

typedef DataCallback = void Function(int id);

class CpuListPage extends StatefulWidget {
  final DataCallback callback;
  const CpuListPage({super.key, required this.callback});

  @override
  State<CpuListPage> createState() => _CpuListPageState();
}

class _CpuListPageState extends State<CpuListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<CpuProvider>(context, listen: false).fetchCpu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      body: Consumer<CpuProvider>(builder: (context, cpu, child) {
        if (cpu.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (cpu.state == RequestState.loaded) {
          return ListView.builder(
              itemCount: cpu.cpu.length,
              itemBuilder: (context, index) {
                return Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        int id = cpu.cpu[index].id;

                        Navigator.of(context)
                            .pushNamed('/cpuDetail', arguments: id);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Text(
                                  cpu.cpu[index].title,
                                  textAlign: TextAlign.justify,
                                ),
                                Image.network(cpu.cpu[index].image),
                                Text('Rating : ${cpu.cpu[index].rating}'),
                                Text(
                                    'Total Rating : ${cpu.cpu[index].ratingsTotal}'),
                                Text('USD ${cpu.cpu[index].price.value}'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                widget.callback(cpu.cpu[index].id);
                                Navigator.pop(context);
                              },
                              child: const Text('Add to Cart'))
                        ],
                      ),
                    ));
              });
        } else if (cpu.state == RequestState.error) {
          return Center(
            child: Text(cpu.message),
          );
        } else {
          return const Center(
            child: Text('Silakan klik tombol add untuk memulai'),
          );
        }
      }),
    );
  }
}
