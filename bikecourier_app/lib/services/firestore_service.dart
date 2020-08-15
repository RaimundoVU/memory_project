import 'dart:async';

import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/user.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _deliveryCollectionReference =
      Firestore.instance.collection('delivery');

  StreamController<List<Delivery>> _deliveryController =
      StreamController<List<Delivery>>.broadcast();

  Future createUser(User user) async {
    try {
      await _userCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _userCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future changeRole({
    String uid,
    String role,
  }) async {
    try {
      var user = await _userCollectionReference
          .document(uid)
          .updateData({'userRole': role});
    } catch (e) {
      return e.message;
    }
  }

  Future getDeliveryOnceOff() async {
    try {
      var deliveryDocumentSnapshot =
          await _deliveryCollectionReference.getDocuments();
    } catch (e) {
      return e.message;
    }
  }

  Stream listenToDeliveryRealTime(String id) {
    _deliveryCollectionReference.snapshots().listen((deliverySnapshot) {
      if (deliverySnapshot.documents.isNotEmpty) {
        var deliveries = deliverySnapshot.documents
            .map((delivery) => Delivery.fromMap(delivery.data))
            .where((element) =>
                element.orderedBy != null )
            .toList();

        _deliveryController.add(deliveries);
      }
    });

    return _deliveryController.stream;
  }

  Future addDelivery(Delivery delivery) async {
    try {
      if (delivery.start == null ||
          delivery.object == null ||
          delivery.end == null) {
        return false;
      }
      await _deliveryCollectionReference
          .document()
          .setData(delivery.toMap())
          .toString();
      return true;
    } catch (e) {
      return e.message;
    }
  }
}
