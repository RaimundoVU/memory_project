import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/services/place_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:bikecourier_app/views/client/confirm_location_view.dart';
import 'package:flutter/foundation.dart';

import '../../locator.dart';

class CreateEndViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  DeliveryLocation _edittingEnd;

  void setEditting(DeliveryLocation end) {
    _edittingEnd = end;
  }

  bool get _editting => _edittingEnd != null;

  Future<void> addEnd({String location, String notes, Place place}) async {
    setBusy(true);
    var result = await _navigationService.navigateTo(ConfirmLocationViewRoute,
    arguments: ["end", place.lat, place.lng] );
    DeliveryLocation end = DeliveryLocation(location: location, notes: notes, lat: result.latitude, lng: result.longitude);
    setBusy(false);
    _navigationService.popResult(end);
  }
}
