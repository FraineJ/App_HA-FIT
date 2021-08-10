import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

import "package:pests/Data/Models/All.dart" as M;
import "package:pests/Data/Globals/All.dart" as G;
import "package:pests/UI/All.dart" as C;
import 'package:pests/Views/Menus/MisRutinas/MisRutinasDetalle.dart';

class CartaMascotas extends StatelessWidget {

  final M.MascotaModel mascotaModel ;

  const CartaMascotas({this.mascotaModel});
//context, C.TransFade(page: MascotaDetalle( mascotaModel: mascotaModel
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 350),
            pageBuilder: (_, animation1, animation2){
              return SlideTransition(
                  position:  Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end:  Offset(0.0, 0.0),
                ).animate(animation1),

                child: MisRutinasDetalle( mascotaModel: mascotaModel)

              );}
            ));

      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: G.ancho,
          height: G.alto * 1/4 - 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: G.colorBlanco,
            boxShadow: [
              BoxShadow(

                spreadRadius: 3,
                color: G.colorGris.withOpacity(0.6),
                offset: new Offset(0.0, 2.0),
                blurRadius: 10.0,
              ),
            ],
          ) ,
          child: Row(
            children: [
              Container(
                width: G.ancho / 2 - 50,
                height: G.alto * 1/4 - 80,

                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(10.0), topRight:Radius.circular(20.0), bottomRight: Radius.circular(00.0)),
                   image: DecorationImage(
                     fit: BoxFit.cover,
                     image: mascotaModel.foto == "" || mascotaModel.foto == null ? AssetImage("assets/img/sin-mascota.png") :  NetworkImage(mascotaModel.foto)
                   )
                 ),

              ),
              Container(
                padding: EdgeInsets.all(12.0),
                width: G.ancho / 2 + 20,
                height: G.alto * 1/4 + 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(mascotaModel.nombre,
                          style: TextStyle(
                            fontSize: G.texto19,
                            fontFamily: G.Bold
                          ),

                        ),
                        mascotaModel.genero == "Macho" ? Icon( Icons.male,
                          color: Colors.blue,
                          size: 25.0,

                        ) :
                        Icon( Icons.female,
                          color: Colors.pinkAccent,
                          size: 25.0,

                        )

                      ],
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(mascotaModel.raza,

                        style: TextStyle(
                            fontSize: G.texto17,
                            fontFamily: G.Regular
                        )
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text("15 Años y 12 meses",

                        style: TextStyle(
                            fontSize: G.texto15,
                            fontFamily: G.Regular
                        )
                    ),
                  ],
                ),


              )

            ],
          ),
        ),
      ),
    );
  }
}
