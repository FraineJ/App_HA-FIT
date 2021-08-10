import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pests/UI/All.dart' as C;


class CargarPublicaciones  with ChangeNotifier {

  final List<Widget> listaPublicaciones = [];
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future obtenerProductos()  async {
    QuerySnapshot snapshot = await _db.collection('publicaciones').get();

    for (int i = 0; i < snapshot.docs.length; i++) {
     // listaPublicaciones.add(C.CartaProducto());
      notifyListeners();
    }
    return listaPublicaciones;



  }

  get lista {
    return listaPublicaciones;
  }

}


