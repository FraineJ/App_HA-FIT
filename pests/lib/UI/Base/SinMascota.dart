import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Views/Menus/MisRutinas/onboarding.dart';

class SinMascota extends StatelessWidget {

  final String texto;
  final IconData Icono;

  const SinMascota({this.texto, this.Icono});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(

              width: 130,
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .scaffoldBackgroundColor),

                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:  AssetImage("assets/img/mascota.jpg"),
                ),
              )
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Text(texto),
        SizedBox(
          height: 20.0,
        ),
        ElevatedButton(

          onPressed: () async {
            Navigator.push(context, C.TransFade(page: OnboardingScreen()));

          },
          style: ElevatedButton.styleFrom(

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),

          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15.0),
            child: Text("Agregar mascota",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: G.texto15,
              ),
            ),
          ),
        ),

      ],
    );
  }
}
