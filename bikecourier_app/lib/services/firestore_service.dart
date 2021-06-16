import 'dart:async';

import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/saved_places.dart';
import 'package:bikecourier_app/models/user.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _deliveryCollectionReference =
      FirebaseFirestore.instance.collection('delivery');
  final CollectionReference _savedPlacesCollectionReference =
      FirebaseFirestore.instance.collection('savedPlaces');

  StreamController<List<Delivery>> _deliveryController =
      StreamController<List<Delivery>>.broadcast();
  StreamController<List<SavedPlaces>> _savedPlacesController =
      StreamController<List<SavedPlaces>>.broadcast();

  Future createUser(User user) async {
    try {
      await _userCollectionReference.doc(user.id).set(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _userCollectionReference.doc(uid).get();
      return User.fromData(userData.data());
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
          .doc(uid)
          .update({'userRole': role});
    } catch (e) {
      return e.message;
    }
  }

  Future addDeviceId({
    String uid,
    String deviceId
  }) async {
    try {
      var user = await _userCollectionReference
          .doc(uid)
          .update({'deviceId': deviceId});
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
      var user = await _userCollectionReference
          .doc(uid)
          .update({'phoneNumber': phoneNumber,
          'fullName': fullName,
          'rut': rut});
      return true;
    } catch (e) {
      return e.message;
    }
  }

  // Future getDeliveryOnceOff() async {
  //   try {
  //     var deliveryDocumentSnapshot =
  //         await _deliveryCollectionReference.getDocuments();
  //   } catch (e) {
  //     return e.message;
  //   }
  // }

  Stream listenToDeliveryRealTime(String id) {
    _deliveryCollectionReference.where("orderedBy", isEqualTo: id).snapshots().listen((deliverySnapshot) {
      if (deliverySnapshot.docs.isNotEmpty) {
        var deliveries = deliverySnapshot.docs
            .map((delivery) =>
                Delivery.fromMap(delivery.data(), delivery.id))
            .where((element) =>
                element.status != "DONE" && element.status != "CANCELED")
            .toList();

        _deliveryController.add(deliveries);
      }
    });

    return _deliveryController.stream;
  }

    Stream listenToSavedPlaces(String id) {
    _savedPlacesCollectionReference.where("orderedBy", isEqualTo: id).snapshots().listen((savedPlacesSnapshot) {
      if (savedPlacesSnapshot.docs.isNotEmpty) {
        var savedPlaces = savedPlacesSnapshot.docs
            .map((savedPlaces) =>
                SavedPlaces.fromMap(savedPlaces.data(), savedPlaces.id))
            .toList();

        _savedPlacesController.add(savedPlaces);
      }
    });

    return _savedPlacesController.stream;
  }

  Stream listenToDoneDeliveryRealTime(String id) {
    _deliveryCollectionReference.where("orderedBy", isNotEqualTo: id).snapshots().listen((deliverySnapshot) {
      if (deliverySnapshot.docs.isNotEmpty) {
        var deliveries = deliverySnapshot.docs
            .map((delivery) =>
                Delivery.fromMap(delivery.data(), delivery.id))
            .where((element) =>
                element.status == "DONE" || element.status == "CANCELED")
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
          .doc()
          .set(delivery.toMap())
          .toString();
      return true;
    } catch (e) {
      return e.message;
    }
  }

  Future deleteDelivery(String documentId) async {
    await _deliveryCollectionReference.doc(documentId).delete();
  }

  getDelivery(String documentId) async {
     try {
      var deliveryData = await _deliveryCollectionReference.doc(documentId).get();
      var delivery = Delivery.fromMap(deliveryData.data(), documentId);
      print("???");
      print(delivery.toMap());
      return delivery;
    } catch (e) {
      return e.message;
    }
  }

  Future addLocation(SavedPlaces place) async {
    try {
      if (place.name == null ||
          place.location == null ||
          place.lat == null ||
          place.lng == null) {
        return false;
      }
      await _savedPlacesCollectionReference
          .doc()
          .set(place.toMap())
          .toString();
      return true;
    } catch (e) {
      return e.message;
    }
  }
}

