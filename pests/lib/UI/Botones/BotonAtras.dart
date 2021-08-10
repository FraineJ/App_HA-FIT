import 'package:flutter/material.dart';
import 'package:pests/Data/Globals/All.dart' as G;


class BotonAtras extends StatefulWidget {
  @override
  _BotonAtrasState createState() => _BotonAtrasState();
}

class _BotonAtrasState extends State<BotonAtras> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: G.colorGrisFondo.withOpacity(0.5),
        borderRadius: BorderRadius.circular(30)
      ),
      
      child: Center(
        child: IconButton(icon: Icon(Icons.arrow_back_ios),

            onPressed: (){
              FocusScope.of(context).requestFocus(new FocusNode());
              //FocusScope.of(context).unfocus();
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (currentFocus.hasPrimaryFocus == false) {
                currentFocus.unfocus();
                Navigator.pop(context);
              }else {

                Navigator.pop(context);
              }


            }),
      )

    );
  }
}
