import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pests/Views/Home/Home.dart';
import 'package:pests/Views/Login/Login.dart';
import 'package:pests/Views/Login/splash_screen.dart';
import 'package:provider/provider.dart';

import 'package:pests/UI/All.dart' as C;
import 'package:pests/Data/Globals/All.dart' as G;


import 'package:pests/Data/Providers/All.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiProvider (


       providers: [
         ChangeNotifierProvider(  create: (_) => CargarPublicaciones()),
         ChangeNotifierProvider(  create: (_) => AuthService.instance(),),
       ],




       child:  MaterialApp(
        color: Colors.white,

        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        debugShowCheckedModeBanner: false,
        title: 'Sasha',

        home: App(),

        supportedLocales: [
          const Locale('en', 'US'), // English
          const Locale('es', '' ), // Español
        ],

      )
    );
  }
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}


class _AppState extends State<App> {


  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((_) => G.calcularDatos(context) );


    return Consumer(
      builder: (context, AuthService authService, _) {
        switch (authService.status) {
          case AuthStatus.Uninitialized:
            return C.Loading();
          case AuthStatus.Authenticated:
            return Home();
          case AuthStatus.Authenticating:
            return Login();
          case AuthStatus.Unauthenticated:
            return Login();
        }
        return null;
      },
    );

  }

}





