import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pests/Views/Pages/All.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;



class MenuInferior extends StatefulWidget {
  @override
  _MenuInferiorState createState() => _MenuInferiorState();
}

class _MenuInferiorState extends State<MenuInferior> {

  int currenTab = 0;
 // final List<Widget> screens = [Inicio(), Programaciones(), ProductoDetalle(), Usuario()];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = Inicio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 60,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(

                onPressed: () {
                  setState(
                        () {
                      currentScreen = Inicio();
                      currenTab = 0;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon (

                      currenTab == 0 ? Icons.home_rounded :  Icons.home_outlined ,
                      color: currenTab == 0 ? Colors.black : Colors.grey,
                      size: 29.0,

                    ),
                    Text(
                      'Inicio',
                      style: TextStyle(
                        color: currenTab == 0 ? Colors.black : Colors.grey,
                        fontFamily: G.Light,
                        fontWeight: FontWeight.w600,


                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(
                        () {
                      currentScreen = Programaciones();
                      currenTab = 1;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(

                      currenTab == 1 ?  Icons.assignment :Icons.assignment_outlined  ,
                      color: currenTab == 1 ? Colors.black : Colors.grey,
                    ),
                    Text(
                      'Agenda',
                      style: TextStyle(
                        color: currenTab == 1 ? Colors.black : Colors.grey,
                        fontFamily: G.Light,
                        fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(
                        () {
                      currentScreen = ProductoDetalle();
                      currenTab = 2;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      currenTab == 2 ?  Icons.shopping_bag :  Icons.shopping_bag_outlined   ,
                      color: currenTab == 2 ? Colors.black : Colors.grey,
                    ),
                    Text(
                      'Tienda',
                      style: TextStyle(
                        color: currenTab == 2 ? Colors.black : Colors.grey,
                          fontFamily: G.Light,
                          fontWeight: FontWeight.w600
                      ),
                    )
                  ],
                ),
              ),
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(
                        () {
                      //currentScreen = Usuario();
                      currenTab = 3;
                    },
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      currenTab == 3 ?   Icons.account_circle : Icons.account_circle_outlined ,
                      color: currenTab == 3 ? Colors.black : Colors.grey,
                    ),
                    Text(
                      'Mi cuenta',
                      style: TextStyle(
                        color: currenTab == 3 ? Colors.black : Colors.grey,
                        fontFamily: G.Light,
                          fontWeight: FontWeight.w600
                      ),
                    )
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
