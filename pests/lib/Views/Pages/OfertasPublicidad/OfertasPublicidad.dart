import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Models/All.dart' as M;

class OfertasPublicidad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Container(

      ) ,

    );
  }
}
