import 'dart:math';

import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/signup_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class SignUpPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpPageModel>.withConsumer(
      viewModel: SignUpPageModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color.fromRGBO(255, 251, 193, 1.0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registrarse',
                style: TextStyle(
                  fontSize: 38,
                ),
              ),
              verticalSpaceLarge,
              // TODO: Add additional user data here to save (episode 2)
              InputField(
                placeholder: 'Correo',
                controller: emailController,
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Contraseña',
                password: true,
                controller: passwordController,
                additionalNote:
                    'La contraseña debe ser de mínimo 6 caracteres.',
              ),
              verticalSpaceSmall,
              InputField(
                placeholder: 'Confirmar contraseña',
                password: true,
                controller: confirmPasswordController,
              ),
              verticalSpaceMedium,
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BusyButton(
                    title: 'Registrarse',
                    busy: model.busy,
                    onPressed: () {
                      model.signUp(
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
