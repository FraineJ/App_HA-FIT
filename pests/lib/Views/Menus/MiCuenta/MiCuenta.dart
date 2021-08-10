import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pests/Data/Providers/All.dart';
import 'package:provider/provider.dart';


import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as dbController;


class MiCuenta extends StatefulWidget {
  @override
  _MiCuentaState createState() => _MiCuentaState();
}

class _MiCuentaState extends State<MiCuenta> {


  void PasarPagina(Pagina){
    Navigator.push(context, C.TransFade(page: Pagina));
  }

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    void Salir ()async {
      await authService.signOut();
    }



    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [


            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(

                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 1,
                            color: Theme.of(context)
                                .scaffoldBackgroundColor),

                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  AssetImage("assets/img/Banner.jpg"),
                        ),
                      )
                  ),
                ),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                child: Text("Frainer Simarra Aguilar",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: G.texto17,
                  ),
                ),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,  bottom: 8.0),
                child: Text("frainer2013@gmail.com",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: G.texto12,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,

            ),
            SizedBox(
              height: G.margen,
            ),
            Container(
              width: G.ancho,
              child: Text("Mascotas",
                textAlign: TextAlign.left,

              ),
            ),


            Container(
              height: 100,
              child: StreamBuilder(
                stream: dbController.listarMascotas(),
                builder: (context, AsyncSnapshot<List<M.MascotaModel>> snapshot){

                  List<M.MascotaModel> mascotaModel = snapshot.data;
                  if(!snapshot.hasData){
                    return Center(child: CircularProgressIndicator());
                  } else {
                    print("lista de mis mascotas ${mascotaModel.length}");

                    return ListView.builder(

                        scrollDirection: Axis.horizontal,
                        itemCount: mascotaModel.length,

                        itemBuilder: (context, index){
                          final M.MascotaModel mascota = mascotaModel[index];
                          return   Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1,
                                      color: Theme.of(context).scaffoldBackgroundColor),

                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:  mascota.foto == "" || mascota.foto == null ? AssetImage("assets/img/sin-mascota.png") : NetworkImage(mascota.foto),
                                  ),
                                )
                            ),
                          );
                        }
                    );

                  }

                },
              ),
            ),

            Divider(
              height: 2,
            ),
            SizedBox(
              height: G.margen,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.add_location_outlined,
                      size: 30.0,

                    ),
                  ),
                  Text("Mis direcciones",
                    style: TextStyle(
                      fontSize: G.texto16
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.assignment_outlined,
                      size: 30.0,

                    ),
                  ),
                  Text("Historial de pedidos",
                    style: TextStyle(
                        fontSize: G.texto16
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.account_circle_outlined,
                      size: 30.0,

                    ),
                  ),
                  Text("Mis datos",
                    style: TextStyle(
                        fontSize: G.texto16
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.support_agent_rounded,
                      size: 30.0,

                    ),
                  ),
                  Text("Ayuda",
                    style: TextStyle(
                        fontSize: G.texto16
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: G.margen,
            ),

            Stack(
              children : [
                Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[

                  GestureDetector(
                    behavior: HitTestBehavior.translucent,

                    onTap: (){
                      print("Entro en la card");
                      if (Platform.isIOS) {

                        return CupertinoAlertDialog(
                          title: Text("Quiere Salir De CameJob"),
                          content: Text("Estas seguro"),
                          actions: [
                            CupertinoDialogAction(

                                child: GestureDetector(
                                    onTap: (){
                                      Salir();

                                    },
                                    child: Text("Si")
                                )
                            ),
                            CupertinoDialogAction(
                                child: GestureDetector(
                                    onTap:(){
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("No")
                                )
                            ),
                          ],
                        );

                      } else {


                        return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Expanded(
                                      child: AlertDialog(

                                        title: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,

                                            children: [

                                              Flexible(child: Text("Cerrar sesión",
                                                style: TextStyle(
                                                    fontSize: G.texto18,
                                                    fontFamily: G.Bold
                                                ),
                                              ))
                                            ]
                                        ),
                                        content: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children: [
                                              Flexible(
                                                child: Text("¿Está seguro de querer cerrar la sesión?",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: G.texto15,

                                                  ),
                                                ),
                                              ),
                                            ]
                                        ),

                                        actions: <Widget>[

                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,

                                            children: [
                                              FlatButton(
                                                  onPressed: () {
                                                    Salir();

                                                  },
                                                  child: Text('Aceptar')
                                              ),


                                              Padding(
                                                padding: const EdgeInsets.only(right: 70.0, left: 20.0),
                                                child: FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('Cancelar')
                                                ),
                                              ),

                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                  ],

                                ),
                              );
                            });

                      }

                    },


                    child: Row(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 18, top: 15.0),
                            child: Icon(Icons.power_settings_new_rounded,
                              size: 37.0,


                            )
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 18, left: 10, top: 20.0),

                            height: 60.0,
                            child: Text("Cerrar sesión",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontFamily: "Roboto-Light",
                                fontSize: 25.0,
                              ),
                            )


                        ),


                      ],
                    ),
                  ),


                ],
              ),
              ]
            ),




          ],
        ),
      ),
    );
  }
}
