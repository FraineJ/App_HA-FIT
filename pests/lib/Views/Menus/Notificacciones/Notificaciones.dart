import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class Notificaciones extends StatefulWidget {
  @override
  _NotificacionesState createState() => _NotificacionesState();
}

class _NotificacionesState extends State<Notificaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: G.colorBlanco,
        width: double.infinity,
        height:  MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            C.SinDatos(texto: "No cuentas con notificaciones nuevas", Icono: Icons.notifications_rounded,)
          ],
        ),
      ),
    );
  }
}
