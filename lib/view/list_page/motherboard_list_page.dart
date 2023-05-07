import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '/view_model/motherboard_provider.dart';

typedef DataCallback = void Function(int id);

class MoboListPage extends StatefulWidget {
  final DataCallback callback;
  const MoboListPage({super.key, required this.callback});

  @override
  State<MoboListPage> createState() => _MoboListPageState();
}

class _MoboListPageState extends State<MoboListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<MoboProvider>(context, listen: false).fetchMobo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MoboProvider>(builder: (context, mobo, child) {
        if (mobo.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (mobo.state == RequestState.loaded) {
          return SafeArea(
            child: ListView.builder(
                itemCount: mobo.mobo.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = mobo.mobo[index].id;

                          Navigator.pushNamed(context, '/moboDetail',
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
                                      mobo.mobo[index].title,
                                      textAlign: TextAlign.justify,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Image.network(
                                      mobo.mobo[index].image,
                                      height: 100,
                                      width: 100,
                                    ),
                                    Text(
                                      'Rating : ${mobo.mobo[index].rating ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      'Total Rating : ${mobo.mobo[index].ratingsTotal ?? 'No rating yet'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
                                    ),
                                    Text(
                                      '\$ ${mobo.mobo[index].price?.value}',
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
                                    widget.callback(mobo.mobo[index].id);
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
        } else if (mobo.state == RequestState.error) {
          return Center(
            child: Text(mobo.message),
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
