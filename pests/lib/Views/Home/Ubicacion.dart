import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pests/UI/All.dart';
import 'package:provider/provider.dart';



class MiUbicacion extends StatefulWidget {
  @override
  _MiUbicacionState createState() => _MiUbicacionState();
}

class _MiUbicacionState extends State<MiUbicacion> {
  GoogleMapController mapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final location  = new Location().getLocation();
  LocationData pinPos;
  LocationData actualLocation;

  void _onMaoCreated(GoogleMapController controller){

    mapController = controller;
    _add(LatLng(pinPos.latitude, pinPos.longitude));

  }



  @override
  Widget build(BuildContext context) {

   // final lugarProvider = Provider.of<LugarProvider>(context);

    return Scaffold(
      body: _crearMapa(),
    );
  }

  Widget _crearMapa(){
    return FutureBuilder(
      future: location,
      builder: (BuildContext context, AsyncSnapshot<LocationData> snapshot ){
        if(snapshot.hasData){
          final pos = snapshot.data;

          pinPos = pos;
          actualLocation = pos;

          return SafeArea(
              child: GoogleMap(
                onMapCreated: _onMaoCreated,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target:  LatLng(pos.latitude, pos.longitude),
                  zoom: 15,
                ),
                markers: Set<Marker>.of(markers.values),
              )
          );

        }else{
          return Center(
            child: LinearProgressIndicator(),
          );
        }

      },

    );
  }


  void  _add(LatLng latLng){

    final MarkerId markerId = MarkerId("normal");

    final marker = Marker(

      markerId: markerId,
      draggable: true,
      onDragEnd: (latLng){

        pinPos =  new LocationData.fromMap({
          'latitude': latLng.latitude,
          'longitude' : latLng.longitude
        });

      },
      position: latLng,
      infoWindow: InfoWindow(title: "Lugar", snippet: "Aqui se ubica el sitio"),
      onTap: (){

      }


    );

    setState(() {
      markers[markerId] = marker;
    });


  }

/*
  _floatBoton(BuildContext context, LugarProvider lugarProvider){
    final size  = MediaQuery.of(context).size;

    return SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.13,

            ),
            FloatingActionButton.extended(onPressed: onPressed, label: label)

          ]

        )
    );

  }

*/
}


