import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pests/UI/Base/DbIcon.dart';



class Sidenav extends StatelessWidget {

  final Function setIndex;
  final int selectedIndex;

  Sidenav(this.selectedIndex, this.setIndex );
  FirebaseAuth auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {


    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Frainer Simarra Aguilar"),
            accountEmail: Text("frainer201@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset("assets/img/Banner.jpg",
                  width: 90.0,
                  height: 90.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),






          _navItem(context, Icons.home_outlined, 'Inicio',
              onTap: () { _navItemClicked(context, 0); },
              selected: selectedIndex == 0
          ),


          _navItem(context, Icons.settings_backup_restore_outlined, 'Rutinas',
              suffix: Text('0',style: TextStyle(fontWeight: FontWeight.w500),),
              onTap: () { _navItemClicked(context, 1); },
              selected: selectedIndex == 1
          ),

          _navItem(context, Icons.fastfood_outlined, 'Nutrición',
              onTap: () { _navItemClicked(context, 2); },
              selected: selectedIndex == 2
          ),

          _navItem(context, Icons.shopping_bag_outlined, 'Mis compras',
              onTap: () { _navItemClicked(context, 3); },
              selected: selectedIndex == 3
          ),

          _navItem(context, Icons.favorite_border_sharp, 'Favoritos',
              onTap: () { _navItemClicked(context, 4); },
              selected: selectedIndex == 4
          ),

          _navItem(context, Icons.notifications_none_rounded, 'Notificaciones',
              suffix: Text('0',style: TextStyle(fontWeight: FontWeight.w500),),
              onTap: () { _navItemClicked(context, 5); },
              selected: selectedIndex == 5
          ),


          _navItem(context, Icons.account_circle_outlined, 'Mi cuenta',
              onTap: () { _navItemClicked(context, 6); },
              selected: selectedIndex == 6
          ),

          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('CONFIGURACIONES', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey.shade700, letterSpacing: 1)),
          ),

          _navItem(context, Icons.info_outline_rounded, "Ayuda / PQR",
              onTap: () { _navItemClicked(context, 6); },
              selected: selectedIndex == 6
          ),

          _navItem(context, null, "Acerca de HA Fit",
              onTap: () { _navItemClicked(context, 6); },
              selected: selectedIndex == 6
          ),

          _navItem(context, Icons.storefront, "Quiero ser aliado",
              onTap: () { _navItemClicked(context, 6); },
              selected: selectedIndex == 6
          ),





        ],
      ),
    );
  }

  _navItem(BuildContext context, IconData icon, String text, {Text suffix, Function onTap, bool selected = false}) => Container(

    child: ListTile(
      leading: Icon(icon, color: selected ? Theme.of(context).primaryColor : Colors.black),
      trailing: suffix,
      title: Text(text,

      ),
      selected: selected,
      onTap: onTap,
    ),
  );

  _navItemClicked(BuildContext context, int index) {
    setIndex(index);
    Navigator.of(context).pop();
  }
}