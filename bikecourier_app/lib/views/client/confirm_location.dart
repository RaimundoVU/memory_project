import 'dart:collection';

import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class ConfirmLocation extends StatefulWidget {
  final FirebaseUser user;
  final String type;

  ConfirmLocation({Key key, this.user, this.type});
  @override
  _ConfirmLocationState createState() => _ConfirmLocationState();
}

class _ConfirmLocationState extends State<ConfirmLocation> {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  LocationData currentLocation;
  Location location;
  final CameraPosition _initialPosition = CameraPosition(
      target: new LatLng(-35.4378586, -71.6792006), zoom: 14.467);

  @override
  void initState() {
    super.initState();

    location = new Location();
    _getLocation();
  }

  void _getLocation() async {
    try {
      currentLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == "PERMISSION_DENIED") {
        String error = 'Permission denied';
        print(error);
      }
      currentLocation = null;
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    String title;
    String snippet;

    if (widget.type == "origin") {
      title = "Ubicación de Origen";
      snippet = "Desde aquí comienza la encomienda";
    } else {
      title = "Ubicación de Destino";
      snippet = "Aquí termina la encomienda";
    }

    print(currentLocation);
    setState(() {
      _markers.add(Marker(
          draggable: true,
          markerId: MarkerId("0"),
          position: LatLng(this.currentLocation.latitude, this.currentLocation.longitude),
          onDragEnd: ((value) {
            print("locationdrag:" + value.latitude.toString());
            print(currentLocation.latitude);
          }),
          infoWindow: InfoWindow(title: title, snippet: snippet)));
    });
  }

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
        onMapCreated: _onMapCreated,
        markers: _markers,
        onTap: (cordinate) {
          _controller.animateCamera(CameraUpdate.newLatLng(cordinate));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          _submit(context);
        },
      ),
    );
  }

  void _submit(BuildContext context) async {
    print('currentLocation' + this.currentLocation.toString());
    setState(() {});
    Navigator.pop(context, this.currentLocation);
  }
}
