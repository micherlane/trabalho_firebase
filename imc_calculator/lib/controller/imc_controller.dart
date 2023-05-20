import 'dart:math';

import 'package:flutter/material.dart';
import '../services/imc_service.dart';

class ImcController {
  final _imcService = ImcService();
  final TextEditingController controllerPeso = TextEditingController();
  final TextEditingController controllerAltura = TextEditingController();

  String imcResultado = '';
  double imc = 0;
  double finalResult = 0;


  String _showResult(double imc) {
    if (imc < 18.6) {
      return 'Abaixo do peso';
    } else if (imc > 18.7 && imc < 24.9) {
      return 'Peso ideal';
    } else if (imc > 25 && imc < 29.9) {
      return 'Levemente acima do peso';
    } else if (imc > 30 && imc < 34.9) {
      return 'Obesidade grau I';
    } else if (imc > 35 && imc < 39.9) {
      return 'Obesidade grau II';
    } else {
      return 'Obesidade grau III';
    }
  }

  // calcula o imc e salva no banco de dados
  void calculate() {
    var peso = double.parse(controllerPeso.text);
    var altura = double.parse(controllerAltura.text) * 0.01;

    imc = peso / pow(altura, 2);
    imcResultado = _showResult(imc);
    
    _imcService.salvarIMC(altura, peso, imc);
  }

  // Busca todos os imc registrados
  Future<List<dynamic>> getImcs() async{
    return await _imcService.getImcs();
  }
}
