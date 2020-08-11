import 'package:bikecourier_app/models/Direction.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:bikecourier_app/views/client/confirm_location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OriginLocation extends StatefulWidget {
  final FirebaseUser user;
  final Direction defaultLocation;
  OriginLocation({Key key, this.user, this.defaultLocation});
  @override
  _OriginLocationState createState() => _OriginLocationState();
}

class _OriginLocationState extends State<OriginLocation> {
  // static var _focusNodeDirection = new FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _originLocation;
  String _originNotes;


  Widget createDirectionInput() {
    return TextFormField(
      // focusNode: _focusNodeDirection,
      initialValue: widget.defaultLocation.originLocation,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe una dirección';
        }
      },
      onSaved: (input) => _originLocation = input,
      obscureText: false,
      decoration: InputDecoration(
          labelText: 'Dirección',
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Dirección de origen"),
    );
  }

  Widget createNotesInput() {
    return TextFormField(
      // focusNode: _focusNodeDirection,
      initialValue: widget.defaultLocation.originNotes,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe notas';
        }
      },
      onSaved: (input) => _originNotes = input,
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
        builder: (context) => ConfirmLocation(user: widget.user, type: "origin"),
      ));
      _formKey.currentState.save();
      print(result);
      setState(() {
        widget.defaultLocation.originLat = result.latitude;
        widget.defaultLocation.originLng = result.longitude;
        widget.defaultLocation.originNotes = this._originNotes;
        widget.defaultLocation.originLocation = this._originLocation;
      });
      Navigator.pop(context, widget.defaultLocation);
    } else {
      Navigator.pop(context, this._originLocation);
    }
  }
}
