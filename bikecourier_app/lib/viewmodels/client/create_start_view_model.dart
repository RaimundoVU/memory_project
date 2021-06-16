import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/services/place_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';
import '../../locator.dart';

class CreateStartViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  DeliveryLocation _edittingStart;

  void setEditting(DeliveryLocation start) {
    _edittingStart = start;
  }

  bool get _editting => _edittingStart != null;

  void addStart({String location, String notes, Place place}) async {
    print('####');
    print(place.toString());
    print('###');
    setBusy(true);
    var result = await _navigationService.navigateTo(ConfirmLocationViewRoute,
        arguments: ["start", place.lat, place.lng]);
    DeliveryLocation start = DeliveryLocation(location: location, notes: notes, lat: result.latitude, lng: result.longitude);

    setBusy(false);
    _navigationService.popResult(start);
  }
}
