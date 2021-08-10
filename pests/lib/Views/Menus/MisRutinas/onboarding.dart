
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';


import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as dbController;
import 'package:pests/UI/Delegate/BuscadorRaza.dart';
import 'package:toast/toast.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}



class _OnboardingScreenState extends State<OnboardingScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth user = FirebaseAuth.instance;


  final int _numPages = 4;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  String nombreRaza = null;
  String genero = null;
  bool _isLoading = false;

  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;
  File imagenUser;
  String path_img;
  String urlFoto;


  void obtenerFoto(ImageSource source) async {
    final pickFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickFile;
      print("ver _imageFile ${_imageFile}");
    });
  }



  TextEditingController nombreController = new TextEditingController();
  TextEditingController razaController = new TextEditingController();

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

    print("ver _imageFile ${_imageFile}");

  }

  DateTime _dateTime  = new DateTime.now();


  Widget ImagenProfile() {

    return  GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: ((build) => ButonElegir()),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 130,
        decoration: BoxDecoration(
            border: Border.all(),

            borderRadius: BorderRadius.circular(10.0),

            image: DecorationImage(
                fit: BoxFit.cover,

                image: _imageFile == null  ?  AssetImage("assets/img/subir-imagen.png")  : FileImage(File(_imageFile.path)) //FileImage(File(_imageFile.path)),
            )),
      ),
    );
  }

  Widget ButonElegir() {
    return Container(
      height: G.ancho * 2/4 - 50 ,

      child: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.all(16.0),
              height: 9,
              width:  80,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(16.0)
              ),
            ),
          ),
          Column(
            children: [

              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      obtenerFoto(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera,
                          size: 40.0,
                        ),
                        SizedBox(
                          width: G.margen,
                        ),
                        Text("Camara",
                          style: TextStyle(
                              fontSize: G.texto17
                          ) ,
                        ),
                      ],
                    ),
                  ),

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      obtenerFoto(ImageSource.gallery);
                    },
                    child: Row(
                      children: [

                        Icon(Icons.photo_size_select_actual,
                          size: 40.0,

                        ),
                        SizedBox(
                          width: G.margen,
                        ),
                        Text("Galeria",
                          style: TextStyle(
                              fontSize: G.texto17
                          ) ,
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading ? Center(child: CircularProgressIndicator()) :  AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
             color: genero == null ? Colors.white :  genero == "Macho" ? Colors.blue : genero == "Hembra" ? Colors.pinkAccent : Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.0),
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
                    height: 600.0,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _pageController,

                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: SingleChildScrollView(
                            child: Column(

                              children: <Widget>[
                                Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(

                                            border: Border.all(
                                                width: 4, color: Theme.of(context).scaffoldBackgroundColor),

                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: _imageFile == null  ?  AssetImage("assets/img/mascota.jpg")  : FileImage(File(_imageFile.path)) //FileImage(File(_imageFile.path)),

                                            )),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0.0,

                                      right: 67.0,
                                      child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(topRight: Radius.circular(30.0), topLeft:  Radius.circular(30.0))
                                              ),
                                              builder: ((build) => ButonElegir()),

                                            );
                                          },
                                          child: Container(
                                              width: 50.0,
                                              height: 50.0,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 3,
                                                  color: Theme.of(context).scaffoldBackgroundColor,
                                                ),
                                                color: Colors.blue,
                                              ),
                                              child: InkWell(
                                                child: Container(
                                                  child: Icon(Icons.camera_alt, color: Colors.white),
                                                ),
                                              )
                                          )
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30.0),
                                Text(
                                  '¿Cómo se llama tu mascota?',
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.black54,

                                  )
                                ),
                                SizedBox(height: 15.0),

                                TextFormField(

                                  keyboardType: TextInputType.text,
                                  validator: (val) => val.isEmpty ? "Campo requerido" : null,

                                  controller: nombreController,
                                    decoration: InputDecoration(
                                      hintText: "Nombre de tu mascota",
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )

                                    ),


                                ),
                                SizedBox(height: 35.0),
                                ElevatedButton(

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

                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(40.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              SizedBox(height: 30.0),
                              Text(nombreRaza == null ? '¿Cual es la raza de ' + nombreController.text + "?" :  nombreController.text + " es un " + nombreRaza,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.black54,

                                  )
                              ),
                              SizedBox(height: 15.0),


                              SizedBox(height: 35.0),
                              nombreRaza ==  null ? ElevatedButton(

                                onPressed: () async {

                                  showSearch(
                                      context: context,
                                      delegate: BuscadorRaza()
                                  ).then((value) {
                                    setState(() {
                                      nombreRaza = value;
                                    });
                                  });


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
                                  child: Text("Buscar Raza",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: G.texto15,
                                    ),
                                  ),
                                ),
                              ) :

                              Column(
                                children: [
                                  ElevatedButton(

                                    onPressed: () async {

                                      showSearch(
                                          context: context,
                                          delegate: BuscadorRaza()
                                      ).then((value) {
                                        setState(() {
                                          nombreRaza = value;
                                        });
                                      });


                                    },

                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                                        if (states.contains(MaterialState.disabled)) {
                                          return Colors.grey[100];
                                        }
                                        return Colors.grey;
                                      }),
                                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                    ),

                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 15, bottom: 15.0),
                                      child: Text("Cambiar Raza",

                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: G.texto15,
                                        ),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: 20.0,
                                  ),

                                  ElevatedButton(

                                    onPressed: () async {



                                      setState(() {
                                        _pageController.nextPage(
                                          duration: Duration(milliseconds: 480),
                                          curve: Curves.bounceOut,
                                        );
                                        _currentPage = _currentPage + 1 ;
                                      });

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
                                      child: Text("Siguiente",

                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: G.texto15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )


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
                                Text('¿Cual es la Fecha de nacimiento de  ' + nombreController.text + " es ?",
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
                                    DateTime frchaActual = DateTime.now();
                                    if( _dateTime.isAfter(frchaActual) == true ){

                                      Toast.show(
                                          "El cumpleaños no puede ser mayor al dia de hoy",
                                          context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM,
                                          backgroundColor:
                                          Colors.grey[800],
                                          textColor: Colors.white);
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
                                Text("¿Cuál es el género de tu mascota?",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black54,


                                    )
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        FloatingActionButton(
                                            onPressed: (){
                                              setState(() {
                                                genero = "Macho";
                                              });


                                            },
                                            child: Icon(Icons.male,
                                            size: 40.0,
                                            color: G.colorBlanco,
                                          )
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Mancho")
                                      ],
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Column(
                                      children: [
                                        FloatingActionButton(

                                            backgroundColor: Colors.pinkAccent,
                                            onPressed: (){
                                                setState(() {
                                                  genero = "Hembra";
                                                });
                                            },
                                            child: Icon(Icons.female,
                                              size: 40.0,
                                              color: G.colorBlanco,
                                            )
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text("Hembra")
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
                  _currentPage != _numPages - 1
                      ? Expanded(
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
              if(genero == null){
                Toast.show(
                    "Debe selecionar el sexo de su mascopa para poder continuar",
                    context,
                    duration: Toast.LENGTH_LONG,
                    gravity: Toast.BOTTOM,
                    backgroundColor:
                    Colors.grey[800],
                    textColor: Colors.white
                );

              }else {

                setState(() {
                  _isLoading = true;
                });

                if(_imageFile == null ){
                  dbController.guardarMacota(M.MascotaModel(
                      nombre: nombreController.text.toString()
                          .substring(0, 1)
                          .toUpperCase() +
                          nombreController.text.toString().substring(
                            1,),
                      genero: genero,
                      fechaNacimienta: _dateTime,
                      foto: "",
                      especie: "Perro",
                      raza: nombreRaza,
                      id_usuario: user.currentUser.uid

                  )).then((value) {
                    if (value != null) {
                      setState(() {
                        _isLoading = false;
                        Navigator.pop(context);
                      });
                    }
                  });
                }else {
                  dbController.uploadFileImage(File(_imageFile.path)).then((
                      UploadTask storageUploadTask) {
                    storageUploadTask.then((TaskSnapshot snapshot) {
                      snapshot.ref.getDownloadURL().then((urlImage) {
                        print(" URL IMAGEN ${urlImage}");
                        setState(() {
                          urlFoto = urlImage;
                        });

                        dbController.guardarMacota(M.MascotaModel(
                            nombre: nombreController.text.toString()
                                .substring(0, 1)
                                .toUpperCase() +
                                nombreController.text.toString().substring(
                                  1,),
                            genero: genero,
                            fechaNacimienta: _dateTime,
                            foto: urlImage,
                            especie: "Perro",
                            raza: nombreRaza,
                            id_usuario: user.currentUser.uid

                        )).then((value) {
                          if (value != null) {
                            setState(() {
                              _isLoading = false;
                              Navigator.pop(context);
                            });
                          }
                        });
                      });
                    });
                  });
                }
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
