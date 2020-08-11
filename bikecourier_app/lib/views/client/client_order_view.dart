import 'package:bikecourier_app/models/DeliveryObject.dart';
import 'package:bikecourier_app/models/Direction.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:bikecourier_app/views/client/client_main.dart';
import 'package:bikecourier_app/views/client/end_location.dart';
import 'package:bikecourier_app/views/client/object_order.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'origin_location.dart';

class ClientOrder extends StatefulWidget {
  final FirebaseUser user;
  final String userName;

  ClientOrder({Key key, this.user, this.userName});

  @override
  _ClientOrderState createState() => _ClientOrderState();
}

class _ClientOrderState extends State<ClientOrder> {
  int _currentStep = 0;
  bool completeStep = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static var _focusNodeEnd = new FocusNode();
  Direction directionData = new Direction();
  DeliveryObject objectData = new DeliveryObject();

  List<Step> steps;

  void _submitDetails() {
    final FormState formState = _formKey.currentState;
    if (!formState.validate()) {
      print("FAILURE");
    } else {
      formState.save();
      showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text("Details"),
            //content: new Text("Hello World"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text(
                      "Dirección de origen : " + directionData.originLocation),
                  new Text(
                      "Dirección de destino :" + directionData.endLocation),
                  new Text("Object info :" + objectData.objectType),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: createDeliveryOrder,
              ),
            ],
          ));
    }
  }

  Future<void> createDeliveryOrder() async {
  //to do: check if exist a delivery with "WAITING" status.
  DocumentReference delivery = await Firestore.instance.collection('deliveryOrders').add(
      {
        'orderedBy': widget.user.uid,
        'deliveredBy': null,
        'status': 'WAITING'
      }
    );
  Firestore.instance.collection('deliveryOriginLocation').add(
    {
      'deliveryId': delivery.documentID,
      'originLocation': directionData.originLocation,
      'originLocationLat': directionData.originLat,
      'originLocationLng': directionData.originLng,
      'originLocationNotes': directionData.originNotes
    }
  );

  Firestore.instance.collection('deliveryEndLocation').add(
    { 
      'deliveryId': delivery.documentID,
      'endLocation': directionData.endLocation,
      'endLocationLat': directionData.endLat,
      'endLocationLng': directionData.endLng,
      'endLocationNotes': directionData.endNotes
    }
  );

  Firestore.instance.collection('deliveryObject').add(
    {
      'deliveryId': delivery.documentID,
      'objectType': objectData.objectType,
      'objectSize': objectData.objectSize,
      'objectNotes': objectData.extraInfo,
    }
  );
   Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => ClientMain(user: widget.user, userName: widget.userName,)));
  }

  Widget createEndDirectionInput() {
    return TextFormField(
      focusNode: _focusNodeEnd,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe una dirección';
        }
      },
      onSaved: (String input) => directionData.endLocation = input,
      obscureText: false,
      decoration: InputDecoration(hintText: "Dirección de destino"),
    );
  }

  Widget createOriginLocation() {
    return Expanded(
      child: Card(
          child: ListTile(
        title: Text('Dirección de origen'),
        subtitle: Text("Dirección: " +
            this.directionData.originLocation +
            "\nNotas: " +
            this.directionData.originNotes),
      )),
    );
  }

  Widget createEndLocation() {
    return Expanded(
      child: Card(
          child: ListTile(
        title: Text('Dirección de destino'),
        subtitle: Text("Dirección: " +
            this.directionData.endLocation +
            "\nNotas: " +
            this.directionData.endNotes),
      )),
    );
  }

  Widget createObjectInfo() {
    return Expanded(
      child: Card(
          child: ListTile(
        title: Text('Objeto que se enviará'),
        subtitle: Text("Tipo: " +
            this.objectData.objectType +
            "\nTamaño:" +
            this.objectData.objectSize +
            "\nNotas: " +
            this.objectData.extraInfo),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: new IconThemeData(color: Colors.black),
            backgroundColor: Color.fromRGBO(255, 251, 193, 1.0)),
        drawer: SideDrawer(user: widget.user),
        body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  Text(
                    'Realizar envío',
                    textAlign: TextAlign.left,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.00),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      createOriginLocation(),
                      FlatButton(
                        onPressed: () {
                          _awaitForOriginLocation(context);
                        },
                        child: Text('Editar'),
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      createEndLocation(),
                      FlatButton(
                        child: Text('Editar'),
                        onPressed: () {
                          _awaitForEndLocation(context);
                        },
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  Row(
                    children: [
                      createObjectInfo(),
                      FlatButton(
                          child: Text('Editar'),
                          onPressed: () {
                            _awaitForObjectInfo(context);
                          })
                    ],
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 1,
                  ),
                  RaisedButton(
                      child: Text(
                        'Enviar encomienda',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.black,
                      onPressed: _submitDetails)
                ],
              )),
        ));
  }

  void _awaitForObjectInfo(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ObjectOrder(
                  user: widget.user,
                  deliveryObject: objectData,
                )));

    setState(() {
      objectData = result;
    });
  }

  void _awaitForOriginLocation(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OriginLocation(
            user: widget.user,
            defaultLocation: directionData,
          ),
        ));

    setState(() {
      directionData = result;
    });
  }

  void _awaitForEndLocation(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EndLocation(
                  user: widget.user,
                  defaultLocation: directionData,
                )));

    setState(() {
      directionData = result;
    });
  }
}
