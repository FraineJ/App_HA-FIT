import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Views/Login/Login.dart';

class SplashScreen extends StatelessWidget {


  void login(){

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 20, right: 20 ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/splascreen.jpg"),
              fit: BoxFit.cover,

            ),
          ),

          child: Column(
            children: [
              Container(

                height: MediaQuery.of(context).size.height * 3/4,
                padding: EdgeInsets.only(top: 30 ),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Pest",
                      style: TextStyle(
                        fontSize: 60
                      ),
                    ),

                    Text("Pests la app favorita de tus mascotas ",
                      style: TextStyle(
                          fontSize: 18
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [

                  C.BotonBase( callBack: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                  }, texto:"Iniciar sesion", ancho: MediaQuery.of(context).size.width * 2/4 - 20, color: G.colorAzul,),
                  C.BotonBase(callBack:login, texto:"Registrate", ancho: MediaQuery.of(context).size.width * 2/4 - 20, color: G.colorRojoOscuro),

                ],
              )
            ],
          ),

        ),
      ),
    );

  }
}
