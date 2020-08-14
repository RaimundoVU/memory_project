import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/client/create_object_view_model.dart';
import 'package:bikecourier_app/viewmodels/client/delivery_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:bikecourier_app/widgets/expansion_list.dart';
import 'package:bikecourier_app/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class CreateObjectView extends StatelessWidget {
  final notesController = TextEditingController();
  final DeliveryObject edittingObject;

  CreateObjectView({Key key, this.edittingObject}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModel: CreateObjectViewModel(),
      onModelReady: (model) {
        notesController.text = edittingObject?.info ?? '';
        model.setSelectedType(edittingObject?.type ?? 'Seleccionar tipo de objecto');
        model.setSelectedSize(edittingObject?.size ?? 'Seleccionar tamaño de objeto');
        model.setEditting(edittingObject);
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                verticalSpace(40),
                Text(
                  'Información de Objeto',
                  style: TextStyle(fontSize: 26),
                ),
                verticalSpaceMedium,
                ExpansionList<String>(
                  items: [
                    "Correspondencia",
                    "Vestimenta",
                    "Electrónica",
                    "Alimentos",
                    "Llaves",
                    "Libros",
                    "Otros"
                  ],
                  title: model.selectedType,
                  onItemSelected: (item) => model.setSelectedType(item),
                ),
                verticalSpaceMedium,
                ExpansionList<String>(
                  items: [
                    "Pequeño (20x10x6cm)",
                    "Mediano (30x20x12cm)",
                    "Grande  (40x30x18cm)"
                  ],
                  title: model.selectedSize,
                  onItemSelected: (item) => model.setSelectedSize(item),
                ),
                verticalSpaceMedium,
                InputField(
                  placeholder: 'Notas para el mensajero',
                  controller: notesController,
                  smallVersion: false,
                  additionalNote:
                      'Puntos de referencia, por quién preguntar, etc.',
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
                        model.addObject(
                          notes: notesController.text,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
