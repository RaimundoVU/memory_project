import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String asset;
  final Icon icon;
  final FlatButton button;
  final bool fill;
  const HomeCard({Key key, this.title, this.subtitle, this.asset, this.button, this.icon, this.fill})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
              leading: icon,
              title: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              Image.asset(asset, height: 140, width: 340, ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Text(subtitle),
              ),
              ButtonBar(
                children: [button],
              )
        ],
      ),
    );
  }
}
