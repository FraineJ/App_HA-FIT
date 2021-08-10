
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoriaModel {

  String id;
  String nombre;
  String descripcion;
  String foto;


  CategoriaModel({this.id, this.nombre, this.descripcion, this.foto,});

  CategoriaModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        nombre = doc.data()['nombre'],
        descripcion = doc.data()['descripcion'],
        foto = doc.data()['foto']

  ;

  CategoriaModel.fromJson(Map<String, dynamic> json)
      :
        nombre = json['nombre'],
        descripcion = json['descripcion'],
        foto = json['foto']

  ;


  static List<CategoriaModel> toCategoriasList(QuerySnapshot query){
    return query.docs.map((doc) => CategoriaModel.fromFirestore(doc)).toList();
  }


}