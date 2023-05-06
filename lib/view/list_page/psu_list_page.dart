import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: Consumer<PsuProvider>(builder: (context, psu, child) {
          if (psu.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (psu.state == RequestState.loaded) {
            return ListView.builder(
                itemCount: psu.psu.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = psu.psu[index].id;

                          widget.callback(psu.psu[index].id);

                          Navigator.pushNamed(context, '/psuDetail',
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
                                    psu.psu[index].title,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Image.network(psu.psu[index].image),
                                  Text(
                                      'Rating : ${psu.psu[index].rating ?? 'No rating yet'}'),
                                  Text(
                                      'Total Rating : ${psu.psu[index].ratingsTotal ?? 'No rating yet'}'),
                                  Text('USD ${psu.psu[index].price.value}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  widget.callback(psu.psu[index].id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Add to Cart'))
                          ],
                        ),
                      ));
                });
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
