import 'dart:ffi';

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
    print('_________uid');
    print(uid);
    print("finuid_________");
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

  void listenToDoneDeliveries(String uid) {
    setBusy(true);
    _firestoreService.listenToDoneDeliveryRealTime(uid).listen((deliveryData) {
      List<Delivery> updatedDeliveries = deliveryData;
      if (updatedDeliveries != null && updatedDeliveries.length > 0) {
        _deliveries = updatedDeliveries;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  Future deleteDelivery(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
        title: '¿Estás seguro?',
        description:
            'Se eliminará esta encomienda para siempre. ¿Quieres continuar?',
        confirmationTitle: 'Sí',
        cancelTitle: 'No');

    if (dialogResponse.confirmed) {
      setBusy(true);
      await _firestoreService.deleteDelivery(_deliveries[index].documentId);
      setBusy(false);
    }
  }

  navigateToCreateDelivery() async {
    if (currentUser.rut == null) {
      await _dialogService.showDialog(
          title: 'Usted aún no ha completado su perfil.',
          description:
              'Necesita ingresar su rut, debe dirigirse Configuración > Editar Perfil',);
    }
    if (currentUser.phoneNumber == null) {
       await _dialogService.showDialog(
          title: 'Usted aún no ha completado su perfil.',
          description:
              'Necesita ingresar su número de télefono, debe dirigirse Configuración > Editar Perfil',
       );
    } else {
      _navigationService.navigateTo(DeliveryViewRoute);
    }
  }

  goToMap(int index) async {
    _navigationService.navigateTo(DeliveryMapViewRoute,
        arguments: _deliveries[index]);
  }
}
