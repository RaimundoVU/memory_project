import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/reset_password_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class ResetPasswordView extends StatelessWidget {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
        viewModel: ResetPasswordViewModel(),
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      verticalSpace(40),
                      Text('Correo'),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'Ingrese su correo',
                        controller: emailController
                     ),
                      verticalSpaceMedium,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BusyButton(
                            title: 'Listo',
                            busy: model.busy,
                            onPressed: () {
                              model.resetPassword(
                                email: emailController.text,
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
