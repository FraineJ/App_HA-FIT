
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class BotonBase extends StatefulWidget {
  
  Function() callBack;
  String texto;
  double ancho;
  Color color;

  BotonBase({ this.callBack, this.texto, this.ancho, this.color });
  
  @override
  _BotonBaseState createState() => _BotonBaseState();
}

class _BotonBaseState extends State<BotonBase> {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: (){
        if ( widget.callBack != null )
          widget.callBack();
      },
      child: Container(
        height: 50,
        width: widget.ancho,
        color: widget.color,

        child: Center(
          child: Text(
            widget.texto != null ? widget.texto : "",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white,
                fontSize: G.texto17,
                fontFamily: G.Black,
            ),
          ),
        ),
      ),
    );
  }
}

