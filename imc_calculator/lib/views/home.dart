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

  void _showMessage(double imc, String imcResultado){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Resultado => ${imc.toStringAsFixed(2)}'),
        content: Center(
          child: Text(imcResultado),
        ),
      ),
    );
  }

  void calculate(){
    _imcController.calculate();
    _showMessage(_imcController.imc, _imcController.imcResultado);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 230, 231),
      appBar: AppBar(
        title: const Text('IMC Calculator'),
        backgroundColor: const Color.fromARGB(255, 19, 159, 201),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _clearField,
          ),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'history');
          }, icon: const Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(
        //padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  scale: 1000.0,
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-Z2YCMPrOwqdLwJ0aSRcuUG_pNollSjK6Pw&usqp=CAU',
                ),
              ),

              //Input 1
              Container(
                width: 300.0,
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _imcController.controllerPeso,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    //label: Text('teste: '),
                    labelText: 'Peso (Kg): ',
                    labelStyle: TextStyle(
                      color: Colors.green,
                      //fontSize: 25.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),

              // Input 2
              Container(
                width: 300.0,
                margin: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _imcController.controllerAltura,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    //label: Text('teste: '),
                    labelText: 'Altura (Cm): ',
                    labelStyle: TextStyle(
                      color: Colors.green,
                      //fontSize: 25.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              // Buttom
              SizedBox(
                width: 300.0,
                height: 50.0,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(Colors.green),
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 15,
                      ),
                    ),
                  ),
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
