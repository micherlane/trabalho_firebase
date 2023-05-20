class ImcModel {
  late String id;
  late double altura;
  late double peso;
  late double imc;

  ImcModel(this.id, this.altura, this.peso, this.imc);

  ImcModel.fromMapObject(Map<dynamic, dynamic> map){
    id = map['id'];
    altura = map['altura'];
    peso = map['peso'];
    imc = map['imc'];
  }
}