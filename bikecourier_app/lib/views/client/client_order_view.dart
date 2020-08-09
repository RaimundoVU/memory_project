import 'package:bikecourier_app/models/DeliveryObject.dart';
import 'package:bikecourier_app/models/Direction.dart';
import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
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
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }
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
        subtitle: Text(this.directionData.originLocation),
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

  void _awaitForOriginLocation(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OriginLocation(
            user: widget.user,
            defaultLocation: directionData.originLocation,
          ),
        ));

    setState(() {
      directionData.originLocation = result;
    });

    print(directionData);
  }
}
