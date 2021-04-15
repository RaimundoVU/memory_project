import 'package:bikecourier_app/viewmodels/config_view_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class ConfigView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<ConfigViewModel>.withConsumer(
        viewModelBuilder: () => ConfigViewModel(),
        builder: (context, model, child) => Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.black,
                iconTheme: IconThemeData(color: Colors.white),
              ),
              body: ListView(
                children: [
                  Card(
                      child: ListTile(
                    title: Text('Añadir lugares favoritos'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print('favoritesplaces');
                      model.navigateToFavoritesPlaces();
                    },
                  )),
                  Card(
                      child: ListTile(
                    title: Text('Ver lugares favoritos'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print('favoritesplaces');
                      model.navigateToEditFavorites();
                    },
                  )),
                  Card(
                      child: ListTile(
                    title: Text('Cambiar contraseña'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print('contraseña');
                      model.navigateToChangePassword();
                    },
                  )),
                  Card(
                      child: ListTile(
                    title: Text('Editar perfil'),
                    trailing: Icon(Icons.arrow_forward),
                    onTap: () {
                      print('perfil');
                      model.navigateToEditProfile();
                    },
                  )),
                ],
              ),
            ));
  }
}
