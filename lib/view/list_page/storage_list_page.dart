import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/storage_provider.dart';

class StorageListPage extends StatefulWidget {
  const StorageListPage({super.key});

  @override
  State<StorageListPage> createState() => _StorageListPageState();
}

class _StorageListPageState extends State<StorageListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<StorageProvider>(context, listen: false).fetchStorage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      body: Consumer<StorageProvider>(builder: (context, storage, child) {
        if (storage.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (storage.state == RequestState.loaded) {
          return ListView.builder(
              itemCount: storage.storage.length,
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
                                  storage.storage[index].title,
                                  textAlign: TextAlign.justify,
                                ),
                                Image.network(storage.storage[index].image),
                                Text(
                                    'Rating : ${storage.storage[index].rating ?? 'No rating yet'}'),
                                Text(
                                    'Total Rating : ${storage.storage[index].ratingsTotal ?? 'No rating yet'}'),
                                Text(
                                    'USD ${storage.storage[index].price.value}'),
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
        } else if (storage.state == RequestState.error) {
          return Center(
            child: Text(storage.message),
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
