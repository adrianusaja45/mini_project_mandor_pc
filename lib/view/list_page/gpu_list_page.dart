import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '/view_model/gpu_provider.dart';

typedef DataCallback = void Function(int id);

class GpuListPage extends StatefulWidget {
  final DataCallback callback;
  const GpuListPage({super.key, required this.callback});

  @override
  State<GpuListPage> createState() => _GpuListPageState();
}

class _GpuListPageState extends State<GpuListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<GpuProvider>(context, listen: false).fetchGpu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<GpuProvider>(builder: (context, gpu, child) {
        if (gpu.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (gpu.state == RequestState.loaded) {
          return SafeArea(
            child: ListView.builder(
                itemCount: gpu.gpu.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/gpuDetail',
                              arguments: gpu.gpu[index].id);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  const Color(0xFF6887ea),
                                ],
                              )),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Image.network(
                                      gpu.gpu[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text(
                                      'Rating : ${gpu.gpu[index].rating ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Total Rating : ${gpu.gpu[index].ratingsTotal ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '\$ ${gpu.gpu[index].price.value}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  onPressed: () {
                                    widget.callback(gpu.gpu[index].id);
                                    Navigator.pop(context);
                                  },
                                  child: Text('Add to Wishlist',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFF0415f7))))
                            ],
                          ),
                        ),
                      ));
                }),
          );
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
