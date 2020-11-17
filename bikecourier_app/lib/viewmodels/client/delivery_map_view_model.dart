import 'dart:collection';

import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/services/location_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../locator.dart';

class DeliveryMapViewModel extends BaseModel {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  LocationService _locationService = locator<LocationService>();
  NavigationService _navigationService = locator<NavigationService>();

  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;
  GoogleMapController get controller => _controller;
  Set<Marker> get markers => _markers;

  void onMapCreated(GoogleMapController controller, Delivery delivery) async {
    setBusy(true);
    _controller = controller;
    print(delivery.start);
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
}
