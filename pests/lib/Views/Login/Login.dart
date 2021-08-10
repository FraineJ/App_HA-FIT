import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pests/Data/Providers/All.dart';
import 'package:pests/UI/All.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/UI/Base/Loading.dart';
import 'package:pests/Views/Home/Home.dart';
import 'package:pests/Views/Login/Registrar.dart';
import 'package:provider/provider.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isLoading = false;
  TextEditingController correo = new TextEditingController();
  TextEditingController clave = new TextEditingController();
  bool activePass =  true;

  @override
  void afterFirstLayout(BuildContext context){

    final bool  isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    if(!isTablet){
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }

  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading ?  C.Loading() : SingleChildScrollView(
        child: Container(

          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,



          child: Form(
            key: _formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Container(


                  height: MediaQuery.of(context).size.height * 1/3 - 50,
                  width: MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(

                    image: DecorationImage(
                      image: AssetImage("assets/img/Banner.jpg"),
                      fit: BoxFit.cover,

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                 Container(
                   padding: EdgeInsets.only(left: 20, right: 20 ),
                   child: Column(
                     children: [
                       TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => EmailValidator.validate(value) ? null : "Correo invalido",
                          controller: correo,
                          decoration: InputDecoration(
                              hintText: "Correo electrónico",
                              suffixIcon: Icon(Icons.email) ,

                          ),
                           onSaved: (input) => _email = input
                       ),
                       SizedBox(height: 20,),


                       TextFormField(
                           keyboardType: TextInputType.text,
                           controller: clave,
                           decoration: InputDecoration(
                             hintText: "Contraseña",
                             suffixIcon: IconButton(
                               icon: Icon(activePass == false ?  Icons.visibility_off :  Icons.visibility,
                               ),

                               onPressed: (){

                                 setState(() {
                                   activePass == false ?  activePass = true : activePass = false;
                                 });
                               },
                             ) ,

                           ),
                           obscureText: activePass,
                           validator: (input) {
                             if (input.length < 8){
                               return 'Debe ingresar minimo 8 caracteres';
                             }

                           },
                           onSaved: (input) => _password = input
                       ),
                       SizedBox(height: 20,),
                       //C.BotonBase(callBack: authService., texto:"Iniciar sesion",  ancho: MediaQuery.of(context).size.width, color: G.colorAzul,),
                       // ignore: deprecated_member_use
                       RaisedButton(
                         onPressed: () async {
                           setState(() {
                             _isLoading = true;
                           });
                           if(_formKey.currentState.validate() == false){

                             setState(() {
                               _isLoading = false;
                             });
                           }else{
                             await authService.LoginEmail(correo.text, clave.text, context).catchError((onError) {
                               setState(() {
                                 _isLoading = false;
                               });
                             });
                           }
                         },
                         padding: new EdgeInsets.all(17.0),
                         color: G.colorBoton,
                         child: Center(
                           child: Text("Iniciar sesíon",
                             textAlign: TextAlign.center,
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: G.texto17,
                               fontFamily: G.Black,
                             ),
                           ),
                         ),
                       ),

                       SizedBox(height: 20,),

                       Container(
                         width: double.infinity,

                         child: Text("¿Has olvidado tu contraseña?",
                           // textDirection: TextDirection.rtl,
                           textAlign: TextAlign.right,

                         ),
                       ),

                       SizedBox(height: 20,),
                       Center(
                         child: TextButton(
                             onPressed: (){
                               Navigator.push(context,   C.TransFade(page: Registrar()));
                             }, child: RichText(
                           text: TextSpan(
                               text: 'Don\'t have an account?',
                               style: TextStyle(
                                   color: Colors.black, fontSize: 18),
                               children: <TextSpan>[
                                 TextSpan(text: ' Sign up',
                                   style: TextStyle(
                                       color: Colors.blueAccent, fontSize: 18),

                                 )
                               ]
                           ),



                         )

                         ),
                       )
                     ],
                   ),
                 ),


              ],
            ),
          )
        ),
      )
    );
  }
}
