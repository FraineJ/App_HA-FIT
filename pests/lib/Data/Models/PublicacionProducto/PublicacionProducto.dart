
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionProducto {

  String id;
  String nombre;
  String descripcion;
  String foto;
  String tipo_envio;
  int valor;

  PublicacionProducto({this.id, this.nombre, this.descripcion, this.foto, this.tipo_envio});

  PublicacionProducto.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        nombre = doc.data()['nombre'],
        descripcion = doc.data()['descripcion'],
        foto = doc.data()['foto'],
        tipo_envio =   doc.data()['tipo_envio'],
        valor = doc.data()['valor']
  ;

  PublicacionProducto.fromJson(Map<String, dynamic> json)
      :
        nombre = json['nombre'],
        descripcion = json['descripcion'],
        foto = json['foto'],
        tipo_envio = json['tipo_envio'],
        valor = json['valor']
  ;


  static List<PublicacionProducto> toPublicacionesList(QuerySnapshot query){
    return query.docs.map((doc) => PublicacionProducto.fromFirestore(doc)).toList();
  }


}