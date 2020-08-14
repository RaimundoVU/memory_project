import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
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

  void addEnd({String location, String notes}) {
    DeliveryLocation end = DeliveryLocation(location: location, notes: notes);
    _navigationService.popResult(end);
  }
}
