import 'dart:ffi';

import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/saved_places.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../locator.dart';

class EditFavoritesViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  List<SavedPlaces> _savedPlaces;
  List<SavedPlaces> get savedPlaces => _savedPlaces;


  void listenToSavedPlaces(String uid) {
    setBusy(true);
    _firestoreService.listenToSavedPlaces(uid).listen((savedPlacesData) {
      List<SavedPlaces> updatedSavedPlaces = savedPlacesData;
      if (updatedSavedPlaces != null && updatedSavedPlaces.length > 0) {
        _savedPlaces = updatedSavedPlaces;
        notifyListeners();
      }
     });
     setBusy(false);
  }


  Future deleteDelivery(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: '¿Estás seguro?',
      description: 'Se eliminará esta ubicación para siempre. ¿Quieres continuar?',
      confirmationTitle: 'Sí',
      cancelTitle: 'No'
    );

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteDelivery(_savedPlaces[index].documentId);
      setBusy(false);
    }
  }

}
