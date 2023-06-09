import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher_string.dart';

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
    super.initState();
    Future.microtask(
        () => Provider.of<PsuProvider>(context, listen: false).fetchPsu());
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
        launchUrl(psu.link);
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
              psu.image,
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
              children: [
                Text(
                  psu.title,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Rating : ${psu.rating}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Total Ratings : ${psu.ratingsTotal}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${psu.price.value}',
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
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
              icon: Icon(Icons.add), label: 'Go to Amazon Page'),
          BottomNavigationBarItem(icon: Icon(Icons.arrow_back), label: 'Back'),
        ],
        currentIndex: currentIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
