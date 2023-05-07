import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '/view_model/psu_provider.dart';

typedef DataCallback = void Function(int id);

class PsuListPage extends StatefulWidget {
  final DataCallback callback;
  const PsuListPage({super.key, required this.callback});

  @override
  State<PsuListPage> createState() => _PsuListPageState();
}

class _PsuListPageState extends State<PsuListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<PsuProvider>(context, listen: false).fetchPsu());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: Scaffold(
        body: Consumer<PsuProvider>(builder: (context, psu, child) {
          if (psu.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (psu.state == RequestState.loaded) {
            return SafeArea(
              child: ListView.builder(
                  itemCount: psu.psu.length,
                  itemBuilder: (context, index) {
                    return Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: InkWell(
                          onTap: () {
                            int id = psu.psu[index].id;

                            widget.callback(psu.psu[index].id);

                            Navigator.pushNamed(context, '/psuDetail',
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
                                        psu.psu[index].title,
                                        textAlign: TextAlign.justify,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Image.network(
                                        psu.psu[index].image,
                                        height: 100,
                                        width: 100,
                                      ),
                                      Text(
                                        'Rating : ${psu.psu[index].rating ?? 'No rating yet'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        'Total Rating : ${psu.psu[index].ratingsTotal ?? 'No rating yet'}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall,
                                      ),
                                      Text(
                                        '\$ ${psu.psu[index].price.value}',
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                    onPressed: () {
                                      widget.callback(psu.psu[index].id);
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
          } else if (psu.state == RequestState.error) {
            return Center(
              child: Text(psu.message),
            );
          } else {
            return const Center(
              child: Text('No data'),
            );
          }
        }),
      ),
    );
  }
}
