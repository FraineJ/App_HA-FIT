import 'package:flutter/material.dart';





List<Widget> razaMascotasWidget(BuildContext context, List<dynamic> razas, String textoBusqueda ){

  final List<Widget> ListaRaza = [];




  razas.forEach((razas) {
    var texto = razas['nombre'].toString().toLowerCase();
    if( texto.contains(textoBusqueda) ){
      final listadoWidget = _cuerpoLitaRaza(context, razas);
      ListaRaza.add(listadoWidget);
    }


    return ListaRaza;

  });



}



Widget _cuerpoLitaRaza( BuildContext context, Map<String, dynamic> razas){

  return GestureDetector(
    onTap: (){

    },
    child: Column(
      children: [
        Text(razas["nombre"]),
      ],
    ),
  );

}