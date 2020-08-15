import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../../locator.dart';

class ClientMainViewModel extends BaseModel {
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  List<Delivery> _deliveries;
  List<Delivery> get deliveries => _deliveries;


  void listenToDeliveries(String uid) {
    setBusy(true);
    _firestoreService.listenToDeliveryRealTime(uid).listen((deliveryData) {
      List<Delivery> updatedDeliveries = deliveryData;
      if (updatedDeliveries != null && updatedDeliveries.length > 0) {
        _deliveries = updatedDeliveries;
        notifyListeners();
      }
     });
     setBusy(false);
  }
  navigateToCreateDelivery() async {
    _navigationService.navigateTo(DeliveryViewRoute);
  }
}
