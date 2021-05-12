import 'package:bikecourier_app/locator.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FirestoreService _firestoreService = locator<FirestoreService>();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  Future initialize() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
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
