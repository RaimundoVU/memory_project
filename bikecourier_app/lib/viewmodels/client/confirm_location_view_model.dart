import 'dart:collection';

import 'package:bikecourier_app/models/user_location.dart';
import 'package:bikecourier_app/services/location_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../locator.dart';

class ConfirmLocationViewModel extends BaseModel {
  GoogleMapController _controller;
  Set<Marker> _markers = HashSet<Marker>();
  LocationService _locationService = locator<LocationService>();
  NavigationService _navigationService = locator<NavigationService>();

  CameraPosition _cameraPosition;
  CameraPosition get cameraPosition => _cameraPosition;
  GoogleMapController get controller => _controller;
  Set<Marker> get markers => _markers;

  void onMapCreated(GoogleMapController controller, String type) async {
    String title;
    String snippet;
    setBusy(true);
    _controller = controller;
    var currentLocation = await _locationService.getLocation();
    if (type == "start") {
      title = "Ubicación de Origen";
      snippet = "Desde aquí comienza la encomienda";
    } else {
      title = "Ubicación de Destino";
      snippet = "Aquí termina la encomienda";
    }
    _markers.add(
      Marker(
          draggable: true,
          markerId: MarkerId("0"),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          onDragEnd: ((value) {
            print("locationdrag: " + value.latitude.toString());
          }),
          infoWindow: InfoWindow(title: title, snippet: snippet)),
    );
    setBusy(false);
  }

  void onCameraPosition() async {
    setBusy(true);
    var currentLocation = await _locationService.getLocation();
    _cameraPosition = CameraPosition(
        target: new LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 14);
    setBusy(false);
  }

  void submit() async {
    setBusy(true);
    var userLocation = await _locationService.getLocation();
    setBusy(false);
    print(userLocation);
    _navigationService.popResult(userLocation);
  }
}
