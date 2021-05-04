import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/router.dart';
import 'package:bikecourier_app/services/dialog_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/services/push_notification_service.dart';
import 'package:bikecourier_app/views/startup_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'constants/route_names.dart';
import 'locator.dart';
import 'managers/dialog_manager.dart';
import 'setup/login_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  setupLocator();
  var handlerDocument = FirebaseFirestore.instance.collection('delivery');
  var delivery =
      await handlerDocument.doc(message.data['documentId']).get().then((value) {
    var test = value.data();
    print('_______');
    return test;
  });
  print('Información del delivery: ${delivery}');
  print('_______');
}

Future<void> main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courier App',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 9, 202, 172),
        backgroundColor: Color.fromARGB(255, 26, 27, 30),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Open Sans',
            ),
      ),
      home: StartUpView(),
      onGenerateRoute: generateRoute,
    );
  }
}
