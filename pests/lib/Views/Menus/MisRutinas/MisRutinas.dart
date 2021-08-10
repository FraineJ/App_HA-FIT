import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as dbController;
import 'package:pests/UI/Base/DbIcon.dart';
import 'package:pests/Views/Menus/MisRutinas/onboarding.dart';



class MisRutinas extends StatefulWidget {

  @override
  _MisRutinasState createState() => _MisRutinasState();
}

class _MisRutinasState extends State<MisRutinas> {
  int navIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    dbController.listarMascotas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    Widget sinMascota(){
      return  Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        height:  MediaQuery.of(context).size.height,

        color: G.colorGrisFondo,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            C.SinMascota(texto: "Aun no  han registrado ninguna mascota", Icono: Icons.pets,)

          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: G.colorBlanco,
      body: StreamBuilder(
        stream: dbController.listarMascotas(),
        builder: (context, AsyncSnapshot<List<M.MascotaModel>> snapshot){

          List<M.MascotaModel> mascotaModel = snapshot.data;
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator());
          } else {
            print("lista de mis MisRutinas ${mascotaModel.length}");

            return mascotaModel.length == 0 ? sinMascota() : Column(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: (){
                    Navigator.push(context, C.TransFade(page: OnboardingScreen()));

                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: null,
                          icon: Icon(Icons.add_circle,
                            size: 70.0,
                          )
                      ) ,
                      SizedBox(
                        width: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Text("Agrega más MisRutinas",
                          style: TextStyle(
                            fontSize: G.texto18,
                            fontFamily: G.Bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: mascotaModel.length,
                      itemBuilder: (context, index){
                        final M.MascotaModel mascota = mascotaModel[index];
                        return   C.CartaMascotas(mascotaModel: mascota);
                      }
                  ),
                ),
              ],
            );

          }

        },
      )
    );
  }
}
