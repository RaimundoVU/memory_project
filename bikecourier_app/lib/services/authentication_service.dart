import 'package:bikecourier_app/models/user.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../locator.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = locator<FirestoreService>();

  User _currentUser;
  User get currentUser => _currentUser;

  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!authResult.user.isEmailVerified) {
        return 'El usuario no ha verificado su correo.';
      }
      await _firestoreService.changeRole(uid: authResult.user.uid, role: 'CLIENT');
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  Future editUser({
    String uid,
    String fullName,
    String phoneNumber,
    String rut,
  }) async {
    try {
      await _firestoreService.editUser(
        uid: currentUser.id,
        fullName: fullName,
        rut: rut,
        phoneNumber: phoneNumber);
        await _populateCurrentUser(await _firebaseAuth.currentUser());
      return true;
    } catch (e) {
      return e.message;
    }
  }

  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (authResult.user != null) {
        authResult.user.sendEmailVerification();
      }
      _currentUser =
          User(id: authResult.user.uid, email: email, fullName: fullName);
      await _firestoreService.createUser(_currentUser);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }

  void signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser();
    await _populateCurrentUser(user);
    return user != null;
  }

  Future changePassword(String password) async {
    var user = await _firebaseAuth.currentUser();
    try {
      var result = await user.updatePassword(password);
      return result;
    } catch (e) {
      return e.message;
    }
  }

  Future resetPassword(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }
}
