import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final User user;
  String userName;
  CustomAppBar({Key key, this.user, this.userName})
      : super(
          key: key,
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Color.fromRGBO(255, 251, 193, 1.0),
          title: Text(
            'Bienvenid@, ${userName}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.black),
          ),
        );

}
