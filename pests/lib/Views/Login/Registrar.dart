import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/Data/Providers/All.dart' as CT;
import 'package:pests/UI/All.dart' as C;
import 'package:provider/provider.dart';

class Registrar extends StatefulWidget {
  @override
  _RegistrarState createState() => _RegistrarState();
}

class _RegistrarState extends State<Registrar> {

  TextEditingController controllerNombre =  new TextEditingController();
  TextEditingController controllerCorreo =  new TextEditingController();
  TextEditingController controllerClave =  new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {


    Widget _nombreUser (){

      return Container(
          margin: EdgeInsets.only( top: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                  margin: EdgeInsets.only( bottom: 15.0,),
                  child: Row(
                    children: [

                      Text("Nombre",
                          style: TextStyle(
                              fontFamily: G.Bold,
                              color: G.colorNegro,
                              fontSize: G.texto17
                          )
                      ),
                    ],
                  )
              ),

              TextFormField(
                controller: controllerNombre,
                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                    hintText: "Nombre del grupo",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ],
          )

      );

    }

    Widget _correoUser (){

      return Container(
          margin: EdgeInsets.only( top: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                  margin: EdgeInsets.only( bottom: 15.0,),
                  child: Row(
                    children: [

                      Text("Correo electrónico",
                          style: TextStyle(
                              fontFamily: G.Bold,
                              color: G.colorNegro,
                              fontSize: G.texto17
                          )
                      ),
                    ],
                  )
              ),

              TextFormField(

                controller: controllerCorreo,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",
                decoration:  InputDecoration(
                    hintText: "Tu correo electrónico",

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),

              ),
            ],
          )

      );

    }

    Widget _claveUser (){

      return Container(
          margin: EdgeInsets.only( top: 10.0, bottom: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Container(
                  margin: EdgeInsets.only( bottom: 15.0,),
                  child: Row(
                    children: [

                      Text("Contraseña",
                          style: TextStyle(
                              fontFamily: G.Bold,
                              color: G.colorNegro,
                              fontSize: G.texto17
                          )
                      ),
                    ],
                  )
              ),

              TextFormField(

                controller: controllerClave,

                keyboardType: TextInputType.text,
                decoration:  InputDecoration(
                    hintText: "Tu Contraseña",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.visibility_off,
                      ),

                      onPressed: (){


                      },
                    ) ,

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)
                    )
                ),
                obscureText: true,
                validator: (input) {
                  if (input.length < 8){
                    return 'Debe ingresar minimo 8 caracteres';
                  }

                },

              ),
            ],
          )

      );

    }


    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),

          child: Container(
            child: Column(
              children: [
                _nombreUser(),
                _correoUser(),
                _claveUser(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
