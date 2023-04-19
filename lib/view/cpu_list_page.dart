import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/cpu_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
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
                      onTap: () {},
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
                                Text(
                                    'Rating : ${cpu.cpu[index].rating ?? 'No rating yet'}'),
                                Text(
                                    'Total Rating : ${cpu.cpu[index].ratingsTotal ?? 'No rating yet'}'),
                                Text('USD ${cpu.cpu[index].price?.value}'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {},
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
