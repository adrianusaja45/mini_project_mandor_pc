import 'package:flutter/material.dart';
import 'package:mini_project_mandor_pc/view/detail_page/case_detail_page.dart';
import 'package:mini_project_mandor_pc/view/widget/animation_page_route.dart';
import 'package:provider/provider.dart';
import '/view_model/case_provider.dart';

typedef DataCallback = void Function(int id);

class CaseListPage extends StatefulWidget {
  final DataCallback callback;
  const CaseListPage({super.key, required this.callback});

  @override
  State<CaseListPage> createState() => _CaseListPageState();
}

class _CaseListPageState extends State<CaseListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(
        () => Provider.of<CaseProvider>(context, listen: false).fetchCasing());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MandorPC'),
        ),
        body: Consumer<CaseProvider>(builder: (context, casing, child) {
          if (casing.state == RequestState.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (casing.state == RequestState.loaded) {
            return ListView.builder(
                itemCount: casing.casing.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: InkWell(
                        onTap: () {
                          int id = casing.casing[index].id;

                          Navigator.pushNamed(context, '/casingDetail',
                              arguments: id);
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text(
                                    casing.casing[index].title,
                                    textAlign: TextAlign.justify,
                                  ),
                                  Image.network(casing.casing[index].image),
                                  Text(
                                      'Rating : ${casing.casing[index].rating ?? 'No rating yet'}'),
                                  Text(
                                      'Total Rating : ${casing.casing[index].ratingsTotal ?? 'No rating yet'}'),
                                  Text(
                                      'USD ${casing.casing[index].price?.value}'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  widget.callback(casing.casing[index].id);
                                  Navigator.pop(context);
                                },
                                child: const Text('Add to Cart'))
                          ],
                        ),
                      ));
                });
          } else if (casing.state == RequestState.error) {
            return Center(
              child: Text(casing.message),
            );
          } else {
            return const Center(
              child: Text('Silakan klik tombol add untuk memulai'),
            );
          }
        }));
  }
}
