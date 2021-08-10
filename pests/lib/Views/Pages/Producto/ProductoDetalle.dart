import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/Base/DbIcon.dart';
import 'package:pests/UI/Base/SliderNav.dart';
import 'package:pests/UI/Delegate/BuscadorRaza.dart';
import 'package:pests/Views/Pages/OrdenCompra/orden_compra.dart';


class ProductoDetalle extends StatefulWidget {

  final M.PublicacionProducto producto;
  final bool fav;

   ProductoDetalle({this.producto, this.fav});



  @override
  _ProductoDetalleState createState() => _ProductoDetalleState();
}

class _ProductoDetalleState extends State<ProductoDetalle> {

  int navIndex ;
  int _counter = 1;
  bool favorito = false;
  var numero ;

  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;
  int _valorTotal;

  Future<void> validarFavorito () async{

    if(widget.fav ==  false){
      await db.collection("favorito").where("id_publicacion", isEqualTo: widget.producto.id).get().then((value) {
        print("ver fav ${value.docs.length}");
        if(value.docs.length == 0){
          setState(() {
            favorito = false;
          });

        }else{
          setState(() {
            favorito = true;
          });

        }

      });
    }else{
      setState(() {
        favorito = true;
      });
    }


  }

  Future<void> eliminarFavorito () async{

    if(widget.fav == false){
      await db.collection("favorito").where("id_publicacion", isEqualTo: widget.producto.id).where("id_usuario",  isEqualTo: user.currentUser.uid ).get().then((QuerySnapshot value) {
        print("quirae fav ${value.docs.length}");
        db.collection("favorito").doc(value.docs[0].id).delete();

      });
    } else {
      db.collection("favorito").doc(widget.producto.id).delete();

    }

  }


  void _agregar() {
    setState(() {
      _counter++;

      _valorTotal  = widget.producto.valor  * _counter;
    });
  }

  void _quitar() {
    setState(() {
      _counter--;
      _valorTotal  = widget.producto.valor  * _counter;

    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _valorTotal = widget.producto.valor;
    validarFavorito();

  }


  @override
  Widget build(BuildContext context) {

    var dimencion = MediaQuery.of(context).size;
    NumberFormat numero = new NumberFormat("#,##0", "es_AR");

    crearOrden(Map<String, dynamic> ordenData){
      Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return OrdenPages(
          ordenData: ordenData,
        );
      }));
    }

    return Scaffold(

      appBar: AppBar(

        backgroundColor:  G.colorAmarillo,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black, //Color verde
          ),
          onPressed: () {
                Navigator.pop(context);
          },
        ),

        title: Text("Producto",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            color: G.colorNegro,
            fontFamily:  G.Light,

          ),
        ),
      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            width: double.infinity,
            color: G.colorBlanco,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),

                Text(widget.producto.nombre == null ? "Sin Nombre" : widget.producto.nombre,
                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),

                Stack(
                  children: [
                       CachedNetworkImage(
                          width: double.infinity - 40,
                          height: MediaQuery.of(context).size.height * 1/4,
                          imageUrl: widget.producto.foto,
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      Positioned(
                        left: 320,
                        top: 180,
                        child:  IconButton(

                            onPressed: (){

                              if(!favorito){
                                db.collection("favorito").add({

                                  "id_publicacion" : widget.producto.id,
                                  "id_usuario" : user.currentUser.uid,
                                  "foto" : widget.producto.foto,
                                  "valor" : widget.producto.valor,
                                  "nombre" : widget.producto.nombre,
                                  "tipo_envio" : widget.producto.tipo_envio,
                                  "descripcion" : widget.producto.descripcion

                                });
                                setState(() {
                                   favorito = true;
                                });
                              }else{
                                eliminarFavorito();
                                //db.collection("favorito").doc(widget.producto.id).delete();

                                setState(() {
                                  favorito = false;
                                });
                              }


                            },
                            icon: !favorito ? Icon(DBicons.heat,
                              size: 25.0,

                            ) : Icon (Icons.favorite,
                              size: 30.0,
                              color: G.colorAzulOscuro,
                            )
                        ),
                      ),

                  ]
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("\$ " + numero.format(widget.producto.valor) ,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w300,


                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Icon(Icons.local_shipping_outlined,
                      color: G.colorBoton,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Envío gratis",
                        style: TextStyle(
                          color: G.colorBoton,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                RichText( text: TextSpan(
                    children: [
                      TextSpan( text: "Cantidad disponible",
                        style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600,
                            fontFamily: G.Regular,
                            color: G.colorTexto
                        ),
                      ),
                      TextSpan(
                        text: "  (250 unidades)",
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: G.Regular,
                            color: G.colorGrisOscuro
                        ),
                      )
                    ]
                  )

                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Container(
                      width: dimencion.width * 2/4 - 80.0,
                      height: 45,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                          color: G.colorGris
                        ),
                        borderRadius: BorderRadius.circular(5.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          _counter >= 2 ? IconButton(onPressed: _quitar, icon: Icon(Icons.remove, color: G.colorAzulOscuro,)) : IconButton(onPressed: null, icon: Icon(Icons.remove)),
                          Text(
                            '$_counter',
                            style: TextStyle(
                              fontWeight: FontWeight.w700
                            ),
                          ),
                          IconButton(onPressed: _agregar,
                              icon: Icon(
                                  Icons.add,
                                  color: G.colorAzulOscuro,
                              )
                          ),

                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: dimencion.width * 2/4 + 30,
                      height: 45,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(5.0),
                          color: G.colorAmarillo
                      ),
                      

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Text("Agregar",
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: G.Bold
                            ),
                          ),
                          Text("\$ " + numero.format(_valorTotal) ,
                            style: TextStyle(
                              fontSize: 17.0,
                              fontWeight: FontWeight.w500,


                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: ElevatedButton(

                    child: Container(

                      width: double.infinity,
                      height: 45.0,
                      child: Center(
                        child: Text("Comprar ahora",


                        ),
                      ),
                    ),
                    onPressed: (){
                      crearOrden({"name": widget.producto.nombre, "preci": widget.producto.valor, "amount" : _counter});
                    },
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text("Descripción",

                  style: TextStyle(
                    fontSize: 20.0
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),

                Text(widget.producto.descripcion),

                SizedBox(
                  height: 15.0,
                ),

                Row(

                  children: [
                    IconButton(

                        onPressed: (){

                          if(!favorito){
                            db.collection("favorito").add({

                              "id_publicacion" : widget.producto.id,
                              "id_usuario" : user.currentUser.uid

                            });
                            setState(() {
                              favorito = true;
                            });
                          }else{
                            eliminarFavorito();
                            //db.collection("favorito").doc(widget.producto.id).delete();

                            setState(() {
                              favorito = false;
                            });
                          }


                        },
                        icon: !favorito ? Icon(DBicons.heat,
                          size: 25.0,

                        ) : Icon (Icons.favorite,
                          size: 30.0,
                          color: G.colorAzulOscuro,
                        )
                    ),
                    TextButton(onPressed: null,
                        child: Text(favorito ? "Quitar favoritos" : "Agregar a favoritos",
                          style: TextStyle(
                            color:  G.colorAzulOscuro,
                            fontSize: G.texto16
                          ),

                        )



                    )
                  ],
                )


              ],
            ),
          ),
        ),
      ),
    );

  }
}
