import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;



class CartaOferta extends StatefulWidget {




  @override
  _CartaOfertaState createState() => _CartaOfertaState();
}

class _CartaOfertaState extends State<CartaOferta> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;


  final List<Widget> listaPublicaciones = [];
  Stream<List<M.PublicacionProducto>> obtenerOfertas()   {
    return _db.collection('publicaciones').where("oferta", isEqualTo: true).snapshots().map(M.PublicacionProducto.toPublicacionesList);

  }

  @override
  void initState() {
    // TODO: implement initState
    obtenerOfertas();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    NumberFormat numero = new NumberFormat("#,##0", "es_AR");


    return StreamBuilder(
        stream: obtenerOfertas(),
        builder: (context,
            AsyncSnapshot<List<M.PublicacionProducto>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            List<M.PublicacionProducto> Publicaciones = snapshot.data;

            return Publicaciones.length == 0 ? Container(): Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 3 / 4 - 40,
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 1 / 4 + 63,

                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    boxShadow: [
                      BoxShadow(
                        color: G.colorGris,
                        offset: new Offset(0.0, 0.0),

                        blurRadius: 54.0,
                      ),
                    ],
                    color: G.colorBlanco
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: const EdgeInsets.all(18.0),
                      child: Text("Ofertas",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontFamily: G.Bold
                        ),
                      ),
                    ),
                    Divider(height: 1,),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 2 / 4 - 35,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 1 / 4 - 63,

                          decoration: BoxDecoration(

                            image: DecorationImage(
                              image: NetworkImage(Publicaciones[0].foto),
                              fit: BoxFit.contain ,

                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(left: 10.0, top: 10.0),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 2 / 4,
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 1 / 4 - 63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Flexible(
                                  child: Text(Publicaciones[0].nombre,
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  )
                              ),
                              Text("\$" + numero.format(Publicaciones[0].valor),
                                style: TextStyle(
                                    fontSize: 25.0
                                ),
                              ),
                              Text("Envio gratis",
                                style: TextStyle(
                                    color: G.colorBoton,
                                    fontSize: 12.0
                                ),
                              )
                            ],
                          ),
                        ),


                      ],

                    ),
                    Divider(height: 1,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("Ver todas las ofertas",
                            style: TextStyle(
                                fontSize: 14.0,
                                fontFamily: G.Bold
                            ),
                          ),
                        ),

                        IconButton(icon: Icon(
                            Icons.arrow_forward_ios_rounded
                        ), onPressed: () {

                        }
                        )
                      ],
                    ),
                  ],
                ),

              ),
            );


          }
        });
    }
}
