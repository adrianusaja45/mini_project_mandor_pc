import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/case_provider.dart';

typedef DataCallback = void Function(int id);

class CaseDetailPage extends StatefulWidget {
  final DataCallback? callback;

  const CaseDetailPage({super.key, this.callback});

  @override
  State<CaseDetailPage> createState() => _CaseDetailPageState();
}

class _CaseDetailPageState extends State<CaseDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<CaseProvider>(context, listen: false).fetchCasing());
  }

  @override
  Widget build(BuildContext context) {
    final casingId = ModalRoute.of(context)!.settings.arguments as int;
    final casing = Provider.of<CaseProvider>(context)
        .casing
        .firstWhere((element) => element.id == casingId);
    int currentIndex = 0;

    void onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });

      // perform your action here
      if (currentIndex == 0) {
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child: Image.network(
            casing.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          casing.title,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Rating : ${casing.rating}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text('Total Ratings : ${casing.ratingsTotal}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text(
          'USD ${casing.price?.value}',
          textAlign: TextAlign.start,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.add), label: 'Add to WishList'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
        ],
        currentIndex: currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
