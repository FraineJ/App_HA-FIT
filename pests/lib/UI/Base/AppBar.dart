import 'package:flutter/material.dart';
import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class AppBarBase extends StatefulWidget {

  final bool ocultarTitulo;
  final String titulo;
  final double sizeTitulo;
  final Color colorTitulo, color;
  final Color tipo;
  final Function atrasAccion;
  final bool atras;
  final IconData icono;

  AppBarBase({this.ocultarTitulo = false, this.titulo, this.colorTitulo, this.sizeTitulo, this.atrasAccion,this.atras = true, this.tipo, this.color, this.icono});

  @override
  _AppBarBaseState createState() => _AppBarBaseState();
}

class _AppBarBaseState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {

    return AppBar(

      centerTitle: true,

      title: widget.ocultarTitulo ? Container() : FittedBox(
        fit: BoxFit.fill,
        child: Text(

          widget.titulo,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: widget.sizeTitulo != null ? widget.sizeTitulo: G.texto15,
            color: widget.colorTitulo != null ? widget.colorTitulo : G.colorNegro ,
          ),
        ),
      ),
      backgroundColor: widget.color != null ? widget.color : G.colorBlanco,
      elevation: 0,

      leading: widget.atras != false ? GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          widget.atrasAccion != null ? widget.atrasAccion() : Navigator.pop(context);
        },
        onLongPress: (){
          widget.atrasAccion != null ? widget.atrasAccion() : Navigator.pop(context);
        },
        child: Icon(
          widget.icono != null ? widget.icono : Icons.arrow_back,
          color: G.colorNegro,
          size: 25,
        ),
      ):Container() ,

      /*actions: <Widget>[
        Center(
          child: Container(
            alignment: Alignment.centerRight,
            child: derecha != null ? derecha : Container(),
          ),
        )
      ],*/

    );
  }
}
