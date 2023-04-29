import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../view_model/cpu_provider.dart';

typedef DataCallback = void Function(int id);

class CpuDetailPage extends StatefulWidget {
  final DataCallback? callback;

  const CpuDetailPage({super.key, this.callback});

  @override
  State<CpuDetailPage> createState() => _CpuDetailPageState();
}

class _CpuDetailPageState extends State<CpuDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<CpuProvider>(context, listen: false).fetchCpu());
  }

  @override
  Widget build(BuildContext context) {
    final cpuId = ModalRoute.of(context)!.settings.arguments as int;
    final cpu = Provider.of<CpuProvider>(context)
        .cpu
        .firstWhere((element) => element.id == cpuId);
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
            cpu.image,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          cpu.title,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text('Rating : ${cpu.rating}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text('Total Ratings : ${cpu.ratingsTotal}',
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 10,
        ),
        Text(
          'USD ${cpu.price.value}',
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
