import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Views/Pages/Producto/ProductoDetalle.dart';

class CartaFavoritos extends StatelessWidget {


  final M.PublicacionProducto producto;

  const CartaFavoritos({this.producto});


  @override
  Widget build(BuildContext context) {

    NumberFormat numero = new NumberFormat("#,##0", "es_AR");


    Widget CardProducto (){
      // DocumentSnapshot data = dataProducto.data();
      return  GestureDetector(
        onTap: (){

          Navigator.of(context).push(PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 350),
              pageBuilder: (_, animation1, animation2){
                return SlideTransition(
                    position:  Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end:  Offset(0.0, 0.0),
                    ).animate(animation1),

                    child: ProductoDetalle(producto: producto , fav: true,)

                );}
          ));

        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(


            width: MediaQuery.of(context).size.width  ,
            height: 120,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),

              boxShadow: [
                BoxShadow(

                  spreadRadius: 5,
                  color: G.colorGris.withOpacity(0.5),
                  offset: new Offset(0.0, 10.0),
                  blurRadius: 20.0,
                ),
              ],
              color: G.colorBlanco,

            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 1/4 ,
                        height: 100,

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5)
                          ),

                        ),
                        child: CachedNetworkImage(
                          imageUrl: producto.foto,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(top: 10.0),
                      width: MediaQuery.of(context).size.width * 3/4 - 40,
                      height: 100,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Flexible(child: Text(producto.nombre ,
                            style: TextStyle(
                                fontSize: 15
                            ),
                          )),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text("\$ " + numero.format(producto.valor) ,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400,


                            ),
                          ),
                          Text("Envio gratis",
                            style: TextStyle(
                                color: G.colorBoton,
                                fontSize: 12.0
                            ),
                          )
                        ],
                      ) ,
                    ),

                  ],

                ),

              ],
            ),

          ),
        ),
      );

    }

    return CardProducto();
  }
}
