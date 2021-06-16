import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../locator.dart';

class ChangePasswordViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void changePassword({String password, String verifyPassword}) async {
    if (password != verifyPassword) {
      await _dialogService.showDialog(
          title: 'No se pudo cambiar la contraseña',
          description: 'Las contraseñas no coinciden');
    } else {
      setBusy(true);
      var result = await _authenticationService.changePassword(password);
      setBusy(false);
      if (result is bool) {
        if (result) {
          await _dialogService.showDialog(
              title: 'Se cambio correctamente la contraseña',
              description: 'No se ha podido cambiar la contraseña');
        } 
      } else {
          print(result);
          await _dialogService.showDialog(
              title: 'No se pudo cambiar la contraseña',
              description: result);
      }

      _navigationService.pop();
    }
  }
}
