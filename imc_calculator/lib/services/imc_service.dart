import 'package:imc_calculator/model/imc_model.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_database/firebase_database.dart';

class ImcService {
  final FirebaseDatabase _imcDatabase = FirebaseDatabase.instance;

  // Traz a referência da coleção do banco de dados
  DatabaseReference _getDatabaseReference(String colection) {
    return _imcDatabase.ref(colection);
  }

  // tranforma o objeto no modelo de dados
  List<dynamic> _mapForImcModel(Map objeto) {
    return objeto['imc'].entries.map((entry) {

            String id = entry.key;
            num altura = entry.value['altura'];
            num peso = entry.value['peso'];
            num imc = entry.value['imc'];

            return ImcModel(id, altura, peso, imc);
    }).toList();
  }

  void salvarIMC(num altura, num peso, num imc) async {
    // Gerando id para o cálculo do imc
    const uuid = Uuid();
    // Criação de um documento exclusivo para cada imc
    DatabaseReference imcDatabaseReference =
        _getDatabaseReference('imc/${uuid.v4()}');

    // Salvando a informação no realtime database
    await imcDatabaseReference.set({
      "altura": altura,
      "peso": peso,
      "imc": imc,
    });
  }

  Future<List<dynamic>> getImcs() async {
    // Buscando a referência
    final DatabaseReference imcDatabaseReference = _getDatabaseReference('');

    final snapshotImcs = await imcDatabaseReference.get();

    if (snapshotImcs.exists) {
      Map objeto = snapshotImcs.value as Map;
      // Tranforma o map em uma lista do modelo do imc
      List<dynamic> imcList = _mapForImcModel(objeto);
      return imcList;
    } else {
      return [];
    }
  }
}
