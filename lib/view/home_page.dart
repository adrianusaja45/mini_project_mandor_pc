import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:mini_project_mandor_pc/view_model/build_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<BuildProvider>(context, listen: false).fetchBuild());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: Consumer<BuildProvider>(
          builder: (context, value, child) {
            if (value.builds.isEmpty) {
              return const Center(
                child: Text('Klik tombol + untuk pindah ke halaman wishlist'),
              );
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: value.builds.length,
                itemBuilder: (context, index) {
                  final build = value.builds[index];
                  return Card(
                    color: Colors.blue,
                    child: ExpansionTile(
                      title: Text(
                        build.titleBuild.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              value.deleteBuild(build.id!, index);
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/wishlists',
                                  arguments: build.id);
                              debugPrint('id build: ${build.id}');
                            },
                            icon: const Icon(Icons.edit),
                          ),
                        ],
                      ),
                      children: [
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: build.buildItems!.length,
                              itemBuilder: (context, index) {
                                final item = build.buildItems![index];
                                return ListTile(
                                  title: Text(
                                    item.title.toString(),
                                    maxLines: 3,
                                    softWrap: true,
                                  ),
                                  subtitle: Text(item.price!.value.toString()),
                                );
                              }),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,
          spacing: 10,
          spaceBetweenChildren: 10,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.build),
              label: 'Manual Build',
              onTap: () {
                Navigator.pushNamed(context, '/wishlists');
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.auto_mode),
              label: 'Auto Build',
              onTap: () {
                Navigator.pushNamed(context, '/selectorPage');
              },
            ),
          ],
        ));
  }
}
