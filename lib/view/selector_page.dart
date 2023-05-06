import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/build_model.dart';
import '../view_model/build_provider.dart';
import '../view_model/selector_provider.dart';

class SelectorPage extends StatefulWidget {
  const SelectorPage({super.key});

  @override
  State<SelectorPage> createState() => _SelectorPageState();
}

class _SelectorPageState extends State<SelectorPage> {
  final titleController = TextEditingController();

  Future<void> submit() async {
    var vm = Provider.of<SelectorVM>(context, listen: false);

    var title = titleController.text.trim();
    SavedBuild savedBuild = SavedBuild(titleBuild: title, buildItems: [
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[0].id,
        title: vm.getSortedProducts(vm.currentBudget)[0].title,
        image: vm.getSortedProducts(vm.currentBudget)[0].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[0].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[0].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[0]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[0].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[1].id,
        title: vm.getSortedProducts(vm.currentBudget)[1].title,
        image: vm.getSortedProducts(vm.currentBudget)[1].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[1].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[1].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[1]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[1].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[2].id,
        title: vm.getSortedProducts(vm.currentBudget)[2].title,
        image: vm.getSortedProducts(vm.currentBudget)[2].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[2].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[2].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[2]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[2].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[3].id,
        title: vm.getSortedProducts(vm.currentBudget)[3].title,
        image: vm.getSortedProducts(vm.currentBudget)[3].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[3].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[3].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[3]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[3].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[4].id,
        title: vm.getSortedProducts(vm.currentBudget)[4].title,
        image: vm.getSortedProducts(vm.currentBudget)[4].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[4].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[4].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[4]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[4].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[5].id,
        title: vm.getSortedProducts(vm.currentBudget)[5].title,
        image: vm.getSortedProducts(vm.currentBudget)[5].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[5].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[5].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[5]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[5].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[6].id,
        title: vm.getSortedProducts(vm.currentBudget)[6].title,
        image: vm.getSortedProducts(vm.currentBudget)[6].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[6].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[6].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[6]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[6].price.raw.toString(),
        ),
      ),
      BuildItem(
        idPart: vm.getSortedProducts(vm.currentBudget)[7].id,
        title: vm.getSortedProducts(vm.currentBudget)[7].title,
        image: vm.getSortedProducts(vm.currentBudget)[7].image,
        price: Price(
          symbol:
              vm.getSortedProducts(vm.currentBudget)[7].price.symbol.toString(),
          value: vm.getSortedProducts(vm.currentBudget)[7].price.value,
          currency: vm
              .getSortedProducts(vm.currentBudget)[7]
              .price
              .currency
              .toString(),
          raw: vm.getSortedProducts(vm.currentBudget)[7].price.raw.toString(),
        ),
      ),
    ]);

    var buildProvider = Provider.of<BuildProvider>(context, listen: false);

    await buildProvider.postBuild(savedBuild);

    if (context.mounted) {
      if (buildProvider.isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Build saved successfully!")));
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error saving build!")));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchCpu());
    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchGpu());
    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchRam());

    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchMobo());

    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchCase());

    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchPsu());

    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchStorage());

    Future.microtask(
        () => Provider.of<SelectorVM>(context, listen: false).fetchCpuCooler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(children: [
          Consumer<SelectorVM>(
            builder: (context, vm, child) {
              return Row(
                children: [
                  const Text('Budget: '),
                  Text(vm.currentBudget.toStringAsFixed(2)),
                  Slider(
                    value: vm.currentBudget,
                    min: 0,
                    max: 5000.0,
                    divisions: 100,
                    label: vm.currentBudget.round().toStringAsFixed(2),
                    onChanged: (double value) {
                      vm.onSliderBudgetValueChange(value);
                    },
                  ),
                ],
              );
            },
          ),
          Expanded(
            child: Consumer<SelectorVM>(
              builder: (context, vm, _) {
                return Column(
                  children: [
                    Container(
                      height: 611,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount:
                            vm.getSortedProducts(vm.currentBudget).length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: Border.all(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid),
                            child: ListTile(
                              leading: Image.network(
                                vm
                                    .getSortedProducts(vm.currentBudget)[index]
                                    .image,
                                width: 50,
                                height: 50,
                              ),
                              title: Text(
                                vm
                                    .getSortedProducts(vm.currentBudget)[index]
                                    .title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                              subtitle: Text(vm
                                  .getSortedProducts(vm.currentBudget)[index]
                                  .price
                                  .value
                                  .toString()),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: ElevatedButton(
                          onPressed: () {
                            //post data build provider and pop
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                backgroundColor:
                                    const Color.fromARGB(255, 8, 44, 73),
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Container(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20.0, 20.0, 20.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(16),
                                              child: TextFormField(
                                                controller: titleController,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'Title',
                                                  hintStyle: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 88, 85, 85)),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  submit();
                                                },
                                                child: const Text('Submit'))
                                          ],
                                        ))));
                          },
                          child: const Text('Submit')),
                    )
                  ],
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
