import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:flutter/foundation.dart';

import '../../locator.dart';

class CreateObjectViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();
  
  DeliveryObject _edittingObject;
  String _selectedType = "Seleccionar tipo de objecto";
  String _selectedSize = "Seleccionar tamaño de objeto";

  String get selectedType => _selectedType;
  String get selectedSize => _selectedSize;

  void setEditting(DeliveryObject object) {
    _edittingObject = object;
  }

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  String setSelectedSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  bool get _editting => _edittingObject != null;

  void addObject({String notes}) {
    DeliveryObject object = DeliveryObject(type: _selectedType, size: _selectedSize,info: notes);
    _navigationService.popResult(object);
  }

  void uploadImage() {
    
  }
}
