import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/psu_provider.dart';

typedef DataCallback = void Function(int id);

class PsuDetailPage extends StatefulWidget {
  final DataCallback? callback;

  const PsuDetailPage({super.key, this.callback});

  @override
  State<PsuDetailPage> createState() => _PsuDetailPageState();
}

class _PsuDetailPageState extends State<PsuDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<PsuProvider>(context, listen: false).fetchPsu());
  }

  @override
  Widget build(BuildContext context) {
    final psuId = ModalRoute.of(context)!.settings.arguments as int;
    final psu = Provider.of<PsuProvider>(context)
        .psu
        .firstWhere((element) => element.id == psuId);
    int currentIndex = 0;

    void onItemTapped(int index) {
      setState(() {
        currentIndex = index;
      });

      // perform your action here
      if (currentIndex == 0) {
        widget.callback?.call(psu.id);
        Navigator.pop(context);
        Navigator.pop(context);
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
            psu.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          psu.title,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Rating : ${psu.rating}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text('Total Ratings : ${psu.ratingsTotal}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text(
          'USD ${psu.price.value}',
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
