
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';


import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as dbController;
import 'package:pests/UI/Delegate/BuscadorRaza.dart';
import 'package:toast/toast.dart';

class Macronutrientes extends StatefulWidget {
  @override
  _MacronutrientesState createState() => _MacronutrientesState();
}



class _MacronutrientesState extends State<Macronutrientes> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;


  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  int edad = 0;
  String _genero = null;
  double _tipoActividad = null;
  double  kcal = 0;
  double macro = 0;

  bool _isLoading = false;

  int selectedGenero;


  TextEditingController alturaController = new TextEditingController();
  TextEditingController pesoController = new TextEditingController();

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 10.0,
      width: isActive ? 10.0 : 10.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.blueAccent : Color(0xFFB0BEC5),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }



  @override
  void initState(){

    selectedGenero = 0;

  }


  setSelectedRadio(int val) {
    setState(() {
      selectedGenero = val;
      if(selectedGenero == 1){
        _tipoActividad = 1.2;
      }else if(selectedGenero == 2){
        _tipoActividad = 1.375;
      }else if(selectedGenero == 3){
        _tipoActividad = 1.55;
      }else{
        _tipoActividad = 1.725;
      }

    });
  }

  DateTime _dateTime  = new DateTime.now();




  @override
  Widget build(BuildContext context) {


    Widget  showDatos(double kcal, double kcalT) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(
                    child: AlertDialog(

                      title: Row(
                        children:[

                            Flexible(child: Center(
                              child: Text('Informacón',
                                style: TextStyle(
                                    fontSize: G.texto18
                                ),
                              ),
                            ))
                        ]
                      ),
                      content: Container(
                        child: SingleChildScrollView(
                          child: Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/img/manzana.svg",
                                      width:  40,
                                      height: 40,
                                    ),

                                    Flexible(
                                      child: RichText(
                                        text:  TextSpan(
                                          children: [
                                            TextSpan(text : "debes consumir diariamente como mínimo ",
                                              style: TextStyle(
                                                fontSize: G.texto12,
                                                color:G.colorNegro,
                                              ),
                                            ),
                                            TextSpan(text : kcal.toString(),
                                              style: TextStyle(
                                                fontSize: G.texto12,
                                                color:G.colorNegro,
                                                fontFamily: G.Bold
                                              ),
                                            ),
                                            TextSpan(text : " como minimo",
                                              style: TextStyle(
                                                fontSize: G.texto12,
                                                color:G.colorNegro,

                                              ),
                                            ),

                                        ]
                                      ),
                                    )),

                                  ],
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),


                                Row(
                                  children: [
                                    SvgPicture.asset("assets/img/manzana.svg",
                                      width:  40,
                                      height: 40,
                                    ),

                                    Flexible(
                                      child: Text("debes consumir diariamente como mínimo " + kcal.toString() + "kcal como minimo" ,
                                        style: TextStyle(
                                          fontSize: G.texto12,
                                          color:G.colorNegro,
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                            ]
                          )
                        )
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Aceptar')
                        ),
                      ],
                    ),
                  ),
                ],

              ),
            );
          });
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading ? Center(child: CircularProgressIndicator()) :  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
          key: _formKey,
          child: Container(


            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);

                      },
                      child: Text(
                        'Volver',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18.0,
                            fontFamily: G.Regular
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: G.ancho,
                    height: 600.0,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,

                      children: <Widget>[
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              SizedBox(height: 30.0),
                              Text(
                                  'Elige Tu  Sexo',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black54,

                                  )
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _genero = "Masculino";
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 480),
                                          curve: Curves.bounceOut,
                                        );
                                        _currentPage = _currentPage + 1 ;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 1/4 ,
                                        width: MediaQuery.of(context).size.width /2  - 30,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),

                                          boxShadow: [
                                            BoxShadow(

                                              spreadRadius: 5,
                                              color: G.colorGris.withOpacity(0.5),
                                              offset: new Offset(0.0, 10.0),
                                              blurRadius: 20.0,
                                            ),
                                          ],
                                          color: G.colorBlanco,

                                        ),
                                        child: Column(
                                          children: [
                                            Container(

                                                width: MediaQuery.of(context).size.width /2  - 30,
                                                height: 200,

                                                child:


                                                CachedNetworkImage(

                                                  imageBuilder: (context, imageProvider) => Container(

                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft:  Radius.circular(5.0), topRight: Radius.circular(5.0) ),

                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,

                                                      ),
                                                    ),
                                                  ),

                                                  imageUrl: "https://cdn.pixabay.com/photo/2016/09/21/21/46/sport-1685786_960_720.jpg",
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      C.SkeletonCircular(),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),

                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context).scaffoldBackgroundColor,

                                                  ),

                                                )
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text("Masculino")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _genero ="Femenino";

                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 480),
                                          curve: Curves.bounceOut,
                                        );
                                        _currentPage = _currentPage + 1 ;

                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height * 1/4 ,
                                        width: MediaQuery.of(context).size.width /2  - 30,

                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5.0),

                                          boxShadow: [
                                            BoxShadow(

                                              spreadRadius: 5,
                                              color: G.colorGris.withOpacity(0.5),
                                              offset: new Offset(0.0, 10.0),
                                              blurRadius: 20.0,
                                            ),
                                          ],
                                          color: G.colorBlanco,

                                        ),
                                        child: Column(
                                          children: [
                                            Container(

                                                width: MediaQuery.of(context).size.width /2  - 30,
                                                height: 200,

                                                child:


                                                CachedNetworkImage(

                                                  imageBuilder: (context, imageProvider) => Container(

                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.only(topLeft:  Radius.circular(5.0), topRight: Radius.circular(5.0) ),

                                                      image: DecorationImage(
                                                        image: imageProvider,
                                                        fit: BoxFit.cover,

                                                      ),
                                                    ),
                                                  ),

                                                  imageUrl: "https://cdn.pixabay.com/photo/2017/06/15/22/05/woman-2406963_960_720.jpg",
                                                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                                                      C.SkeletonCircular(),
                                                  errorWidget: (context, url, error) => Icon(Icons.error),
                                                ),

                                                decoration: BoxDecoration(
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: Theme.of(context).scaffoldBackgroundColor,

                                                  ),

                                                )
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text("Femenino")
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),





                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Tu Fecha De Nacimiento ',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black54,


                                    )
                                ),
                                SizedBox(height: 15.0),
                                SizedBox(
                                  height: 200,
                                  child: CupertinoDatePicker(

                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: _dateTime,
                                    backgroundColor: Colors.white,
                                    onDateTimeChanged: (datetime){
                                      setState(() {
                                        _dateTime = datetime;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(height: 15.0),
                                OutlinedButton(

                                  onPressed: ()  {
                                    DateTime fechaActual = DateTime.now();
                                    if( _dateTime.isAfter(fechaActual) == true ){

                                      Toast.show(
                                          "La fecha no puede ser  mayor al dia de hoy",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM,
                                          backgroundColor:
                                          Colors.grey[800],
                                          textColor: Colors.white);
                                    }else{

                                      setState(() {

                                        final difference = _dateTime.difference(fechaActual).inDays;
                                        double ed  = (difference.toInt() * -1 )  / 365;

                                        edad = ed.toInt();
                                        print("Edad de frainer ${edad}");
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 480),
                                          curve: Curves.bounceOut,
                                        );
                                        _currentPage = _currentPage + 1 ;
                                      });

                                    }



                                  },

                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.grey[100];
                                      }
                                      return Colors.blue;
                                    }),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                  ),


                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15.0),
                                    child: Text("Establecer",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: G.texto15,
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Ingresa tu altura y peso",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black54,


                                    )
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Altura"),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (val) => val.isEmpty ? "Campo requerido" : null,

                                      controller: alturaController,
                                      decoration: InputDecoration(
                                          hintText: "En cm",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )

                                      ),


                                    ),

                                    SizedBox(
                                      height: 20.0,
                                    ),

                                    Text("Peso"),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      validator: (val) => val.isEmpty ? "Campo requerido" : null,

                                      controller: pesoController,
                                      decoration: InputDecoration(
                                          hintText: "En kg",
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10)
                                          )

                                      ),


                                    ),

                                    SizedBox(height: 15.0),

                                    Center(
                                      child: ElevatedButton(

                                        onPressed: ()  {
                                          if(_formKey.currentState.validate() == false){

                                          }else{
                                            setState(() {
                                              _pageController.nextPage(
                                                duration: Duration(milliseconds: 480),
                                                curve: Curves.bounceOut,
                                              );
                                              _currentPage = _currentPage + 1 ;
                                            });
                                          }


                                        },
                                        style: ElevatedButton.styleFrom(

                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(32.0),
                                          ),
                                        ),

                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15.0),
                                          child: Text("Siguiente",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: G.texto15,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                                SizedBox(height: 15.0),

                              ],
                            ),
                          ),
                        ),


                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("ACTIVIDAD FÍSICA",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black54,


                                    )
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Column(
                                  children: [
                                    ButtonBar(
                                      alignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          child: Row(
                                            children: [
                                              Radio(
                                                  value: 1,
                                                  groupValue: selectedGenero,
                                                  activeColor: Colors.green,
                                                  onChanged: (val) {
                                                    setSelectedRadio(val);
                                                  }
                                              ),
                                              Text("Realizas muy poco o nada de ejercicio."),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          children: [
                                            Radio(

                                                value: 2,
                                                groupValue: selectedGenero,
                                                activeColor: Colors.green,
                                                onChanged: (val) {
                                                  setSelectedRadio(val);
                                                  print("su genero es ${val}");
                                                }
                                            ),
                                            Text("Haces ejercicio 1 o 2 días a la semana."),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Radio(

                                                value: 3,
                                                groupValue: selectedGenero,
                                                activeColor: Colors.green,
                                                onChanged: (val) {
                                                  setSelectedRadio(val);
                                                }
                                            ),
                                            Text("Haces ejercicio 3 o 5 días a la semana"),
                                          ],
                                        ),

                                        Row(
                                          children: [
                                            Radio(

                                                value: 4,
                                                groupValue: selectedGenero,
                                                activeColor: Colors.green,
                                                onChanged: (val) {
                                                  setSelectedRadio(val);
                                                }
                                            ),
                                            Text("Haces ejercicio todos los días."),
                                          ],
                                        ),

                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 15.0),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  _currentPage != _numPages - 1 ? Expanded(
                    child: Align(
                      alignment: FractionalOffset.bottomRight,
                      child: FlatButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  : Text(''),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                if(_tipoActividad == null){
                  Toast.show(
                      "Debe seleccionar tu actividad fisica",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM,
                      backgroundColor:
                      Colors.grey[800],
                      textColor: Colors.white
                  );

                }  else {

                  int peso = int.parse(pesoController.text) * 10;
                  double altura = int.parse(alturaController.text) * 6.25;
                  int nEdad = edad * 5;

                  double total =  peso + altura + nEdad;

                  if(_genero == "Masculino"){

                    setState(() {
                       kcal  =  total + 5 ;
                    });


                  }else{
                    setState(() {
                       kcal =  total - 161 ;

                    });
                  }

                   macro = kcal * _tipoActividad;

                  print("kcal ${kcal}");
                  print("metabolismo basal ${macro}");


                  showDatos( kcal, macro );




                }
              },

          child: Visibility(
            child: Container(
              height: 100.0,
              width: double.infinity,
              color: Colors.blue,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    'Guardar',
                    style: TextStyle(
                      color: G.colorBlanco,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

            ),
            visible: _isLoading == false ? true : false,
          ),
      )
          : Text(''),
    );
  }
}
