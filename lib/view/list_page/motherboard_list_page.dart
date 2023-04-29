import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/view/detail_page/case_detail_page.dart';
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
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<MoboProvider>(context, listen: false).fetchMobo());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MandorPC'),
      ),
      body: Consumer<MoboProvider>(builder: (context, mobo, child) {
        if (mobo.state == RequestState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (mobo.state == RequestState.loaded) {
          return ListView.builder(
              itemCount: mobo.mobo.length,
              itemBuilder: (context, index) {
                return Card(
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: InkWell(
                      onTap: () {
                        int id = mobo.mobo[index].id;

                        Navigator.pushNamed(context, '/moboDetail',
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
                                  mobo.mobo[index].title,
                                  textAlign: TextAlign.justify,
                                ),
                                Image.network(mobo.mobo[index].image),
                                Text(
                                    'Rating : ${mobo.mobo[index].rating ?? 'No rating yet'}'),
                                Text(
                                    'Total Rating : ${mobo.mobo[index].ratingsTotal ?? 'No rating yet'}'),
                                Text('USD ${mobo.mobo[index].price?.value}'),
                              ],
                            ),
                          ),
                          ElevatedButton(
                              onPressed: () {
                                widget.callback(mobo.mobo[index].id);
                                Navigator.pop(context);
                              },
                              child: const Text('Add to Cart'))
                        ],
                      ),
                    ));
              });
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
