import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';

import '../locator.dart';

class ResetPasswordViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  void resetPassword({String email}) async {
    setBusy(true);
    var result = await _authenticationService.resetPassword(email);
    setBusy(false);
    print("#####");
    print(result);
    await _dialogService.showDialog(
          title: '',
          description: "Se ha enviado un correo para recuperar su contraseña a $email"
        );
    _navigationService.pop();
  }
}
