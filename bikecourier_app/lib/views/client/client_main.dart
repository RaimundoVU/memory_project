import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user, userName: widget.userName),
      drawer: SideDrawer(user: widget.user),
      body: Container(
        child: Text('Client view '),
      ),
    );;
  }
}
