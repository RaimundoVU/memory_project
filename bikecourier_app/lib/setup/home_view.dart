import 'package:bikecourier_app/shared/ui_helpers.dart';
import 'package:bikecourier_app/viewmodels/home_view_model.dart';
import 'package:bikecourier_app/widgets/app_drawer.dart';
import 'package:bikecourier_app/widgets/home_card.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        drawer: AppDrawer(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    verticalSpace(35),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.send, color: Colors.black),
                            title: Text(
                              'Realizar envío',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset('assets/images/maps_photo.png',
                              height: 140, width: 340),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                  'Elige esta opción para realizar un envío a cualquier parte de la ciudad')),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('CONTINUAR',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  model.navigateToClientView();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const ListTile(
                            leading: Icon(Icons.directions_bike, color: Colors.black),
                            title: Text(
                              'Ser Mensajero',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Image.asset(
                            'assets/images/bikemessenger-photo.jpg',
                            fit: BoxFit.fill,
                          ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 18),
                              child: Text(
                                  'Elige esta opción para ser mensajero, solo necesitas tu bicicleta')),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                child: const Text('CONTINUAR',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
