
import 'package:cloud_firestore/cloud_firestore.dart';

class TipsModel {

  String id;
  String titulo;
  String descripcion;
  String foto;
  Timestamp fecha;


  TipsModel({this.id, this.titulo, this.descripcion, this.foto, this.fecha});

  TipsModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        titulo = doc.data()['titulo'],
        descripcion = doc.data()['descripcion'],
        foto = doc.data()['foto'],
        fecha = doc.data()['fecha']

  ;

  TipsModel.fromJson(Map<String, dynamic> json)
      :
        titulo = json['titulo'],
        descripcion = json['descripcion'],
        foto = json['foto'],
        fecha = json['fecha']

  ;


  static List<TipsModel> toTipsList(QuerySnapshot query){
    return query.docs.map((doc) => TipsModel.fromFirestore(doc)).toList();
  }


}