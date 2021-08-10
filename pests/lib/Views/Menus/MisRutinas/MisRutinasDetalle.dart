import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/dbController.dart' as dbController;
import 'package:toast/toast.dart';


class MisRutinasDetalle extends StatefulWidget {

  final M.MascotaModel mascotaModel ;

  const MisRutinasDetalle({this.mascotaModel});
  @override
  _MisRutinasDetalleState createState() => _MisRutinasDetalleState();
}

class _MisRutinasDetalleState extends State<MisRutinasDetalle> {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<M.CategoriaModel>> obtenerCategoria()   {
    return _db.collection('categoria').snapshots().map(M.CategoriaModel.toCategoriasList);

  }

  Stream<List<M.PublicacionProducto>> obtenerProductos()   {
    return _db.collection('publicaciones').snapshots().map(M.PublicacionProducto.toPublicacionesList);

  }



  @override
  void initState() {
    // TODO: implement initState
    obtenerProductos();
    obtenerCategoria();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    void showAlertDialog(BuildContext context) {

      showDialog(
          context: context,
          builder: (context) =>  CupertinoAlertDialog(
            title: Text("Eilimar Macota"),
            content: Text( "Estas seguro que deseass eliminar a esta mascota"),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancelar")
              ),
              CupertinoDialogAction(
                 // textStyle: TextStyle(color: Colors.red),
                  isDefaultAction: true,
                  onPressed: ()  {

                    dbController.Elimar("mascota", widget.mascotaModel.id).whenComplete(() {
                      Navigator.pop(context);
                      Toast.show(
                          "Mascota Eliminada",
                          context,
                          duration: Toast.LENGTH_LONG,
                          gravity: Toast.BOTTOM,
                          backgroundColor:
                          Colors.grey[800],
                          textColor: Colors.white
                      );
                      Navigator.pop(context);

                    });

                  },
                  child: Text("Aceptar")
              ),
            ],
          ));
    }


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children : [
                Container(
                  width: G.ancho,
                  height: G.alto * 1/3 + 50.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), bottomLeft: Radius.circular(40.0), topRight:Radius.circular(20.0), bottomRight: Radius.circular(00.0)),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: widget.mascotaModel.foto == "" || widget.mascotaModel.foto == null ? AssetImage("assets/img/sin-mascota.png") :  NetworkImage(widget.mascotaModel.foto)
                      )
                  ),
                ),
                Positioned(
                  top: 40.0,
                  left: 20.0,
                  child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: G.colorGris,
                      ),

                      child: new RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.blue,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                  ),
                ),

                Positioned(
                  top: G.alto * 1/3 ,
                  left: G.ancho - 60,
                  child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: G.colorGris,
                      ),

                      child: new RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        child: Icon(
                          Icons.edit,
                          color: Colors.blue,
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                  ),
                ),

                Positioned(
                  top: G.alto * 1/3 ,
                  left: G.ancho - 105,
                  child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: G.colorGris,
                      ),

                      child: new RawMaterialButton(
                        shape: new CircleBorder(),
                        elevation: 0.0,
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: (){
                          showAlertDialog(context);
                        },
                      )
                  ),
                )
              ]
            ),
            SizedBox(
              height: G.margen2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Row(
                children: [

                  Text(widget.mascotaModel.nombre,
                    style: TextStyle(
                        fontSize: 30.0,
                        fontFamily: G.Bold
                    ),

                  ),
                  SizedBox(
                    width: G.margen3,
                  ),
                  widget.mascotaModel.genero == "Macho" ? Icon( Icons.male,
                    color: Colors.blue,
                    size: 25.0,

                  ) :
                  Icon( Icons.female,
                    color: Colors.pinkAccent,
                    size: 25.0,

                  )

                ],
              ),
            ),
            SizedBox(
              height: G.margen2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: G.ancho * 1/4,
                  height: 75.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: widget.mascotaModel.genero == "Macho" ? Colors.blue :  Colors.pinkAccent
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.mascotaModel.raza,
                          style: TextStyle(
                            fontFamily: G.Bold,
                            color: G.colorBlanco,
                            fontSize: G.texto16
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Divider(
                            height: 10.0,
                            color:   G.colorGris,
                          ),
                        ),
                        Text("Raza",
                          style: TextStyle(
                              color: G.colorGris
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                Container(
                  width: G.ancho * 1/4,
                  height: 75.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: widget.mascotaModel.genero == "Macho" ? Colors.blue :  Colors.pinkAccent
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Center(child: Text("6 Meses",
                        style: TextStyle(
                            fontFamily: G.Bold,
                            color: G.colorBlanco,
                            fontSize: G.texto16
                        ),
                      )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          height: 10.0,
                          color:   G.colorGris,
                        ),
                      ),
                      Text("Edad",
                        style: TextStyle(
                            color: G.colorGris
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  width: G.ancho * 1/4,
                  height: 75.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: widget.mascotaModel.genero == "Macho" ? Colors.blue :  Colors.pinkAccent
                  ),
                  child:    Column(
                    children: [
                      widget.mascotaModel.genero == "Macho" ? Icon( Icons.male,
                        color: G.colorBlanco,
                        size: 30.0,

                      ):
                      Icon( Icons.female,
                        color: G.colorBlanco,
                        size: 30.0,

                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Divider(
                          height: 10.0,
                          color:   G.colorGris,
                        ),
                      ),
                      Text("Sexo",
                        style: TextStyle(
                          color: G.colorGris
                        ),
                      )

                    ],
                  )

                ),


              ],
            ),
            SizedBox(
              height: G.margen2,
            ),
            Padding(
              padding: const EdgeInsets.only( left: 15.0, bottom: 15.0),
              child: Text("Consejos",
                style: TextStyle(
                    fontSize: G.texto15,
                    fontFamily: G.Bold
                ),
              ),
            ),
            Container(
                height: 140.0,
                margin: EdgeInsets.only( left: 15.0, right: 15.0, bottom: 15.0),
                decoration: BoxDecoration(

                    shape: BoxShape.rectangle,
                    color: G.colorGrisFondo,
                    borderRadius: BorderRadius.circular(10),

                    image: DecorationImage(

                      image: AssetImage("assets/img/slider1.jpg"),
                      fit: BoxFit.cover,

                    )

                )
            ),
            Padding(
              padding: const EdgeInsets.only( left: 15.0),
              child: Text("Productos Recomendados",
                style: TextStyle(
                  fontSize: G.texto15,
                  fontFamily: G.Bold
                ),
              ),
            ),
            Container(
              height: 140.0,
              child: StreamBuilder(
                  stream: obtenerProductos(),
                  builder: (context, AsyncSnapshot<List<M.PublicacionProducto>> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{

                      List<M.PublicacionProducto> Publicaciones = snapshot.data;

                      return ListView.builder(
                        scrollDirection: Axis.horizontal,

                        itemCount: Publicaciones.length,
                        itemBuilder: (context, index){
                          final M.PublicacionProducto publicacione = Publicaciones[index];
                          return Center(
                            child: C.CartaPublicaciones(producto: publicacione),
                          );
                        },
                      );

                    }

                  }

              )
            ),


          ],
        ),
      ),
    );
  }
}
