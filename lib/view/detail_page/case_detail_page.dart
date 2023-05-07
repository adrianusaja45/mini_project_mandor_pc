import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:url_launcher/url_launcher_string.dart';

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
    super.initState();
    Future.microtask(
        () => Provider.of<CaseProvider>(context, listen: false).fetchCasing());
  }

  void _launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
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
        _launchUrl(casing.link);
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
              casing.image,
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
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  height: 10,
                ),
                Text('Total Ratings : ${casing.ratingsTotal}',
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.displaySmall),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '\$ ${casing.price?.value}',
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
