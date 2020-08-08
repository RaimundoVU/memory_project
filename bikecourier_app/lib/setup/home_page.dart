import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:bikecourier_app/views/client/client_main.dart';
import 'package:bikecourier_app/views/messenger/messenger_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final FirebaseUser user;
  final String userName;
  const Home({Key key, this.user, this.userName}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Widget createClientCard(FirebaseUser) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const ListTile(
        leading: Icon(Icons.drafts, color: Colors.black),
        title: Text('Realizar envío', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      Image.asset('assets/images/maps_photo.png', height: 140, width: 340),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
              'Elige esta opción para realizar un envío a cualquier parte de la ciudad')),
      ButtonBar(
        children: <Widget>[
          FlatButton(
            child: const Text('CONTINUAR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            onPressed: goToClientMain,
          ),
        ],
      ),
    ]));
  }

  Widget createMessengerCard(FirebaseUser user, String userName) {
    return Card(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
      const ListTile(
        leading: Icon(Icons.directions_bike, color: Colors.black),
        title: Text('Ser mensajero', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      Image.asset(
        'assets/images/bikemessenger-photo.jpg',
        fit: BoxFit.fill,
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Text(
              'Elige esta opción para ser mensajero, solo necesitas tu bicicleta')),
      ButtonBar(
        children: <Widget>[
          FlatButton(
            child: const Text('CONTINUAR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            onPressed: goToMessengerMain,
          ),
        ],
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideDrawer(user: widget.user),
        appBar: CustomAppBar(user: widget.user, userName: widget.userName),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 35),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  createClientCard(widget.user),
                  createMessengerCard(widget.user, widget.userName)
                ],
              ),
            ),
          ),
        ));
  }

  void goToMessengerMain() {
    updateUserRole(widget.user, 'messenger');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                MessengerMain(user: widget.user, userName: widget.userName)));
  }

  void goToClientMain() {
    updateUserRole(widget.user, 'client');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ClientMain(user: widget.user, userName: widget.userName)));
  }

  void updateUserRole(FirebaseUser user, String role) {
    final DocumentReference userRef =
        Firestore.instance.document('users/${user.uid}');
    Firestore.instance.runTransaction((Transaction tx) async {
      DocumentSnapshot userSnapshot = await tx.get(userRef);
      if (userSnapshot.exists) {
        await tx.update(userRef, <String, dynamic>{'role': role});
      }
    });
  }
}
