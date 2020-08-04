import 'package:bikecourier_app/setup/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../setup/home_page.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _email, _password, _name, _parentLastName, _maternalLastName;
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

  Widget createParentLastNameFormField(String hintText, bool isPassword) {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type some lastname';
        }
      },
      onSaved: (input) => _parentLastName = input,
      obscureText: isPassword,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  Widget createMotherLastNameFormField(String hintText, bool isPassword) {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type some lastname';
        }
      },
      onSaved: (input) => _maternalLastName = input,
      obscureText: isPassword,
      decoration: InputDecoration(hintText: hintText),
    );
  }

  Widget createNameFormField(String hintText, bool isPassword) {
    return TextFormField(
      validator: (input) {
        if (input.isEmpty) {
          return 'Please type some name';
        }
      },
      onSaved: (input) => _name = input,
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

  Widget createRegisterButton() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        color: Colors.black,
        textColor: Colors.white,
        child: Text('REGISTRARSE'),
        onPressed: signUp,
      ),
    );
  }

  Widget createCancelButton() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.only(top: 15),
      child: RaisedButton(
        color: Colors.black,
        textColor: Colors.white,
        child: Text('CANCELAR'),
        onPressed: () => Navigator.pop(context, false),
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
                  child: SingleChildScrollView(
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
                    createLabel(15, 'NOMBRE'),
                    createNameFormField('Nombre', false),
                    createLabel(15, 'APELLIDO PATERNO'),
                    createParentLastNameFormField('Apellido Paterno', false),
                    createLabel(15, 'APELLIDO MATERNO'),
                    createMotherLastNameFormField('Apellido Materno', false),
                    createRegisterButton(),
                    createCancelButton()
                ],
              ),
                  )))),
    );
  }

  Future<void> signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email.trim(), password: _password.trim()))
            .user;
        Firestore.instance.collection('users').document(user.uid).setData({
          'uid': user.uid,
          'email': user.email,
          'name': _name,
          'parentLastName': _parentLastName.trim(),
          'maternalLastName': _maternalLastName.trim(),
        });
        user.sendEmailVerification();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      } catch (e) {
        print(e.message);
      }
    }
  }
}
