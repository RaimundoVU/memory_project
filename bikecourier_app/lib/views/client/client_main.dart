import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:bikecourier_app/views/client/client_history_view.dart';
import 'package:bikecourier_app/views/client/client_order_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientMain extends StatefulWidget {
  final FirebaseUser user;
  final String userName;

  ClientMain({Key key, this.user, this.userName});

  @override
  _ClientMainState createState() => _ClientMainState();
}

class _ClientMainState extends State<ClientMain> {
  Widget createOrderCard(FirebaseUser user, String userName) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const ListTile(
        leading: Icon(Icons.drafts, color: Colors.black),
        title: Text('Realizar pedido', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text('Seleccionar esta opción para realizar un pedido')),
      ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.arrow_forward, color: Colors.black),
            onPressed: goToClientOrder,
          ),
        ],
      ),
    ]));
  }

  Widget createHistoryCard(FirebaseUser user, String userName) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const ListTile(
        leading: Icon(Icons.assignment, color: Colors.black),
        title: Text('Ver historial de pedidos', style: TextStyle(fontWeight: FontWeight.bold), ),
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child:
              Text('Seleccionar esta opción para ver los pedidos realizados')),
      ButtonBar(
        children: <Widget>[
          FlatButton(
            child: Icon(Icons.arrow_forward, color: Colors.black,),
            onPressed: goToClientHistory
          ),
        ],
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(user: widget.user, userName: widget.userName),
        drawer: SideDrawer(user: widget.user),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createOrderCard(widget.user, widget.userName),
                  createHistoryCard(widget.user, widget.userName)
                ],
              ),
            ),
          ),
        ));
  }

  void goToClientOrder() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ClientOrder(user: widget.user, userName: widget.userName)));
  }

  void goToClientHistory() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
              ClientHistory(user: widget.user, userName: widget.userName)
      )
    );
  }
}
