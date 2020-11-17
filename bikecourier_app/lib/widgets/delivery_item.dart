import 'package:bikecourier_app/models/delivery.dart';
import 'package:flutter/material.dart';

class DeliveryItem extends StatelessWidget {
  final Delivery delivery;
  final Function onDeleteDelivery;
  const DeliveryItem({Key key, this.delivery, this.onDeleteDelivery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Row(
        children: <Widget>[
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Column(
              children: [
                Text('Información del pedido',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Origen: ' + delivery.start.location),
                Text('Destino: ' + delivery.end.location),
                Text('Tipo de Objeto: ' + delivery.object.type),
                Text(delivery.status,
                    style: delivery.status == 'WAITING'
                        ? TextStyle(color: Colors.yellow)
                        : TextStyle(
                            color: Colors.green,
                          )),
              ],
            ),
          )),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              if (onDeleteDelivery != null) {
                onDeleteDelivery();
              }
            },
          ),
        ],
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          ]),
    );
  }
}
