import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget createLabel(double padding, String label) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Text(label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center),
    );
  }

  Widget createFormField(String hintText, bool isPassword) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  Widget createLoginButton() {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        color: Colors.black,
        textColor: Colors.white,
        child: Text('INGRESAR'),
        onPressed: () {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 48),
          decoration: BoxDecoration(color: Color.fromRGBO(255, 251, 193, 1.0)),
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 96,
                height: 96,
              ),
              createLabel(41, 'USUARIO'),
              createFormField('usuario@ejemplo.com', false),
              createLabel(15, 'CONTRASEÑA'),
              createFormField('Contraseña', true),
              createLoginButton(),
            ],
          ))),
    );
  }
}
