import 'package:flutter/material.dart';

import 'package:pests/Data/Globals/All.dart' as G;

class SkeletonCircular extends StatefulWidget {
  @override
  _SkeletonCircularState createState() => _SkeletonCircularState();
}

class _SkeletonCircularState extends State<SkeletonCircular> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: G.colorGrisSemi,
      ),
    );
  }
}



class SkeletonBarra extends StatefulWidget {
  @override
  _SkeletonBarraState createState() => _SkeletonBarraState();
}

class _SkeletonBarraState extends State<SkeletonBarra> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(

        height: 20.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: G.colorGrisSemi,
        ),
      ),
    );
  }
}

