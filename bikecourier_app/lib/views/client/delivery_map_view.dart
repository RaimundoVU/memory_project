import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/location_service.dart';
import 'package:bikecourier_app/viewmodels/client/delivery_map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class DeliveryMapView extends StatefulWidget {
  final Delivery delivery;

  const DeliveryMapView({Key key, this.delivery}) : super(key: key);

  @override
  _DeliveryMapViewState createState() => _DeliveryMapViewState();
}

class _DeliveryMapViewState extends State<DeliveryMapView> {
  //firestore service
  FirestoreService _firestoreService = locator<FirestoreService>();

  //everything related to location.
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();

  //everything related to markers and lines
  Set<Marker> _markers = HashSet<Marker>();
  Marker marker;
  Marker endMarker;
  PolylinePoints polylinePoints;
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> _polylines = {};

  GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
    initializeMarkers(widget.delivery);
    //_createPolylines(widget.delivery);
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  initializeMarkers(Delivery delivery) async {
    marker = Marker(
        draggable: true,
        markerId: MarkerId("start"),
        position: LatLng(delivery.start.lat, delivery.start.lng),
        onDragEnd: ((value) {
          print("locationdrag: " + value.latitude.toString());
        }),
        infoWindow: InfoWindow(
            title: 'Ubicación de origen',
            snippet: 'Aquí comienza la encomienda'));
    _markers.add(marker);
    endMarker = Marker(
        draggable: true,
        markerId: MarkerId("end"),
        position: LatLng(delivery.end.lat, delivery.end.lng),
        onDragEnd: ((value) {
          print("locationdrag: " + value.latitude.toString());
        }),
        infoWindow: InfoWindow(
            title: 'Ubicación de destino',
            snippet: 'Aquí termina la encomienda'));
    _markers.add(endMarker);
    _createPolylines(delivery);
  }

  void _createPolylines(Delivery delivery) async {
    // Initializing PolylinePoints
    polylinePoints = new PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDdsRv69Vj2zLIoYCDt62AtB7JDvOU-HH8", // Google Maps API Key
      PointLatLng(delivery.start.lat, delivery.start.lng),
      PointLatLng(delivery.end.lat, delivery.end.lng),
      travelMode: TravelMode.transit,
    );

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    // Defining an ID
    this.setState(() {
      PolylineId id = PolylineId('poly');

      // Initializing Polyline
      Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.red,
        points: polylineCoordinates,
        width: 3,
      );
      // Adding the polyline to the map
      _polylines[id] = polyline;
    });
  }

  void updateMarkerAndCircle(LocationData newLocalData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = new Marker(
          markerId: MarkerId("start"),
          position: latlng,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5));
      _markers.clear();
      _markers.add(marker);
      _markers.add(endMarker);
    });
  }

  void getCurrentLocation() async {
    try {
      var delivery =
          await _firestoreService.getDelivery(widget.delivery.documentId);
      var location = LocationData.fromMap(delivery.position());
      print("____________________");
      print(location);

      updateMarkerAndCircle(location);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        // ESTA LINEA ES FUNDAMENTAL;
        newLocalData = location;
        print("__________________");
        print(newLocalData);
        print("__________________");
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  bearing: 192.8334901395799,
                  target: LatLng(newLocalData.latitude, newLocalData.longitude),
                  tilt: 0,
                  zoom: 18.00)));
          updateMarkerAndCircle(newLocalData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target:
                LatLng(widget.delivery.start.lat, widget.delivery.start.lng),
            zoom: 14.4746),
        markers: _markers,
        polylines: Set<Polyline>.of(_polylines.values),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
