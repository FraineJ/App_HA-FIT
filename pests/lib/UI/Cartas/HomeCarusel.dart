import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;

class HomeCarusel extends StatefulWidget {
  @override
  _HomeCaruselState createState() => _HomeCaruselState();
}

class _HomeCaruselState extends State<HomeCarusel> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  int _index = 0;
  int _datalength = 1;

  Future obtenerImagenes() async {

    QuerySnapshot snapshot = await _db.collection('anuncio').get();

    setState(() {
      _datalength = snapshot.docs.length;
    });

    return snapshot.docs;
  }

  @override
  void initState() {
    // TODO: implement initState
    obtenerImagenes();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future:  obtenerImagenes(),
        builder: ( context, snapshot){
          return snapshot.data == null ? Container(
            width: MediaQuery.of(context).size.width ,
            height: MediaQuery.of(context).size.height * 1/4 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 280,
                  height: 30.0,

                  decoration: BoxDecoration(color :G.colorGrisSemi,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 180,
                  height: 30.0,
                  decoration: BoxDecoration(
                      color :G.colorGrisSemi,
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
              ],
            ),
          ) :  CarouselSlider.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index, int select){
                DocumentSnapshot sliderImagen = snapshot.data[index];

                return  GestureDetector(
                  onTap: (){


                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1/4 - 10,


                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: sliderImagen["foto"] == null ? "https://firebasestorage.googleapis.com/v0/b/pestdb-42d5f.appspot.com/o/img_anuncio%2Ferror-2129569_1280.jpg?alt=media&token=91e6e061-ef92-40f7-adf7-8666da09188b" : sliderImagen["foto"],
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Container(
                            width: MediaQuery.of(context).size.width ,
                            height: MediaQuery.of(context).size.height * 1/4  + 15 ,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 280,
                                  height: 30.0,

                                  decoration: BoxDecoration(color :G.colorGrisSemi,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  width: 180,
                                  height: 30.0,
                                  decoration: BoxDecoration(
                                      color :G.colorGrisSemi,
                                      borderRadius: BorderRadius.circular(10.0)
                                  ),
                                ),
                              ],
                            ),
                          ) ,
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 1/4 + 80,
                  aspectRatio: 16/9,
                  viewportFraction: 1,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  //enlargeCenterPage: true,

                  scrollDirection: Axis.horizontal,
                  onPageChanged: null
              ),
          );
        },
      ),

    );
  }
}
