
import 'package:cloud_firestore/cloud_firestore.dart';

class RazaModel {

  String id;
  String nombre;
  String tipo;

  RazaModel({this.id, this.nombre, this.tipo,});

  RazaModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        nombre = doc.data()['nombre'],
        tipo = doc.data()['tipo']

  ;

  RazaModel.fromJson(Map<String, dynamic> json)
      :
        nombre = json['nombre'],
        tipo = json['tipo']

  ;


  static List<RazaModel> toRazaList(QuerySnapshot query){
    return query.docs.map((doc) => RazaModel.fromFirestore(doc)).toList();
  }


}