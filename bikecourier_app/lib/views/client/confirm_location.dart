import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConfirmLocation extends StatefulWidget {
  final FirebaseUser user;

  ConfirmLocation({Key key, this.user});
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  GoogleMapController _controller;
  final CameraPosition _initialPosition = CameraPosition(
      target: new LatLng(-35.4378586, -71.6792006), zoom: 14.467);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(255, 251, 193, 1.0),
        title: Text(
          'Confirmar ubicación',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
        ),
      ),
      drawer: SideDrawer(user: widget.user),
      body: GoogleMap(
        initialCameraPosition: _initialPosition,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          setState(() {
            _controller = controller;
          });
        },
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
        },
      ),
    );
  }
}
