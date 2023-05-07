import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        body: Consumer<CpuCoolerProvider>(builder: (context, cooler, child) {
      if (cooler.state == RequestState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (cooler.state == RequestState.loaded) {
        return SafeArea(
          child: ListView.builder(
              itemCount: cooler.cooler.length,
              itemBuilder: (context, index) {
                return Card(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        int id = cooler.cooler[index].id;
                        Navigator.pushNamed(context, '/coolerDetail',
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
                                    cooler.cooler[index].title,
                                    textAlign: TextAlign.justify,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Image.network(
                                    cooler.cooler[index].image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    'Rating : ${cooler.cooler[index].rating ?? 'No rating yet'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    'Total Rating : ${cooler.cooler[index].ratingsTotal ?? 'No rating yet'}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                  ),
                                  Text(
                                    '\$ ${cooler.cooler[index].price?.value}',
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
                                  widget.callback(cooler.cooler[index].id);
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
