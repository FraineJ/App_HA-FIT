import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pests/Data/dbController.dart';

import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Globals/All.dart' as G;



class BuscadorRaza extends SearchDelegate<String>{

  FirebaseFirestore db = FirebaseFirestore.instance;

  final ListaDatos = [];


  final RaazaRecientes = [
    "dálmata",
    "pastor  aleman"
  ];




  @override
  List<Widget> buildActions(BuildContext context) {
    return [

       IconButton(
          icon: Icon(
              Icons.clear
          ),
          onPressed: (){
             query = '';
          }
       )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {

    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_outlined
      ),
      onPressed: (){
        close(context, null);
      }
   );
  }

  @override
  Widget buildResults(BuildContext context) {

    Future.delayed(Duration.zero, () {
      close(context, query);
    });
    return Container();


  }

  @override
  Widget buildSuggestions(BuildContext context) {


    return StreamBuilder(
      stream: BuscarZara(),
      builder: (context , AsyncSnapshot<List<M.RazaModel>> snapshot){
        if(snapshot.hasData){
          List<M.RazaModel> RazaModel = snapshot.data;

            if(ListaDatos.length <= 0){
              for(int i = 0; i < RazaModel.length; i++){
              final M.RazaModel razaModel = RazaModel[i];
              ListaDatos.add(razaModel.nombre.toString().toLowerCase());

              }
            }

          final sugeridas = query.isEmpty ? RaazaRecientes : ListaDatos.where((element) => element.startsWith(this.query)).toList();

          return ListView.builder(

            itemBuilder: (context, index) =>

                ListTile(
                  onTap: (){
                    query = sugeridas[index];
                    showResults(context);
                  },
                  leading: Icon( query.isEmpty ?  Icons.history : Icons.search_rounded ,
                  size: 30.0,
                  ),
                  title: RichText(
                    text: TextSpan(text: sugeridas[index].substring(0, query.length),
                      style: TextStyle(
                        color:  Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: G.texto19
                      ),
                      children: [
                        TextSpan(
                          text: sugeridas[index].substring(query.length),
                          style: TextStyle(
                              color:  Colors.grey,
                          ),
                        )
                      ]
                    ),

                  ),
                ),
            itemCount: sugeridas.length,


          );


        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    );

  }



}