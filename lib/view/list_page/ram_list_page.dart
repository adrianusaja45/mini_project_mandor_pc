import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
      body: Consumer<RamProvider>(builder: (context, ram, child) {
        if (ram.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (ram.state == RequestState.loaded) {
          return SafeArea(
            child: ListView.builder(
                itemCount: ram.ram.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = ram.ram[index].id;

                          Navigator.pushNamed(context, '/ramDetail',
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
                                      ram.ram[index].title,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Image.network(
                                      ram.ram[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text(
                                      'Rating : ${ram.ram[index].rating ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Total Rating : ${ram.ram[index].ratingsTotal ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '\$ ${ram.ram[index].price.value}',
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
                                    widget.callback(ram.ram[index].id);
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
