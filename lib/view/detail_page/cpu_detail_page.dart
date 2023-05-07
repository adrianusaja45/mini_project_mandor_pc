import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../view_model/cpu_provider.dart';

class CpuDetailPage extends StatefulWidget {
  const CpuDetailPage({
    super.key,
  });

  @override
  State<CpuDetailPage> createState() => _CpuDetailPageState();
}

class _CpuDetailPageState extends State<CpuDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<CpuProvider>(context, listen: false).fetchCpu());
  }

  void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
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
        launchUrl(cpu.link);
      } else {
        Navigator.pop(context);
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(16),
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
          Container(
            height: 338,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    const Color(0xFF6887ea),
                  ],
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cpu.title,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Rating : ${cpu.rating}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Ratings : ${cpu.ratingsTotal}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text('\$ ${cpu.price.value}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Go to Amazon Page',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
        ],
        currentIndex: currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
