import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/gpu_provider.dart';

class GpuListPage extends StatefulWidget {
  const GpuListPage({super.key});

  @override
  State<GpuListPage> createState() => _GpuListPageState();
}

class _GpuListPageState extends State<GpuListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<GpuProvider>(context, listen: false).fetchGpu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      // body: const Center(
      //   child: Text('Silakan klik tombol add untuk memulai'),
      // ),

      body: Consumer<GpuProvider>(builder: (context, gpu, child) {
        if (gpu.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (gpu.state == RequestState.loaded) {
          return ListView.builder(
              itemCount: gpu.gpu.length,
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
                                  gpu.gpu[index].title,
                                  textAlign: TextAlign.justify,
                                ),
                                Image.network(gpu.gpu[index].image),
                                Text(
                                    'Rating : ${gpu.gpu[index].rating ?? 'No rating yet'}'),
                                Text(
                                    'Total Rating : ${gpu.gpu[index].ratingsTotal ?? 'No rating yet'}'),
                                Text('USD ${gpu.gpu[index].price?.value}'),
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
        } else if (gpu.state == RequestState.error) {
          return Center(
            child: Text(gpu.message),
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
