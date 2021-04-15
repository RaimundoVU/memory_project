import 'package:bikecourier_app/viewmodels/client/confirm_location_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';


class ConfirmLocationView extends StatelessWidget {
  String type;
  double lat;
  double lng;
  ConfirmLocationView({this.type, this.lat, this.lng});
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ConfirmLocationViewModel>.withConsumer(
      viewModelBuilder: () => ConfirmLocationViewModel(),
      onModelReady: (model) {
        model.onCameraPosition(lat, lng);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: GoogleMap(
          initialCameraPosition: model.cameraPosition,
          mapType: MapType.normal,
          onMapCreated: (controller) => model.onMapCreated(controller, type, lat, lng),
          markers: model.markers,
          onTap: (cordinate) {
            model.controller.animateCamera(CameraUpdate.newLatLng(cordinate));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.check),
          onPressed: () {
            model.submit();
          },
        ),
      ),
    );
  }
}
