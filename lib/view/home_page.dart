import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/view/widget/custom_page_route.dart';
import 'package:mini_project_mandor_pc/view/wishlists_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: const Center(
          child: Text('Klik tombol + untuk pindah ke halaman wishlist'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/wishlists');
          },
          child: const Icon(Icons.add),
        ));
  }
}
