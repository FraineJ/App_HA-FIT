
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:pests/Data/Models/All.dart' as M;
import 'package:pests/Data/Globals/All.dart' as G;
import 'package:pests/UI/All.dart' as C;

import 'package:pests/Data/Models/Usuario/UsuarioModel.dart';


enum AuthStatus{
  Uninitialized,
  Authenticated,
  Authenticating,
  Unauthenticated
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth;
  GoogleSignInAccount _googleUser;
  M.UsuarioModel _user = new UsuarioModel();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  AuthStatus _status = AuthStatus.Uninitialized;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthService.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> _onAuthStateChanged(User firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.Unauthenticated;
    } else {
      DocumentSnapshot userSnap = await _db
          .collection('usuario')
          .doc(firebaseUser.uid)
          .get();

      _user.setFromFireStore(userSnap);
      _status = AuthStatus.Authenticated;
    }

    notifyListeners();
  }

  Future<User> googleSignIn() async {
    _status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      this._googleUser = googleUser;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User user = authResult.user;
      await updateUserData;
    } catch (e) {
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return null;
    }
  }


  Widget showMensage(titulo, mensage, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(titulo),
            content: Flexible(
              child: Text(mensage,
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ),
            actions: <Widget>[
              Center(
                child: FlatButton(
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
                    child: Text('Aceptar')),
              ),
            ],
          );
        }
    );
  }

  Future<bool> LoginEmail(String correo, String clave, BuildContext context) async{
    bool _isLoading = false;
    String _uid, _correo;
    _status = AuthStatus.Authenticating;
    notifyListeners();
    try{
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(  email: correo.replaceAll(" ", ""), password: clave.replaceAll(" ", ""));

      if(userCredential != null ){
        _uid = userCredential.user.uid;
        _correo = userCredential.user.email;

        return _isLoading =  true;

      }


    }catch (e){

      print("mensaje de firebase erro ñogin ${e} ");
      if (e.toString().contains("The user may have been deleted")) {

        showMensage("Usuario no encontrado  " , "Este usuario no se encuentra registrado en el  sistema", context);
      }else if(e.toString().contains("A network error (such as timeout, interrupted connection or unreachable host) has occurred")){
        showMensage("Sin conexión " , "Por favor verifique su conexión a internet", context);

      }else if(e.toString().contains("The password is invalid or the user does not have a password")){
        showMensage("Contraseña invalida " ,  " La contraseña que ingresaste es incorrecta vuelve a intentarlo.", context);

      }
      _status = AuthStatus.Uninitialized;
      notifyListeners();
      return e;

    }

    return _isLoading;

  }

  Future<DocumentSnapshot> updateUserData(User user) async {
    DocumentReference userRef = _db
        .collection('users')
        .doc(user.uid);

    userRef.set({
      'uid': user.uid,
      'email': user.email,
      'lastSign': DateTime.now(),
      'photoURL': user.photoURL,
      'displayName': user.displayName,
    });

    DocumentSnapshot userData = await userRef.get();

    return userData;
  }

  void signOut() {
    _auth.signOut();
    _status = AuthStatus.Unauthenticated;
    notifyListeners();
  }

  AuthStatus get status => _status;
  M.UsuarioModel get user => _user;
  GoogleSignInAccount get googleUser => _googleUser;



}