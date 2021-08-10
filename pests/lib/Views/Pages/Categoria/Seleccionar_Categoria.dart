import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as CO;

class SeleccionarCategoria extends StatelessWidget {
  String id ;
  SeleccionarCategoria({ this.id }) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor:  G.colorAmarillo,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black, //Color verde
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: Text("",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            color: G.colorNegro,
            fontFamily:  G.Light,

          ),
        ),
      ),
      body: FutureBuilder(
          future: CO.BuscarSubCategorias(id),
          builder: (context,  snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else{

            //  List<M.PublicacionProducto> Publicaciones = snapshot.data;

              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index){
                  //final M.PublicacionProducto publicacione = Publicaciones[index];
                  return Column(
                    children: [
                      Container(child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(snapshot.data.docs[index]['nombre']),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        ),
                      )),
                      Divider(
                        height: 2,
                      )
                    ],
                  );
                },
              );

            }

          }

      )
    );
  }
}
