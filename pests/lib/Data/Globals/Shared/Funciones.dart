import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:pests/Data/Globals/All.dart';


import '../All.dart';

void cambiarEstadoBarras( modoOscuro ){

  if( Platform.isIOS ){

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorBlanco,
      statusBarBrightness: modoOscuro ? Brightness.dark : Brightness.light,
      statusBarIconBrightness: modoOscuro ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness: modoOscuro ? Brightness.dark : Brightness.light,
    ));

  }else{

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorBlanco,
      statusBarBrightness: modoOscuro ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: modoOscuro ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: colorBlanco,
      systemNavigationBarIconBrightness: modoOscuro ? Brightness.light : Brightness.dark,

    ));
  }
}


void calcularDatos( context ) {

  alto = MediaQuery.of(context).size.height;
  ancho = MediaQuery.of(context).size.width;
  altoStatusBar = MediaQuery.of(context).padding.top;

  margenLateral = ancho * 0.05;

  margenMini = alto * 0.01;
  margen = alto * 0.02;
  margen1 = alto * 0.025;
  margen2 = alto * 0.030;
  margen3 = alto * 0.035;
  margen4 = alto * 0.040;
  margen5 = alto * 0.045;
  margen6 = alto * 0.05;

  texto = ancho / 100;

  textoTitulo = texto * 7;
  textoIcono = texto * 6;
  texto24 = texto * 7.5;
  texto23 = texto * 6.5;
  texto22 = texto * 5.5;
  texto21 = texto * 5.25;
  texto20 = texto * 5;
  texto19 = texto * 4.85;
  texto18 = texto * 4.5;
  texto17 = texto * 4.3;
  texto16 = texto * 4;
  texto15 = texto * 3.8;
  texto14 = texto * 3.5;
  texto13 = texto * 3.3;
  texto12 = texto * 3;
  texto11 = texto * 2.8;
  texto10 = texto * 2.5;

}



class TimeAgo{
  static String timeAgoSinceDate(String dateString, {bool numericDates = true}) {

    DateTime notificationDate = DateFormat("yyyy-MM-dd h:mm").parse(dateString);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    print("Ver formato de la fecha ${date2}");
    print("Ver formato de la fecha de registro ${dateString}");

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? 'Hace 1 semana' : 'La semana pasada';
    } else if (difference.inDays >= 2) {
      return ' Hace ${difference.inDays}  días';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? 'Hace 1 día' : 'Ayer';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} Horas atras';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 Hora antes' : 'Hace una hora';
    } else if (difference.inMinutes >= 2) {
      return 'Hace ${difference.inMinutes} minutos';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? 'Hace 1 minutos' : 'Hace un minuto';
    } else if (difference.inSeconds >= 3) {
      return 'Hace ${difference.inSeconds}  segundos';
    } else {
      return 'Justo ahora';
    }
  }

}



class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale}) : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.second);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(currentTime.year, currentTime.month, currentTime.day,
        this.currentLeftIndex(), this.currentMiddleIndex(), this.currentRightIndex())
        : DateTime(currentTime.year, currentTime.month, currentTime.day, this.currentLeftIndex(),
        this.currentMiddleIndex(), this.currentRightIndex());
  }
}
