import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';
import 'base_model.dart';

class SignUpPageModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signUp({
    @required String email,
    @required String password,
    @required String confirmPassword,
  }) async {

    setBusy(true);
    if (password != confirmPassword) {
      await _dialogService.showDialog(
          title: 'El registro ha fallado',
          description: 'Las contraseñas no coinciden');
      this.setBusy(false);
      return;
    }
    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(LoginPageRoute);
      } else {
        await _dialogService.showDialog(
            title: 'El registro ha fallado',
            description: 'Intenta de nuevo mas tarde');
      }
    } else {
      await _dialogService.showDialog(
        title: 'El registro ha fallado',
        description: result,
      );
    }
  }
}
