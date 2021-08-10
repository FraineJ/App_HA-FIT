import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/UI/All.dart' as C;

class SeguroVida extends StatefulWidget {
  @override
  _SeguroVidaState createState() => _SeguroVidaState();
}

class _SeguroVidaState extends State<SeguroVida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: G.colorGrisFondo,
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: double.infinity,
        color: G.colorGrisFondo,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ignore: deprecated_member_use
            

            Text( 'Seguro de vida',
              style: TextStyle(
                  fontSize: 22.0,
                  fontFamily: G.Bold
              ),
            ),
          ],
        ),
      ),
    );
  }
}
