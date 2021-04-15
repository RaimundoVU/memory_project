import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/viewmodels/client/delivery_map_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DeliveryMapView extends StatelessWidget {
  final Delivery delivery;

  const DeliveryMapView({Key key, this.delivery}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<DeliveryMapViewModel>.withConsumer(
      viewModelBuilder: () => DeliveryMapViewModel(),
      onModelReady: (model) {
        model.onCameraPosition();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: GoogleMap(
          initialCameraPosition: model.cameraPosition,
          polylines: Set<Polyline>.of(model.polylines.values),
          mapType: MapType.normal,
          onMapCreated: (controller) => model.onMapCreated(controller, delivery),
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