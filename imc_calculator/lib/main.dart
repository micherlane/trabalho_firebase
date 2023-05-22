import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imc_calculator/views/history.dart';
import 'package:imc_calculator/views/home.dart';
import 'firebase_options.dart';

void main() async {
  // Garante que o SDK do Flutter será inicializado;
  WidgetsFlutterBinding.ensureInitialized();

  // Incializando o firebase com a configuração da plataforma atual;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHome(),
      routes: {"history": (context) => const History()},
    ),
  );
}
