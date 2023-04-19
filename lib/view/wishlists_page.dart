import 'package:flutter/material.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: ListView.builder(itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              title: Text('Title'),
              subtitle: Text('Subtitle'),
            ),
          );
        }));
  }
}
