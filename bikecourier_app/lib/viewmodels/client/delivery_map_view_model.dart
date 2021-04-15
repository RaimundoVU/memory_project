import 'dart:collection';

import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/services/location_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../locator.dart';

class DeliveryMapViewModel extends BaseModel {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  LocationService _locationService = locator<LocationService>();
  NavigationService _navigationService = locator<NavigationService>();

  PolylinePoints polylinePoints;

  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> _polylines = {};

  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;
  GoogleMapController get controller => _controller;
  Set<Marker> get markers => _markers;
  Map<PolylineId, Polyline> get polylines => _polylines;


  void onMapCreated(GoogleMapController controller, Delivery delivery) async {
    setBusy(true);
    _controller = controller;
    _markers.add(
      Marker(
          draggable: true,
          markerId: MarkerId("start"),
          position: LatLng(delivery.start.lat, delivery.start.lng),
          onDragEnd: ((value) {
            print("locationdrag: " + value.latitude.toString());
          }),
          infoWindow: InfoWindow(
              title: 'Ubicación de origen',
              snippet: 'Aquí comienza la encomienda')),
    );
    _markers.add(
      Marker(
          draggable: true,
          markerId: MarkerId("end"),
          position: LatLng(delivery.end.lat, delivery.end.lng),
          onDragEnd: ((value) {
            print("locationdrag: " + value.latitude.toString());
          }),
          infoWindow: InfoWindow(
              title: 'Ubicación de destino',
              snippet: 'Aquí termina la encomienda')),
    );
    print("######CREATING POLILYNES#####");
    await _createPolylines(delivery);
    setBusy(false);
  }

  void onCameraPosition() async {
    setBusy(true);
    var currentLocation = await _locationService.getLocation();
    _cameraPosition = CameraPosition(
        target: new LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 15);
    setBusy(false);
  }

  void submit() async {
    _navigationService.pop();
  }

  void _createPolylines(Delivery delivery) async {
  // Initializing PolylinePoints
  polylinePoints = PolylinePoints();

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
}
}
