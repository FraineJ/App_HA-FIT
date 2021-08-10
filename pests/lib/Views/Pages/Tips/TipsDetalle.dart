import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Models/All.dart' as M;

class TipsDetalle extends StatelessWidget {

  final M.TipsModel tipsModel ;

  TipsDetalle({this.tipsModel});

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

          title: Text("Tips Detalle",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20.0,
              color: G.colorNegro,
              fontFamily:  G.Light,

            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(


                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity ,
                  height: MediaQuery.of(context).size.height * 1/4 - 20,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,

                    ),
                  ),
                ),

                imageUrl: tipsModel.foto,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              SizedBox(
                height: G.margen,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(tipsModel.titulo,
                  style: TextStyle(
                      fontSize: G.texto20,
                      fontFamily: G.Bold
                  ) ,
                ),
              ),
              SizedBox(
                height: G.margen,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Text(tipsModel.descripcion,

                ),
              ),

            ],


          ),
        )

    );
  }
}
