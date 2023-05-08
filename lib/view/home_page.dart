import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:mini_project_mandor_pc/view/login_page.dart';

import 'package:mini_project_mandor_pc/view_model/build_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  String name = '';
  @override
  void initState() {
    super.initState();
    initial();
    Future.microtask(
        () => Provider.of<BuildProvider>(context, listen: false).fetchBuild());
  }

  void initial() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<BuildProvider>(
          builder: (context, value, child) {
            if (value.builds.isEmpty) {
              return Stack(children: [
                const Center(
                  child: Text('Klik tombol + untuk pindah ke halaman wishlist'),
                ),
                Positioned(
                    top: 50,
                    left: 10,
                    child: Text(
                      'Halo, $name',
                      style: Theme.of(context).textTheme.displayLarge,
                    )),

                // Profile action button
                Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-vector/cute-cat-gaming-cartoon_138676-2969.jpg?w=740&t=st=1683436262~exp=1683436862~hmac=105150fe1257da5380b3800c3b31df4363289939416229bf2d0dc73c86670260'),
                      ),
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.logout),
                                      title: const Text('Logout'),
                                      onTap: () {
                                        prefs.remove('name');
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ),
                                            (route) => false);
                                      },
                                    ),
                                  ],
                                ),
                              )),
                    ))
              ]);
            } else {
              return Stack(children: [
                Container(
                  padding: const EdgeInsets.only(top: 45),
                  height: 800,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: value.builds.length,
                    itemBuilder: (context, index) {
                      final build = value.builds[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Theme.of(context).colorScheme.primary),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin:
                            const EdgeInsets.only(top: 16, left: 16, right: 16),
                        color: const Color(0xFFf5f8fa),
                        child: ExpansionTile(
                          title: Text(
                            build.titleBuild.toString(),
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  value.deleteBuild(build.id!, index);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/wishlists',
                                      arguments: build.id);
                                  debugPrint('id build: ${build.id}');
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ],
                          ),
                          children: [
                            SizedBox(
                              height: 175,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: build.buildItems!.length,
                                itemBuilder: (context, index) {
                                  final item = build.buildItems![index];
                                  return Card(
                                    margin: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              const Color(0xFF6887ea),
                                            ],
                                          )),
                                      constraints: const BoxConstraints(
                                          minHeight: 0,
                                          maxHeight: 200,
                                          minWidth: 0,
                                          maxWidth: 200),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            item.title.toString(),
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            textAlign: TextAlign.justify,
                                          ),
                                          Image.network(
                                            item.image!,
                                            height: 100,
                                            width: 100,
                                          ),
                                          Text(
                                            '\$ ${item.price!.value}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),

                Positioned(
                    top: 50,
                    left: 10,
                    child: Text(
                      'Halo, $name',
                      style: Theme.of(context).textTheme.displayLarge,
                    )),

                // Profile action button
                Positioned(
                    top: 40,
                    right: 10,
                    child: IconButton(
                      icon: const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-vector/cute-cat-gaming-cartoon_138676-2969.jpg?w=740&t=st=1683436262~exp=1683436862~hmac=105150fe1257da5380b3800c3b31df4363289939416229bf2d0dc73c86670260'),
                      ),
                      onPressed: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                                height: 200,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.logout),
                                      title: const Text('Logout'),
                                      onTap: () {
                                        prefs.remove('name');
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ),
                                            (route) => false);
                                      },
                                    ),
                                  ],
                                ),
                              )),
                    ))
              ]);
            }
          },
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: const IconThemeData(color: Colors.white),
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
