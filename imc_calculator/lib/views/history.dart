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
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text('Altura'),
                                Text(imcModel!.altura.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('Peso'),
                                Text(imcModel.peso.toString()),
                              ],
                            ),
                            Row(
                              children: [
                                const Text('IMC'),
                                Text(imcModel.imc.toString())
                              ],
                            )
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
