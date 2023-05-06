import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/ram_provider.dart';

typedef DataCallback = void Function(int id);

class RamListPage extends StatefulWidget {
  final DataCallback callback;
  const RamListPage({super.key, required this.callback});

  @override
  State<RamListPage> createState() => _RamListPageState();
}

class _RamListPageState extends State<RamListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<RamProvider>(context, listen: false).fetchRam());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      body: Consumer<RamProvider>(builder: (context, ram, child) {
        if (ram.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (ram.state == RequestState.loaded) {
          return ListView.builder(
              itemCount: ram.ram.length,
              itemBuilder: (context, index) {
                return Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        int id = ram.ram[index].id;

                        Navigator.pushNamed(context, '/ramDetail',
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
                                  ram.ram[index].title,
                                  textAlign: TextAlign.justify,
                                ),
                                Image.network(ram.ram[index].image),
                                Text(
                                    'Rating : ${ram.ram[index].rating ?? 'No rating yet'}'),
                                Text(
                                    'Total Rating : ${ram.ram[index].ratingsTotal ?? 'No rating yet'}'),
                                Text('USD ${ram.ram[index].price.value}'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                widget.callback(ram.ram[index].id);
                                Navigator.pop(context);
                              },
                              child: const Text('Add to Cart'))
                        ],
                      ),
                    ));
              });
        } else if (ram.state == RequestState.error) {
          return Center(
            child: Text(ram.message),
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
