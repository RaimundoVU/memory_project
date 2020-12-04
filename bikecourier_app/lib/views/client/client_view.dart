import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/client/client_main_view_model.dart';
import 'package:bikecourier_app/views/client/client_main_view.dart';
import 'package:bikecourier_app/views/client/client_main_view_done.dart';
import 'package:bikecourier_app/widgets/app_drawer.dart';
import 'package:flutter/material.dart';

import '../../locator.dart';

class ClientView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClientViewState();
}

class _ClientViewState extends State<ClientView>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  ClientMainViewModel model = new ClientMainViewModel();
  int _selectedIndex = 0;
  List<Widget> list = [
    Tab(
        child: Text(
      "Pendientes",
      style: TextStyle(color: Colors.white),
    )),
    Tab(
        child: Text(
      "Completados",
      style: TextStyle(color: Colors.white),
    )),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          model.navigateToCreateDelivery();
        },
      ),
      appBar: AppBar(
        bottom: TabBar(
          onTap: (index) {},
          controller: _controller,
          tabs: list,
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: TabBarView(
        controller: _controller,
        children: [
          Center(child: ClientMainView()),
          Center(child: ClientMainDoneView())
        ],
      ),
    );
  }
}
