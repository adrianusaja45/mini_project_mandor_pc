import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/view_model/storage_provider.dart';

typedef DataCallback = void Function(int id);

class StorageListPage extends StatefulWidget {
  final DataCallback callback;
  const StorageListPage({super.key, required this.callback});

  @override
  State<StorageListPage> createState() => _StorageListPageState();
}

class _StorageListPageState extends State<StorageListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<StorageProvider>(context, listen: false).fetchStorage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<StorageProvider>(builder: (context, storage, child) {
        if (storage.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (storage.state == RequestState.loaded) {
          return SafeArea(
            child: ListView.builder(
                itemCount: storage.storage.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = storage.storage[index].id;

                          Navigator.pushNamed(context, '/storageDetail',
                              arguments: id);
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
                                      storage.storage[index].title,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Image.network(
                                      storage.storage[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text(
                                      'Rating : ${storage.storage[index].rating ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Total Rating : ${storage.storage[index].ratingsTotal ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '\$ ${storage.storage[index].price.value}',
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
                                    widget.callback(storage.storage[index].id);
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
