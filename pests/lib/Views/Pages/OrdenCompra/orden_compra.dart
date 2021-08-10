import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';


class OrdenPages extends StatefulWidget {
  final Map<String, dynamic> ordenData;

  const OrdenPages({Key key, this.ordenData}) : super(key: key);

  @override
  _OrdenPagesState createState() => _OrdenPagesState();
}

class _OrdenPagesState extends State<OrdenPages> {

  bool _loading = true;
  String _mensaje = "";
  bool _Pagada = false;

  @override
  void initState() {
    // TODO: implement initState
    crearOrden();
    super.initState();
  }


  crearOrden() async {

    var ordenRef = FirebaseFirestore.instance.collection('orden').doc();

    await ordenRef.set(widget.ordenData);

    ordenRef.snapshots().listen(onPreference);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading == true ?  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Estamos procesando el pago"),
              SizedBox(
                height: 20.0,
              ),
              CircularProgressIndicator()
            ],
          ),
        ): Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_mensaje),

          ],
        )
    );
  }
  void onPreference (DocumentSnapshot event) async {
    



    if(event.get("preferen_id") != null){
      var result = await MercadoPagoMobileCheckout.startCheckout(
          "TEST-c6eef33f-567c-42fe-ace6-39f9c5313a90",
          event.get("preferen_id")
      );

      if(result.status == "approved"){
        event.reference.update({
          "status" : "pagada",
          "message" : "Pronto te enviaremos tu producto",
          "payment" : result,

        }).then((value) {
          setState(() {
            _loading = false;
            _mensaje = event.get("message");
          });
        });
      } else if(result.status == "pending"){
        event.reference.update({
          "status" : "pendiente",
          "message" : "Tu pedido sera enviado 24hs despues de aver acreditado el pago.",
          "payment" : result,

        }).then((value) {
          setState(() {
            _loading = false;
            _mensaje = event.get("message");
          });
        });


      }
      print("esultado de la tranferencia ${result.status}");
    }
  }
}
