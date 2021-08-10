import 'package:flutter/material.dart';
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Globals/All.dart' as G;

class Programaciones extends StatefulWidget {
  @override
  _ProgramacionesState createState() => _ProgramacionesState();
}

class _ProgramacionesState extends State<Programaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        color: G.colorGrisFondo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            C.SinDatos(texto: "Aun no se han registrado ningun servicio de peluqueria", Icono: Icons.assignment,)

          ],
        ),
      ),
    );
  }
}
