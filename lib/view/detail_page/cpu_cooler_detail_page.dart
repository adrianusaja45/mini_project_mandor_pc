import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/cpu_cooler_provider.dart';

typedef DataCallback = void Function(int id);

class CoolerDetailPage extends StatefulWidget {
  final DataCallback? callback;

  const CoolerDetailPage({super.key, this.callback});

  @override
  State<CoolerDetailPage> createState() => _CoolerDetailPageState();
}

class _CoolerDetailPageState extends State<CoolerDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() =>
        Provider.of<CpuCoolerProvider>(context, listen: false).fetchCooler());
  }

  @override
  Widget build(BuildContext context) {
    final coolerId = ModalRoute.of(context)!.settings.arguments as int;
    final cooler = Provider.of<CpuCoolerProvider>(context)
        .cooler
        .firstWhere((element) => element.id == coolerId);
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
            cooler.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          cooler.title,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Rating : ${cooler.rating}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text('Total Ratings : ${cooler.ratingsTotal}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text(
          'USD ${cooler.price?.value}',
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
