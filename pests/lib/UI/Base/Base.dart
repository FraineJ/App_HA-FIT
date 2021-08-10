import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class Margen extends StatelessWidget {

  final double vertical, horizontal;
  Margen({Key key, this.vertical, this.horizontal}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
          top: vertical != null ? vertical : 0.0,
          left: horizontal != null ? horizontal : 0.0
      ),
    );
  }
}


class BarraCorte extends StatelessWidget {

  final bool margen;

  BarraCorte({Key key, this.margen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (margen == null || margen == false) {
      return Container(
        height: 0.5,
        width: G.ancho,
        color: G.colorGris,
      );
    } else {
      return Container(
          height: 0.5,
          width: G.ancho,
          color: G.colorGris,
          margin: EdgeInsets.only(bottom: G.margen4));
    }
  }
}