import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/setup/home_view.dart';
import 'package:bikecourier_app/setup/login_view.dart';
import 'package:bikecourier_app/setup/signup_view.dart';
import 'package:bikecourier_app/views/client/client_main_view.dart';
import 'package:bikecourier_app/views/client/create_end_view.dart';
import 'package:bikecourier_app/views/client/create_object_view.dart';
import 'package:bikecourier_app/views/client/create_start_view.dart';
import 'package:bikecourier_app/views/client/delivery_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case ClientMainViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ClientMainView(),
      );
    case CreateStartViewRoute:
      var startToEdit = settings.arguments as DeliveryLocation;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateStartView(
          edittingStart: startToEdit,
        ),
      );
    case CreateEndViewRoute:
      var endToEdit = settings.arguments as DeliveryLocation;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateEndView(
          edittingEnd: endToEdit,
        ),
      );
    case CreateObjectViewRoute:
      var objectToEdit = settings.arguments as DeliveryObject;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateObjectView(
          edittingObject: objectToEdit,
        ),
      );
    case DeliveryViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DeliveryView(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
