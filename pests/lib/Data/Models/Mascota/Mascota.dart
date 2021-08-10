
import 'package:cloud_firestore/cloud_firestore.dart';

class MascotaModel {

  String id;
  String nombre;
  String foto;
  String raza;
  DateTime fechaNacimienta;
  Timestamp fecha;
  String genero;
  String especie;
  String id_usuario;

  MascotaModel({this.id, this.nombre, this.foto, this.raza, this.fechaNacimienta, this.genero, this.especie, this.id_usuario});

  MascotaModel.fromFirestore(DocumentSnapshot doc)
      : id = doc.id,
        nombre = doc.data()['nombre'],
        foto = doc.data()['foto'],
        raza = doc.data()['raza'],
        fecha = doc.data()['fechaNacimienta'],
        genero = doc.data()['genero'],
        especie = doc.data()['especie'],
        id_usuario = doc.data()['id_usuario']

  ;

  MascotaModel.fromJson(Map<String, dynamic> json)
      :
        id = json['id'],
        nombre = json['nombre'],
        foto = json['foto'],
        raza = json['raza'],
        fechaNacimienta = json['fechaNacimienta'],
        genero = json['genero'],
        especie = json['especie'],
        id_usuario = json['id_usuario']

  ;


  static List<MascotaModel> toMascotaList(QuerySnapshot query){
    return query.docs.map((doc) => MascotaModel.fromFirestore(doc)).toList();
  }


}