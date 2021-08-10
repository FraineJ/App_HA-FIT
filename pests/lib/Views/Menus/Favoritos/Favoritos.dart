import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class Favoritos extends StatefulWidget {
  @override
  _FavoritosState createState() => _FavoritosState();
}

class _FavoritosState extends State<Favoritos> {


  final FirebaseFirestore _db = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;



  Stream<List<M.PublicacionProducto>> obtenerFavoritos()   {
    return _db.collection('favorito').where("id_usuario", isEqualTo: user.currentUser.uid).snapshots().map(M.PublicacionProducto.toPublicacionesList);

  }

  @override
  void initState() {
    // TODO: implement initState
    obtenerFavoritos();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: StreamBuilder(
          stream: obtenerFavoritos(),
          builder: (context, AsyncSnapshot<List<M.PublicacionProducto>> snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: C.SkeletonCircular(),
              );
            }else{

              List<M.PublicacionProducto> Producto = snapshot.data;

              return Producto.length == 0 ?  Container(
                width: double.infinity,
                height: G.alto,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(child: C.SinDatos(texto: "Aun no tienes favoritos", Icono: Icons.favorite,)),
                    ],
                  ),
              ) :
              ListView.builder(

                  itemCount: Producto.length,
                  itemBuilder: (context, index){
                    final M.PublicacionProducto producto = Producto[index];
                    return C.CartaFavoritos(producto: producto);
                  },
                );

              }

          }

      ),
    );
  }
}
