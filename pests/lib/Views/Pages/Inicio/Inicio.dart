import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/foundation.dart';
import 'package:pests/Data/Providers/All.dart';
import 'package:pests/UI/Base/SliderNav.dart';



import 'package:pests/UI/Cartas/HomeCarusel.dart';


import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Views/Pages/Tips/HomeTips.dart';
import 'package:provider/provider.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> with AutomaticKeepAliveClientMixin {

  final rnd = new Random();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final List<Color> colores = [

    Colors.white,

  ];

  int navIndex = 0;

  final List<Widget> listaPublicaciones = [];
  Stream<List<M.PublicacionProducto>> obtenerProductos()   {
    return _db.collection('publicaciones').snapshots().map(M.PublicacionProducto.toPublicacionesList);

  }

  Stream<List<M.CategoriaModel>> obtenerCategoria()   {
    return _db.collection('categoria').snapshots().map(M.CategoriaModel.toCategoriasList);

  }



  @override
  void initState() {
    // TODO: implement initState
    obtenerProductos();
    obtenerCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    super.build(context);


    return Scaffold(
        body: Column(

            children: [

              Expanded(
                child: CustomScrollView(

                  slivers: [

                    SliverAppBar(
                      backgroundColor: G.colorBlanco,
                      expandedHeight:   MediaQuery.of(context).size.height * 1/4 - 20,
                      flexibleSpace: HomeCarusel() ,
                      floating: false,
                    ),

                    SliverPadding(padding: EdgeInsets.only(top: 10,  left: 15),
                        sliver: SliverList(

                            delegate: SliverChildListDelegate(
                                [
                                  Text( 'Categorias',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: G.Bold
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ]
                            )
                        )
                    ),

                    SliverPadding(
                      padding: EdgeInsets.zero,
                      sliver: SliverList(

                          delegate: SliverChildListDelegate(
                          [

                            Container(
                              height: 120.0,
                              child: StreamBuilder(
                                  stream: obtenerCategoria(),
                                  builder: (context, AsyncSnapshot<List<M.CategoriaModel>> snapshot){

                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return Center(
                                        child: C.SkeletonCircular(),
                                      );
                                    }else{

                                      List<M.CategoriaModel> Categoria = snapshot.data;


                                      return ListView.builder(

                                        scrollDirection: Axis.horizontal,
                                        itemCount: Categoria.length,
                                        itemBuilder: (context, index){
                                          final M.CategoriaModel categoria = Categoria[index];
                                          return C.CartaCategoria(categoriaModel: categoria);
                                        },
                                      );

                                    }

                                  }

                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, C.TransFade(page: HomeTips()));
                              },
                              child: Container(
                                height: 140.0,
                                margin: EdgeInsets.only( left: 15.0, right: 15.0, bottom: 15.0),
                                decoration: BoxDecoration(

                                  shape: BoxShape.rectangle,
                                  color: G.colorGrisFondo,
                                  borderRadius: BorderRadius.circular(10),

                                  image: DecorationImage(

                                    image: AssetImage("assets/img/slider1.jpg"),
                                    fit: BoxFit.cover,

                                  )

                                )
                              ),
                            ),
                            C.CartaOferta(),
                          ],
                        )
                      )
                    ),


                    SliverPadding(padding: EdgeInsets.only(top: 10,  left: 15, bottom: 5.0),
                        sliver: SliverList(

                            delegate: SliverChildListDelegate(
                              [

                                Text( 'Novedades',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: G.Bold
                                  ),
                                ),
                              ]
                            )
                        )

                    ),


                    SliverFillRemaining(

                        child: StreamBuilder(
                            stream: obtenerProductos(),
                            builder: (context, AsyncSnapshot<List<M.PublicacionProducto>> snapshot){
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }else{

                                List<M.PublicacionProducto> Publicaciones = snapshot.data;

                                return Publicaciones.length == 0 ? Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children : [
                                      Icon(Icons.shopping_bag_rounded,
                                      size: 120,
                                        color: G.colorGris,
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Flexible(
                                        child: Text("Aun no he agregado ningun producto",
                                          style: TextStyle(
                                            fontSize: G.texto16
                                          ),
                                        ),
                                      )

                                    ]
                                  )

                                ) :

                                ListView.builder(
                                  physics : NeverScrollableScrollPhysics(),
                                  itemCount: Publicaciones.length,
                                  itemBuilder: (context, index){
                                    final M.PublicacionProducto publicacione = Publicaciones[index];
                                    return C.CartaPublicaciones(producto: publicacione);
                                  },
                                );

                              }

                            }

                        )

                    ),


                  //  SliverList(delegate: SliverChildListDelegate(items)),

                  ],
                ),
              ),


            ]


        )

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
