import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class Veterinaria extends StatefulWidget {
  @override
  _VeterinariaState createState() => _VeterinariaState();
}

class _VeterinariaState extends State<Veterinaria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: G.colorGrisFondo,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        height:  MediaQuery.of(context).size.height,

        color: G.colorGrisFondo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            C.SinDatos(texto: "Aun no se han registrado ningun servicio de peluqueria", Icono: Icons.pets,)

          ],
        ),
      ),
    );
  }
}
