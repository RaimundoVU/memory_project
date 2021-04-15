import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../../locator.dart';

class DeliveryViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  Delivery _delivery;
  DeliveryLocation _start;
  DeliveryLocation _end;
  DeliveryObject _object;

  DeliveryLocation get start => _start;
  DeliveryLocation get end => _end;
  DeliveryObject get object => _object;
  Delivery get delivery => _delivery;

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

  Future addDelivery() async {
    print('///////////////////////////////');
    print(_start.toMap());
    print(_end.toMap());
    print('///////////////////////////////');

    setBusy(true);
    _delivery = Delivery(
        orderedBy: currentUser.id,
        orderedByName: currentUser.fullName,
        status: 'WAITING',
        start: _start,
        end: _end,
        object: _object);
    var result = await _firestoreService.addDelivery(_delivery);
    setBusy(false);
    if (result is String) {
      await _dialogService.showDialog(
          title: 'No se puedo crear la encomienda', description: result);
    } else {
      await _dialogService.showDialog(
          title: 'Se creo tu pedido de encomienda',
          description: 'Se creo de manera satisfactoria tu encomienda :)');
    }

    _navigationService.pop();
  }
}
