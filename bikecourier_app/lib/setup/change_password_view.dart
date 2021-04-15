import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/change_password_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ChangePasswordView extends StatelessWidget {
  final passwordController = TextEditingController();
  final verifyController   = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
        viewModelBuilder: () => ChangePasswordViewModel(),
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
                      Text('Contraseña'),
                      verticalSpaceSmall,
                      InputField(
                        placeholder: 'Contraseña',
                        controller: passwordController,
                        password: true
                     ),
                      verticalSpaceMedium,
                      Text(
                        'Confirme contraseña',
                      ),
                      verticalSpaceMedium,
                      InputField(
                        placeholder: 'Confirme su contraseña',
                        controller: verifyController,
                        password: true,
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
                              model.changePassword(
                                password: passwordController.text,
                                verifyPassword: verifyController.text
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
