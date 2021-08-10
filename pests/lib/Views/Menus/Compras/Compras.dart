import 'package:flutter/material.dart';
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Globals/All.dart' as G;

class Compras extends StatefulWidget {
  @override
  _ComprasState createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
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

            C.SinDatos(texto: "Aun no has realizado ninguna compra", Icono: Icons.shopping_bag,)

          ],
        ),
      ),
    );
  }
}
