import 'package:flutter/material.dart';
import 'package:imc_calculator/controller/imc_controller.dart';
import 'package:imc_calculator/model/imc_model.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final _imcController = ImcController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico'),
      ),
      body: FutureBuilder(
        future: _imcController.getImcs(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            final error = snapshot.error;
            return Center(child: Text(':(${snapshot.data} $error'));
          } else if (snapshot.hasData) {
            return snapshot.data != null && snapshot.data!.isNotEmpty
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      ImcModel? imcModel = snapshot.data![index];
                      return Card(
                        margin: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'IMC: ${imcModel!.imc.toStringAsPrecision(3)}',
                                          style: const TextStyle(fontSize: 20)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                          'Altura: ${imcModel.altura.toStringAsPrecision(3)}',
                                          style: const TextStyle(fontSize: 15))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('Peso: ${imcModel.peso.toString()}',
                                          style: const TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text('data: ${imcModel.createdAt} ')
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Text('Sem histórico'),
                  );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
