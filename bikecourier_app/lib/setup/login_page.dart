import 'package:bikecourier_app/setup/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      width: MediaQuery.of(context).size.width / 2,
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
        FirebaseUser user = (await FirebaseAuth.instance
                .signInWithEmailAndPassword(
                    email: _email.trim(), password: _password.trim()))
            .user;
        if (user.isEmailVerified) {
          String userName;
          final DocumentReference document =
              Firestore.instance.collection("users").document(user.uid);
          await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
            userName = snapshot.data['name'];
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Home(user: user, userName: userName)));
        } else {
          print('not Vetified');
          _showDialog();
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Email no verificado"),
          content: new Text("Porfavor verifica tu correo."),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
