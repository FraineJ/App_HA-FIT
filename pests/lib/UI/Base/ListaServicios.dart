import 'package:flutter/material.dart';


import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class ListaServicio extends StatefulWidget {
  @override
  _ListaServicioState createState() => _ListaServicioState();
}

class _ListaServicioState extends State<ListaServicio> {

  PageController _controller;
  int currentPage = 3;

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _controller = PageController(
        initialPage: currentPage,
        viewportFraction: 0.3
      );
    }



  @override
  Widget build(BuildContext context) {

    Widget _pageItem(String nombre, int posicion){
      var _alignment;

      final selecionado = TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: G.colorNegro
      );

      final deselecionado = TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.normal,
          color: G.colorGrisOscuro
      );


      if(posicion == currentPage){
        _alignment = Alignment.center;
      }else if(posicion > currentPage){
        _alignment = Alignment.centerRight;
      }else {
        _alignment = Alignment.centerLeft;
      }

      return Align(
          alignment: _alignment,
          child: Text(nombre,
          style: posicion == currentPage ? selecionado  : deselecionado,
          )
      );

    }


    Widget _selector(){
      return SizedBox.fromSize(
        size: Size.fromHeight(70.0),
          child: PageView(
            onPageChanged: (newPage){
              setState(() {
                currentPage = newPage;
              });
            },
            controller: _controller,
            children: [
              _pageItem("Veterinaria", 0),
              _pageItem("Vacunas", 1),
              _pageItem("Guarderia", 2),
              _pageItem("Peluqueria", 3),
              _pageItem("Vacunas", 4),
              _pageItem("Seguro", 5),


            ],
          )
      );

    }
    return _selector();
  }
}
