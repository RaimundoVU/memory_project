import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/services/place_service.dart';
import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/add_favorites_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:bikecourier_app/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

import '../locator.dart';

class AddFavoritesView extends StatelessWidget {
  final locationController = TextEditingController();
  final nameController = TextEditingController();
  final _place = Place();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
        viewModelBuilder: () => AddFavoritesViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      verticalSpace(40),
                      Text('Nombre'),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'Nombre de la ubicacón',
                        controller: nameController,
                        smallVersion: false,
                      ),
                      verticalSpaceMedium,
                      Text(
                        'Ubicación',
                      ),
                      verticalSpaceMedium,
                      SearchField(
                        placeholder: 'Dirección',
                        controller: locationController,
                        place: _place,
                      ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BusyButton(
                            title: 'Listo',
                            busy: model.busy,
                            onPressed: () {
                              print(_place);
                              model.addPlace(
                                  location: locationController.text,
                                  name: nameController.text,
                                  place: _place);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
