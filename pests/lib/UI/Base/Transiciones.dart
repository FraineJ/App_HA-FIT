import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


Route<Object> TransFade ( { final Widget page }  ) {

  if( Platform.isIOS ){
    return MaterialPageRoute(builder: (context) => page);
  }else{
    return MaterialPageRoute(builder: (context) => page);
   // return Navigator.push(context, MaterialPageRoute(builder: (context) => page),

  }

}
