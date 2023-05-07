import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import '/view_model/case_provider.dart';

typedef DataCallback = void Function(int id);

class CaseListPage extends StatefulWidget {
  final DataCallback callback;
  const CaseListPage({super.key, required this.callback});

  @override
  State<CaseListPage> createState() => _CaseListPageState();
}

class _CaseListPageState extends State<CaseListPage> {
  @override
  void initState() {
    //
    super.initState();
    Future.microtask(
        () => Provider.of<CaseProvider>(context, listen: false).fetchCasing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<CaseProvider>(builder: (context, casing, child) {
      if (casing.state == RequestState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (casing.state == RequestState.loaded) {
        return SafeArea(
          child: ListView.builder(
              itemCount: casing.casing.length,
              itemBuilder: (context, index) {
                return Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        int id = casing.casing[index].id;

                        Navigator.pushNamed(context, '/casingDetail',
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
                                    casing.casing[index].title,
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Image.network(
                                    casing.casing[index].image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    'Rating : ${casing.casing[index].rating ?? 'No rating yet'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    'Total Rating : ${casing.casing[index].ratingsTotal ?? 'No rating yet'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    'USD ${casing.casing[index].price?.value}',
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
                                  widget.callback(casing.casing[index].id);
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
      } else if (casing.state == RequestState.error) {
        return Center(
          child: Text(casing.message),
        );
      } else {
        return const Center(
          child: Text('Silakan klik tombol add untuk memulai'),
        );
      }
    }));
  }
}
