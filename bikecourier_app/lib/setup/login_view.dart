import 'package:bikecourier_app/viewmodels/login_view_model.dart';
import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:bikecourier_app/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => LoginViewModel(),
        builder: (context, model, chilld) => Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 150,
                      child: Image.asset('assets/images/logo.png'),
                    ),
                    InputField(
                      placeholder: 'Correo',
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Contraseña',
                      password: true,
                      controller: passwordController,
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BusyButton(
                          title: 'Ingresar',
                          busy: model.busy,
                          onPressed: () {
                            model.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    TextLink(
                      'Olvidé mi contraseña',
                      onPressed: () {
                        model.navigateToResetPassword();
                      },
                    ),
                    verticalSpaceSmall,
                    TextLink(
                      'Crear una cuenta.',
                      onPressed: () {
                        model.navigateToSignUp();
                      },
                    ),
                  ],
                ),
              ),
            )));
  }
}
