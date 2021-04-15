import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/models/delivery.dart';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/setup/add_favorites_view.dart';
import 'package:bikecourier_app/setup/change_password_view.dart';
import 'package:bikecourier_app/setup/config_view.dart';
import 'package:bikecourier_app/setup/edit_favorites_view.dart';
import 'package:bikecourier_app/setup/edit_profile_view.dart';
import 'package:bikecourier_app/setup/home_view.dart';
import 'package:bikecourier_app/setup/login_view.dart';
import 'package:bikecourier_app/setup/reset_password_view.dart';
import 'package:bikecourier_app/setup/signup_view.dart';
import 'package:bikecourier_app/views/client/client_main_view.dart';
import 'package:bikecourier_app/views/client/client_view.dart';
import 'package:bikecourier_app/views/client/create_end_view.dart';
import 'package:bikecourier_app/views/client/create_object_view.dart';
import 'package:bikecourier_app/views/client/create_start_view.dart';
import 'package:bikecourier_app/views/client/delivery_map_view.dart';
import 'package:bikecourier_app/views/client/delivery_view.dart';
import 'package:flutter/material.dart';

import 'models/user.dart';
import 'views/client/confirm_location_view.dart';

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
    case ClientViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ClientView(),
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
    case ConfirmLocationViewRoute:
      print(settings.arguments);
      var arguments = settings.arguments as List;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ConfirmLocationView(
          type: arguments[0],
          lat: arguments[1],
          lng: arguments[2],
        )
      );
    case DeliveryMapViewRoute:
      var delivery = settings.arguments as Delivery;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: DeliveryMapView(
          delivery: delivery
        )
      );
    case ConfigViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: ConfigView()
        );
    case AddFavoritesViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: AddFavoritesView()
        );
    case ChangePasswordViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: ChangePasswordView()
        );
    case ResetPasswordViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: ResetPasswordView()
        );
    case EditFavoritesViewRoute:
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: EditFavoritesView()
        );
    case EditProfileViewRoute:
        var user = settings.arguments as User;
        return _getPageRoute(
          routeName: settings.name,
          viewToShow: EditProfileView(
            edittingUser: user,
          )
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
