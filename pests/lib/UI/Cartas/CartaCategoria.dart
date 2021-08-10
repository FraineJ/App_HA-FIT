import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Views/Pages/Categoria/Seleccionar_Categoria.dart';



class CartaCategoria extends StatelessWidget {
  final M.CategoriaModel  categoriaModel;

  CartaCategoria({this.categoriaModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        Navigator.push(context, C.TransFade(page: SeleccionarCategoria(id:  categoriaModel.id,)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 8.0),
        child: Container(
          height: MediaQuery.of(context).size.height * 1/4 ,
          width: MediaQuery.of(context).size.width /2  - 20,

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

                  width: MediaQuery.of(context).size.width /2 ,
                  height: 90,

                  child:


                  CachedNetworkImage(

                    imageBuilder: (context, imageProvider) => Container(
                      width: double.infinity ,
                      height: MediaQuery.of(context).size.height * 1/4 ,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft:  Radius.circular(5.0), topRight: Radius.circular(5.0) ),

                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,

                        ),
                      ),
                    ),

                    imageUrl: categoriaModel.foto,
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
              Text(categoriaModel.nombre)
            ],
          ),
        ),
      ),
    );
  }

}
