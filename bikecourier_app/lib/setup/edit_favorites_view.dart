import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/edit_favorites_view_model.dart';
import 'package:bikecourier_app/widgets/app_drawer.dart';
import 'package:bikecourier_app/widgets/delivery_item.dart';
import 'package:bikecourier_app/widgets/saved_place_item.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class EditFavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<EditFavoritesViewModel>.withConsumer(
      viewModel: EditFavoritesViewModel(),
      onModelReady: (model) => model.listenToSavedPlaces(model.currentUser.id),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(35),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      'Lugares Favoritos',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              Expanded(
                child: model.savedPlaces != null
                    ? ListView.builder(
                        itemCount: model.savedPlaces.length,
                        itemBuilder: (context, index) => GestureDetector(
                              child: SavedPlacesItem(
                                savedPlaces: model.savedPlaces[index],
                                onDeleteSavedPlace: () =>
                                    model.deleteDelivery(index),
                              ),
                            ))
                    : Center(
                        child: Text('No hay ubicaciones guardadas.'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
