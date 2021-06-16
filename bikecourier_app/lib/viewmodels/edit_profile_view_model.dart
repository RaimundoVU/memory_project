import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/user.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';
import 'base_model.dart';

class EditProfileViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  User _edittingUser;

  void setEditting(User user) {
    print(user.toJson());
    _edittingUser = user;
  }

  bool get _editting => _edittingUser != null;

  Future editUser(
      {@required String fullName,
      @required String phoneNumber,
      @required String rut}) async {
    setBusy(true);
    rut = RUTValidator.formatFromText(rut);

    print("#####");
    var validator = RUTValidator().validator(rut);

    if (validator != null) {
      await _dialogService.showDialog(title: "Error", description: validator);
      this.setBusy(false);
      return;
    }
    print(rut);
    var result = await _authenticationService.editUser(
        uid: currentUser.id,
        fullName: fullName,
        rut: rut,
        phoneNumber: phoneNumber);
    if (result) {
      await _dialogService.showDialog(
          title: "Edición de perfil exitosa",
          description: "Se ha editado de mannera satisfactoria su perfil");
      _navigationService.pop();
    } else {
      await _dialogService.showDialog(
        title: 'La edición del perfil ha fallado',
        description: result,
      );
    }
    setBusy(false);
  }
}

class _rutController {}
