import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/client/delivery_view_model.dart';
import 'package:bikecourier_app/widgets/busy_button.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class DeliveryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider.withConsumer(
      viewModelBuilder: () => DeliveryViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(35),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      'Información del envío',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                        child: ListTile(
                      title: Text('Dirección de origen'),
                      subtitle: model.start != null
                          ? Text("Dirección: " +
                              model.start.location +
                              "\nNotas: " +
                              model.start.notes)
                          : Text(""),
                    )),
                  ),
                  FlatButton(
                    onPressed: () {
                      model.navigateToCreateStart();
                    },
                    child: model.start != null
                        ? Text('Editar')
                        : Text('Seleccionar'),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                        child: ListTile(
                      title: Text('Dirección de destino'),
                      subtitle: model.end != null
                          ? Text("Dirección: " +
                              model.end.location +
                              "\nNotas: " +
                              model.end.notes)
                          : Text(""),
                    )),
                  ),
                  FlatButton(
                    onPressed: () {
                      model.navigateToCreateEnd();
                    },
                    child: model.end != null
                        ? Text('Editar')
                        : Text('Seleccionar'),
                  ),
                ],
              ),
              Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Row(
                children: [
                  Expanded(
                    child: Card(
                        child: ListTile(
                      title: Text('Objetos'),
                      subtitle: model.object != null
                          ? Text("Tipo: " +
                              model.object.type +
                              "\nTamaño: " +
                              model.object.size +
                              "\nNotas: " +
                              model.object.info)
                          : Text(""),
                    )),
                  ),
                  FlatButton(
                    onPressed: () {
                      model.navigateToCreateObject();
                    },
                    child: model.end != null
                        ? Text('Editar')
                        : Text('Seleccionar'),
                  ),
                ],
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
                      model.addDelivery();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
