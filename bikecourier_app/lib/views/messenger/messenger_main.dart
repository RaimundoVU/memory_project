import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessengerMain extends StatefulWidget {
  final User user;

  final String userName;
  MessengerMain({Key key, this.user, this.userName});
  @override
  _MessengerMainState createState() => _MessengerMainState();
}

class _MessengerMainState extends State<MessengerMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(user: widget.user, userName: widget.userName),
      drawer: SideDrawer(user: widget.user),
      body: Container(
        child: Text('Messenger view '),
      ),
    );
  }
}
