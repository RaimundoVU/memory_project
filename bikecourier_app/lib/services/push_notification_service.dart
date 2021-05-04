import 'package:bikecourier_app/locator.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FirestoreService _firestoreService = locator<FirestoreService>();

  Future initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      //_firestoreService.getDelivery()
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    print('________________________');
    var token = await _firebaseMessaging.getToken();
    print(token);
    print('___________________');
  }
}
