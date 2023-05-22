import 'package:flutter/material.dart';

import '../controller/imc_controller.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final _imcController = ImcController();

  void _clearField() {
    setState(() {
      _imcController.controllerPeso.clear();
      _imcController.controllerAltura.clear();
    });
  }

  void _showMessage(double imc, String imcResultado) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(imcResultado),
        content: Text('IMC: ${imc.toStringAsFixed(2)}'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 'Ok');
              },
              child: const Text('Ok'))
        ],
      ),
    );
  }

  void calculate() {
    _imcController.calculate();
    _showMessage(_imcController.imc, _imcController.imcResultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 230, 231),
      appBar: AppBar(
        title: TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, 'history');
            },
            style: const ButtonStyle(
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
            icon: const Icon(Icons.history_sharp),
            label: const Text(
              'Histórico',
              style: TextStyle(color: Colors.white),
            )),
        elevation: 0,
        toolbarHeight: 80,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearField,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 30),
        //padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Calcule seu IMC',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              //Input 1
              Container(
                width: 300.0,
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Peso (Kg)'),
                  controller: _imcController.controllerPeso,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Input 2
              Container(
                width: 300.0,
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  decoration: const InputDecoration(labelText: 'Altura (cm)'),
                  controller: _imcController.controllerAltura,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // Buttom
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  //onPressed: _calculate,
                  onPressed: calculate,
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                      //fontSize: 25.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
