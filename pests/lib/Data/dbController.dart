import 'dart:convert';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pests/Data/Models/All.dart' as M;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


FirebaseFirestore db = FirebaseFirestore.instance;
FirebaseAuth user = FirebaseAuth.instance;

List<dynamic> ListaDatos = [];
Stream<List<M.RazaModel>> BuscarZara( )  {

  try{

    return db.collection('raza').snapshots().map(M.RazaModel.toRazaList);


  }catch(e){

    print("error ${  e }");

  }

}


//funcion de Guardar mascotas

Future guardarMacota(M.MascotaModel mascotaModel) async {
  CollectionReference ref = db.collection("mascota");

  try {
    return await ref.add({

      "nombre": mascotaModel.nombre,
      "foto": mascotaModel.foto,
      "raza": mascotaModel.raza,
      "fechaNacimienta": mascotaModel.fechaNacimienta,
      "genero": mascotaModel.genero,
      "especie": mascotaModel.especie,
      "id_usuario": mascotaModel.id_usuario
    });
  }catch(e){

    print(e);

  }
}


//Funcion listar mascotas


Stream<List<M.MascotaModel>> listarMascotas(){

  return db.collection("mascota").where("id_usuario", isEqualTo: user.currentUser.uid ).snapshots().map(M.MascotaModel.toMascotaList);

}

//Eliminar Mascotas

Future<void>Elimar(String coleccion, String id) async{

  try{
    await  db.collection(coleccion).doc(id).delete();

  }catch(e){
    return e;
  }

}


//funncion de subir imagenes



Future<firebase_storage.UploadTask> uploadFileImage(File image) async{
  DateTime fecha =  DateTime.now();
  String path = user.currentUser.uid + "/masctas/" + fecha.toString() + ".jgp";
  final firebase_storage.Reference  _refe = firebase_storage.FirebaseStorage.instance.ref();

  final firebase_storage.UploadTask uploadTask = _refe.child(path).putFile(image);
  return uploadTask;
}



 BuscarSubCategorias( String id )  async{

  try{

    return await db.collection('categoria').doc(id).collection("sub_categoria").get();


  }catch(e){

    print("error ${  e }");

  }

}



