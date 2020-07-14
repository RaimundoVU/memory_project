import 'package:bikecourier_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  String _email, _password;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  
  Widget createLabel(double padding, String label) {
    return Padding(
      padding: EdgeInsets.only(top: padding),
      child: Text(label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          textAlign: TextAlign.center),
    );
  }

  Widget createEmailFormField(String hintText, bool isPassword) {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type some email'; 
        }
      },
      onSaved: (input) => _email = input,
      obscureText: isPassword,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  Widget createPasswordFormField(String hintText, bool isPassword) {
      return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type some password'; 
        }
      },
      onSaved: (input) => _password = input,
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
        onPressed: signIn,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 48),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(255, 251, 193, 1.0)),
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
                  createEmailFormField('usuario@ejemplo.com', false),
                  createLabel(15, 'CONTRASEÑA'),
                  createPasswordFormField('Contraseña', true),
                  createLoginButton(),
                ],
              )))),
    );
  }

  Future<void> signIn() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        print(_email);
        FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email.trim(), password: _password.trim())).user;
        Navigator.push(context, MaterialPageRoute(builder:  (context) => Home()));      
      } catch (e) {
        print(e.message);
      }
    }
  }
}
