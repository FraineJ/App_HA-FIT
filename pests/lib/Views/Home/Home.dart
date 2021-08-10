import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pests/UI/Base/SliderNav.dart';
import 'package:pests/UI/Cartas/HomeCarusel.dart';
import 'package:pests/UI/Delegate/BuscadorRaza.dart';
import 'package:pests/Views/Menus/Compras/Compras.dart';
import 'package:pests/Views/Menus/Favoritos/Favoritos.dart';
import 'package:pests/Views/Menus/MisRutinas/MisRutinas.dart';
import 'package:pests/Views/Menus/MiCuenta/MiCuenta.dart';
import 'package:pests/Views/Menus/Notificacciones/Notificaciones.dart';
import 'package:pests/Views/Menus/Nutricion/Nutricion.dart';
import 'package:pests/Views/Pages/Inicio/Inicio.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int navIndex = 0;

  Inicio inicio;
  MisRutinas misRutinas;
  Compras compras;
  Favoritos favoritos;
  Nutricion nutricion;
  Notificaciones notificaciones;
  MiCuenta micuenta;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    inicio = Inicio();
    misRutinas = MisRutinas();
    compras = Compras();
    favoritos = Favoritos();
    nutricion = Nutricion();
    notificaciones = Notificaciones();
    micuenta = MiCuenta();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        drawer: Sidenav( navIndex, (int index) {
          setState(() {
            navIndex = index;
          });
        }),
        appBar: AppBar(

          backgroundColor:  G.colorAmarillo,
          automaticallyImplyLeading: false,
          toolbarHeight: navIndex == 0 ? 90 : 60,
          leadingWidth: double.infinity,

          title: Column(

            children: [
              Container(
                padding: const EdgeInsets.all(0.0),

                child: Row(
                  mainAxisAlignment: navIndex == 0 ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start,

                  children: [

                    Builder(
                        builder: (BuildContext context) {
                          return IconButton(
                              onPressed: () => Scaffold.of(context).openDrawer(),
                              icon: Icon(Icons.menu_rounded,
                                size: 37.0,
                                color: G.colorNegro,
                              )
                          );
                        }
                    ), navIndex == 0 ?

                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        showSearch(
                            context: context,
                            delegate: BuscadorRaza()
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 3/4 - 30,
                        height: 40,
                        decoration: BoxDecoration(
                            color:  G.colorBlanco,
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                        child:  Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.search_rounded,
                                color: G.colorGrisOscuro,
                                size: 23.0,

                              ),
                            ),
                            Text("Que vas a pedir hoy",
                              style: TextStyle(
                                  fontFamily:  G.Light,
                                  fontSize: 15.0,
                                  color: G.colorGrisOscuro
                              ),
                            )

                          ],
                        ),
                      ),
                    ) : Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 10.0),
                      child: Text(navIndex == 1 ? "Rutinas" : navIndex == 2 ? "Nutrición" : navIndex == 3 ? "Mis compras" : navIndex == 4 ? "Favoritos" : navIndex == 5 ? "Notificaciones" : "Mi cuenta",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: G.colorNegro,
                          fontFamily:  G.Light,

                        ),
                      ),
                    ),

                    navIndex == 0 ?

                    IconButton(onPressed: null,
                        icon: Icon(Icons.shopping_cart_outlined,
                          size: 28.0,
                          color: G.colorNegro,
                        )
                    ) : Text("")


                  ],
                ),
              ),
              Visibility(
                child: Padding(
                  padding: const EdgeInsets.only(left: 9.0, top: 8.0),

                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                        size: 20.0,
                        color: G.colorNegro,
                      ),
                      Text("Ingresa tu ubicación",
                        style: TextStyle(
                            fontSize: 14.0,
                            color: G.colorNegro,
                            fontFamily:  G.Light,
                            fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
                visible: navIndex == 0 ? true : false ,
              ),
            ],
          ),
        ),

        body: Builder(
            builder: (context) {
              switch (navIndex) {
                case 0 :
                  return Container(
                      child: inicio
                  );

                case 1 : return Container(
                  child: misRutinas,
                );

                case 2 : return Container(
                  child: nutricion,
                );

                case 3 : return  Container(
                  child: compras,
                );

                case 4 : return Container(
                  child: favoritos,
                );

                case 5 : return Container(
                  child: notificaciones,
                );

                case 6 : return Container(
                  child: micuenta,
                );

                default: return Container(
                    child: inicio
                );

              }

            }


        )

    );
  }
}
