import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/Views/Pages/Tips/TipsDetalle.dart';

class HomeTips extends StatefulWidget {

  @override
  _HomeTipsState createState() => _HomeTipsState();
}

class _HomeTipsState extends State<HomeTips> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<M.TipsModel>> obtenerTips()   {
    return _db.collection('tips').snapshots().map(M.TipsModel.toTipsList);

  }

  @override
  void initState() {
    // TODO: implement initState
    obtenerTips();
    super.initState();
  }

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

        title: Text("Tips",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 20.0,
            color: G.colorNegro,
            fontFamily:  G.Light,

          ),
        ),
      ),
      body: StreamBuilder(
          stream: obtenerTips(),
          builder: (context, AsyncSnapshot<List<M.TipsModel>> snapshot){

            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(
                child: C.SkeletonCircular(),
              );
            }else{

              List<M.TipsModel> Tips = snapshot.data;


              return ListView.builder(

                itemCount: Tips.length,
                itemBuilder: (context, index){
                  final M.TipsModel tipsModel = Tips[index];
                  return  GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 350),
                          pageBuilder: (_, animation1, animation2){
                            return SlideTransition(
                                position:  Tween<Offset>(
                                  begin: Offset(1.0, 0.0),
                                  end:  Offset(0.0, 0.0),
                                ).animate(animation1),

                                child: TipsDetalle(tipsModel: tipsModel )

                            );}
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
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

                            imageUrl: tipsModel.foto,
                            placeholder: (context, url) => CircularProgressIndicator(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                          Container(
                            width: double.infinity ,
                            height: MediaQuery.of(context).size.height * 1/4 - 80,

                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0) )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(tipsModel.titulo,
                                      style: TextStyle(
                                          fontSize: G.texto20,
                                          fontFamily: G.Bold
                                      ) ,
                                    ),
                                    SizedBox(
                                      height: G.margen - 10.0,
                                    ),
                                    Text(tipsModel.descripcion,
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
                },
              );

            }

          }

      ),




    );
  }
}
