import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';

class ImcService{
  void salvarIMC(double altura, double peso, double imc) async {
    // Gerando id para o cálculo do imc
    const uuid = Uuid();

    // Criação de um documento exclusivo para cada imc
    DatabaseReference imcDatabaseReference =
        FirebaseDatabase.instance.ref('imc/${uuid.v4()}');

    // Salvando a informação no realtime database
    await imcDatabaseReference.set({
      "altura": altura,
      "peso": peso,
      "imc": imc,
    });
  }

  
  
}