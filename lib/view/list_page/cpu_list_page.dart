import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Consumer<CpuProvider>(builder: (context, cpu, child) {
        if (cpu.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (cpu.state == RequestState.loaded) {
          return SafeArea(
            child: ListView.builder(
                itemCount: cpu.cpu.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: () {
                          int id = cpu.cpu[index].id;

                          Navigator.of(context)
                              .pushNamed('/cpuDetail', arguments: id);
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
                                      cpu.cpu[index].title,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Image.network(
                                      cpu.cpu[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text('Rating : ${cpu.cpu[index].rating}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    Text(
                                        'Total Rating : ${cpu.cpu[index].ratingsTotal}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
                                    Text('USD ${cpu.cpu[index].price.value}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall),
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
                                    widget.callback(cpu.cpu[index].id);
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
