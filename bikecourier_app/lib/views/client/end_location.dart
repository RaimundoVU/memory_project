import 'package:bikecourier_app/models/Direction.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'confirm_location.dart';

class EndLocation extends StatefulWidget {
  final FirebaseUser user;
  final Direction defaultLocation;
  EndLocation({Key key, this.user, this.defaultLocation});
  @override
  _EndLocationState createState() => _EndLocationState();
}

class _EndLocationState extends State<EndLocation> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _endLocation;
  String _endNotes;

  Widget createDirectionInput() {
    return TextFormField(
      // focusNode: _focusNodeDirection,
      initialValue: widget.defaultLocation.endLocation,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe una dirección';
        }
      },
      onSaved: (input) => _endLocation = input,
      obscureText: false,
      decoration: InputDecoration(
          labelText: 'Dirección',
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Dirección de destino"),
    );
  }

  Widget createNotesInput() {
    return TextFormField(
      // focusNode: _focusNodeDirection,
      initialValue: widget.defaultLocation.endNotes,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe notas';
        }
      },
      onSaved: (input) => _endNotes = input,
      obscureText: false,
      decoration: InputDecoration(
          labelText: 'Notas',
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Notas para el mensajero"),
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
            children: [
              createDirectionInput(),
              createNotesInput(),
              RaisedButton(
                  child: Text(
                    'Listo',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.black,
                  onPressed: () {
                    _submitDirection(context);
                  })
            ],
          ),
        ),
      ),
    );
  }

  void _submitDirection(BuildContext context)  async{
    if (_formKey.currentState.validate()) {
      final result = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => ConfirmLocation(user: widget.user, type: "end"),
      ));
      _formKey.currentState.save();
      print(result);
      setState(() {
        widget.defaultLocation.endLat = result.latitude;
        widget.defaultLocation.endLng = result.longitude;
        widget.defaultLocation.endNotes = this._endNotes;
        widget.defaultLocation.endLocation = this._endLocation;
      });
      Navigator.pop(context, widget.defaultLocation);
    } else {
      Navigator.pop(context, this._endLocation);
    }
  }
}
