import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/cpu_cooler_provider.dart';

typedef DataCallback = void Function(int id);

class CpuCoolerListPage extends StatefulWidget {
  final DataCallback callback;
  const CpuCoolerListPage({super.key, required this.callback});

  @override
  State<CpuCoolerListPage> createState() => _CpuCoolerListPageState();
}

class _CpuCoolerListPageState extends State<CpuCoolerListPage> {
  @override
  void initState() {
    //
    super.initState();
    Future.microtask(() =>
        Provider.of<CpuCoolerProvider>(context, listen: false).fetchCooler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: Consumer<CpuCoolerProvider>(builder: (context, cooler, child) {
          if (cooler.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (cooler.state == RequestState.loaded) {
            return ListView.builder(
                itemCount: cooler.cooler.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = cooler.cooler[index].id;
                          Navigator.pushNamed(context, '/coolerDetail',
                              arguments: id);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    cooler.cooler[index].title,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Image.network(cooler.cooler[index].image),
                                  Text(
                                      'Rating : ${cooler.cooler[index].rating ?? 'No rating yet'}'),
                                  Text(
                                      'Total Rating : ${cooler.cooler[index].ratingsTotal ?? 'No rating yet'}'),
                                  Text(
                                      'USD ${cooler.cooler[index].price?.value}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  widget.callback(cooler.cooler[index].id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Add to Cart'))
                          ],
                        ),
                      ));
                });
          } else if (cooler.state == RequestState.error) {
            return Center(
              child: Text(cooler.message),
            );
          } else {
            return const Center(
              child: Text('Silakan klik tombol add untuk memulai'),
            );
          }
        }));
  }
}
