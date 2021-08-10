import 'package:flutter/material.dart';

class SinDatos extends StatelessWidget {

  final String texto;
  final IconData Icono;

  const SinDatos({this.texto, this.Icono});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Icon(Icono,
          size: 100.0,
          color: Colors.grey,

        ),
        SizedBox(
          height: 20.0,
        ),
        Text(texto)

      ],
    );
  }
}
