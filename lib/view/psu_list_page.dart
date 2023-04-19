import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/view_model/psu_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<PsuProvider>(context, listen: false).fetchPsu());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onTap: () {},
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
                                Text('USD ${psu.psu[index].price?.value}'),
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
        } else if (psu.state == RequestState.error) {
          return Center(
            child: Text(psu.message),
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
