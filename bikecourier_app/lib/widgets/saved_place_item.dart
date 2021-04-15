import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/saved_places.dart';
import 'package:flutter/material.dart';

class SavedPlacesItem extends StatelessWidget {
  final SavedPlaces savedPlaces;
  final Function onDeleteSavedPlace;
  const SavedPlacesItem({Key key, this.savedPlaces, this.onDeleteSavedPlace}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Text('Ubicación',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Alias: ' + savedPlaces.name),
                Text('Destino: ' + savedPlaces.location),
              ],
            ),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteSavedPlace != null) {
                onDeleteSavedPlace();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
