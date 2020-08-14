import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../../locator.dart';

class DeliveryViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  DeliveryLocation _start;
  DeliveryLocation _end;
  DeliveryObject _object;

  DeliveryLocation get start => _start;
  DeliveryLocation get end => _end;
  DeliveryObject get object => _object;

  Future navigateToCreateStart() async {
    setBusy(true);
    var result = await _navigationService.navigateTo(CreateStartViewRoute,
        arguments: _start);
    setBusy(false);
    _start = result;
  }

  Future navigateToCreateEnd() async {
    setBusy(true);
    var result = await _navigationService.navigateTo(CreateEndViewRoute,
        arguments: _end);
    setBusy(false);
    _end = result;
  }

  Future navigateToCreateObject() async {
    setBusy(true);
    var result = await _navigationService.navigateTo(CreateObjectViewRoute,
        arguments: _object);
    setBusy(false);
    _object = result;
  }
}
