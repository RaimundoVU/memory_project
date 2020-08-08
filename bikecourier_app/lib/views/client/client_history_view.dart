import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientHistory extends StatefulWidget {
  final FirebaseUser user;
  final String userName;

  ClientHistory({Key key, this.user, this.userName});
  @override
  _ClientHistoryState createState() => _ClientHistoryState();
}

class _ClientHistoryState extends State<ClientHistory> {
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
                
                ],
              ),
            ),
          ),
        ));
  }
}