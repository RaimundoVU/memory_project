import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/client/client_main_view_model.dart';
import 'package:bikecourier_app/widgets/app_drawer.dart';
import 'package:bikecourier_app/widgets/delivery_item.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ClientMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ClientMainViewModel>.reactive(
      viewModelBuilder: () => ClientMainViewModel(),
      onModelReady: (model) => model.listenToDeliveries(model.currentUser.id),
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(35),
              Row(
                children: [
                  SizedBox(
                    height: 20,
                    child: Text(
                      'Historial de Pedidos',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
              Expanded(
                child: model.deliveries != null
                    ? ListView.builder(
                        itemCount: model.deliveries.length,
                        itemBuilder: (context, index) => GestureDetector(
                              onTap: () => model.goToMap(index),
                              child: DeliveryItem(
                                delivery: model.deliveries[index],
                                onDeleteDelivery: () =>
                                    model.deleteDelivery(index),
                              ),
                            ))
                    : Center(
                        child: Text('Aun no has realizado ningún pedido.'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
