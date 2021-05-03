import 'package:bikecourier_app/models/delivery.dart';
import 'package:flutter/material.dart';

class DeliveryItem extends StatelessWidget {
  final Delivery delivery;
  final Function onDeleteDelivery;
  const DeliveryItem({Key key, this.delivery, this.onDeleteDelivery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Container(
                  child: getText(delivery.status),
                )
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

  Widget getText(String status) {
    if (status == "WAITING") {
      return Chip(
          backgroundColor: Color(0xFF5f65d3),
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
          label: Text(
            "EN ESPERA",
            style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
          )
      );
    }
    if (status == "CANCELED") {
      return Chip(
          backgroundColor: Color(0xFFff6666),
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
          label: Text(
            "CANCELADO",
            style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
          )
      );
    }
    if (status == "DONE") {
      return Chip(
          backgroundColor: Color(0xFF19ca21),
          padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
          label: Text(
            "COMPLETADO",
            style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
          )
      );
    }
  }
}
