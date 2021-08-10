
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class UsuarioModel with ChangeNotifier {

  String id;
  String displayName;
  String photoURL;
  String email;

  UsuarioModel({
    this.id,
    this.displayName,
    this.photoURL,
    this.email,
  });

  factory UsuarioModel.fromFirestore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data();
    return UsuarioModel(
      id: userDoc.id,
      displayName: userData['displayName'],
      photoURL: userData['photoURL'],
      email: userData['email'],
    );
  }

  void setFromFireStore(DocumentSnapshot userDoc) {
    Map userData = userDoc.data();
    this.id = userDoc.id;
    //this.displayName = userData['displayName'];
    //this.photoURL = userData['photoURL'];
    //this.email = userData['email'];
    notifyListeners();
  }





}




