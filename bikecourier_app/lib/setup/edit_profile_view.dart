import 'dart:math';
import 'package:bikecourier_app/models/user.dart';
import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/edit_profile_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/viewmodel_provider.dart';

class EditProfileView extends StatelessWidget {
  final fullNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final rutController = TextEditingController();
  final User edittingUser;
  EditProfileView({Key key, this.edittingUser}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<EditProfileViewModel>.withConsumer(
      viewModel: EditProfileViewModel(),
      onModelReady: (model) {
        fullNameController.text = edittingUser?.fullName ?? '';
        rutController.text = edittingUser?.rut ?? '';
        phoneNumberController.text = edittingUser?.phoneNumber ?? '';
        model.setEditting(edittingUser);
      },
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Editar Perfil',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Nombre completo',
                  controller: fullNameController,
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Rut',
                  controller: rutController,
                  isRut: true,
                  additionalNote: 'Rut debe ser en formato 11111111-1.',
                ),
                verticalSpaceSmall,
                InputField(
                  placeholder: 'Número de teléfono',
                  controller: phoneNumberController,
                  additionalNote: 'Número de teléfono debe incluir +569.',
                ),
                verticalSpaceSmall,
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BusyButton(
                      title: 'Listo',
                      busy: model.busy,
                      onPressed: () {
                        model.editUser(
                            fullName: fullNameController.text,
                            rut: rutController.text,
                            phoneNumber: phoneNumberController.text);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
