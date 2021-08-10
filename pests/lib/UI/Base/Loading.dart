
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import 'package:pests/Data/Globals/All.dart' as G;


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}




class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return OfflineBuilder( connectivityBuilder: (BuildContext context, ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              children: [
                child,
                Positioned(

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),

                    child: connected ? Visibility(
                      child: Container(
                        color: Color(0xFF00EE44),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Conectado",
                              style: TextStyle(color: Colors.white),
                            ),

                          ],
                        ),
                      ),
                      visible: false,
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Center(
                          child: Container(
                            width: G.ancho ,
                            height: G.alto ,
                            decoration: BoxDecoration(
                                color: G.colorBlanco,

                                borderRadius: BorderRadius.circular(20.0)
                            ),
                            
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[

                                Icon(Icons.wifi_off_rounded,
                                size: 80.0,
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Text(
                                  "Sin conexion a internet",
                                  style: TextStyle(
                                      color: G.colorGrisOscuro,
                                      fontSize: G.texto20,
                                      fontWeight: FontWeight.w700

                                  ),
                                ),
                                SizedBox(
                                  width: 58.0,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: 300,
                                    maxHeight: 60.0

                                  ),
                                  child: Center(
                                    child: Text(
                                      "Por favor revisa tu conexión a internet e\n intenta de nuevo.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600

                                      ),
                                    ),
                                  ),
                                ),

                                ElevatedButton(
                                  onPressed: (){

                                  },

                                  child:  Text("Reintentar"

                                  )
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
           child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    height: 15.0,
                  ),
                  SpinKitCircle(
                    color: Colors.pink,
                    size: 50.0,
                  ),
                ],
              ),
          ));

        },
      )
    );
  }
}
