import 'package:bikecourier_app/models/saved_places.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/services/place_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../locator.dart';

class AddFavoritesViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void addPlace({String location, String name, Place place}) async {
    print('####');
    print(place.toString());
    print('###');
    setBusy(true);
    SavedPlaces savePlace =
        SavedPlaces(location: location, name: name, lat: place.lat, lng: place.lng, userId: currentUser.id);
    var result = await _firestoreService.addLocation(savePlace);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
          title: 'No se puedo guardar la ubicación favorita', description: result);
    } else {
      await _dialogService.showDialog(
          title: 'Se guardó tu ubicación',
          description: 'Se guardó de manera satisfactoria tu ubicación :)');
    }

    _navigationService.pop();
  }
}
