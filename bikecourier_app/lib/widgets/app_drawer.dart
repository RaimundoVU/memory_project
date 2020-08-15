import 'package:bikecourier_app/constants/route_names.dart';
import 'package:bikecourier_app/locator.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/widgets/drawer_option.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  NavigationService _navigationService = locator<NavigationService>();
  AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          blurRadius: 16,
          color: Colors.black12,
        )
      ]),
      child: Column(children: getDrawerOptions()),
    );
  }

  List<Widget> getDrawerOptions() {
    return [
      DrawerOption(
        title: 'Configuración',
        iconData: Icons.settings,
      ),
      DrawerOption(
        title: 'Cerrar Sesión',
        iconData: Icons.power_settings_new,
        onTap: () {
          print('cerrar sesión');
          _authenticationService.signOut();
          _navigationService.navigateTo(LoginViewRoute);
        },
      ),
    ];
  }
}
