import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Views/Menus/Nutricion/Alimentos.dart';
import 'package:pests/Views/Menus/Nutricion/Dietas.dart';
import 'package:pests/Views/Menus/Nutricion/Suplementos.dart';
import 'package:pests/Views/Pages/Nutricion/cacular_macronitrientes.dart';

class Nutricion extends StatefulWidget {
  @override
  _NutricionState createState() => _NutricionState();
}

class _NutricionState extends State<Nutricion> {



  Widget cartaNutricion(String foto, String texto, String descripcion, Widget pagina) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (){
              Navigator.push(context,   C.TransFade( page: pagina ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CachedNetworkImage(


              imageBuilder: (context, imageProvider) => Container(
                width: double.infinity ,
                height: MediaQuery.of(context).size.height * 1/4 - 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft:  Radius.circular(15.0), topRight: Radius.circular(15.0) ),

                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,

                  ),
                ),
              ),

              imageUrl: foto,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Container(
              width: double.infinity ,
              height: MediaQuery.of(context).size.height * 1/4 - 120,

              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0) )
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(texto,
                        style: TextStyle(
                            fontSize: G.texto20,
                            fontFamily: G.Bold
                        ) ,
                      ),
                      SizedBox(
                        height: G.margen - 10.0,
                      ),
                      Text(descripcion,
                        maxLines: 3,
                      ),

                    ]

                ),
              ),

            )
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(

                  width: double.infinity,
                  height:  MediaQuery.of(context).size.height *1/4 ,

                  decoration: BoxDecoration(

                      gradient: LinearGradient(
                          colors: [
                            Color(0xFFFCCF31),
                            Color(0xFFF55555)
                          ],
                          begin: FractionalOffset(0.2, 0.0),
                          end: FractionalOffset(1.0, 0.6),
                          stops: [0.0, 0.8],
                          tileMode: TileMode.clamp
                      ),


                      shape: BoxShape.rectangle,
                      boxShadow: <BoxShadow>[
                        BoxShadow (
                            color:  Colors.black38,
                            blurRadius: 18.0,
                            offset: Offset(0.0, 0.0)
                        )
                      ]

                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 35.0),
                        child: Column(
                          children: [
                            Text("MACRONUTRIENTES",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color:G.colorBlanco,
                                  fontFamily: G.Bold
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset("assets/img/manzana.svg",
                                          width:  40,
                                            height: 40,
                                          ),
                                          Center(
                                            child: Text("1580 Kcal",
                                              style: TextStyle(
                                                  fontSize: 18.0,
                                                  color:G.colorBlanco,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("Cantidad de calorías ",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color:G.colorBlanco,
                                        ),
                                      ),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset("assets/img/actividad.svg",
                                            width:  40,
                                            height: 40,
                                          ),
                                          Text("213  Kcal",
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color:G.colorBlanco,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text("Tu nivel de actividad física",
                                        style: TextStyle(
                                          fontSize: 12.0,
                                          color:G.colorBlanco,
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Text("156 kcal Tu nivel de actividad física",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color:G.colorBlanco,

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                cartaNutricion( "https://adfisioterapiavalencia.com/wp-content/uploads/2020/07/nutricion-deportiva.jpg", "Dietas", "Los mejores consejos de nutricion",  Dietas()),
                cartaNutricion( "https://www.tododisca.com/wp-content/uploads/2019/12/D%C3%ADa-Nacional-de-la-Nutrici%C3%B3n.jpg", "Alimentos", "Alimentos Saludadbles", Alimentos()),
                cartaNutricion( "https://918230.smushcdn.com/2283449/wp-content/uploads/2020/09/suplementos-alimenticios.jpeg?lossy=1&strip=1&webp=1", "Suplementos", "Los suplementos que necesitas para consegiìr los mejores resultados", Suplementos() ),



              ],
            ),
            Positioned(
              top:  MediaQuery.of(context).size.height *1/4 - 30,
              left: MediaQuery.of(context).size.width / 2 - 65,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                  onPressed: (){
                    Navigator.push(context, C.TransFade(page: Macronutrientes()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("CALCULAR"),
                  ),
                )
            )
          ]
        ),
      ),
    );
  }
}
