import 'package:bikecourier_app/setup/login_page.dart';
import 'package:bikecourier_app/setup/signup_page.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        decoration: BoxDecoration(color: Color.fromRGBO(255, 251, 193, 1.0)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 96,
                height: 96,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('INGRESAR'),
                  onPressed: navigateToSignIn,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: RaisedButton(
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('REGISTRARSE'),
                  onPressed: navigateToSignUp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToSignIn() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(), fullscreenDialog: true));
  }

  void navigateToSignUp() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SignUpPage()));
  }
}
