import 'package:flutter/material.dart';

class DrawerOption extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onTap;
  const DrawerOption({Key key, this.title, this.iconData, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(left: 25),
        height: 80,
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              size: 25,
            ),
            SizedBox(
              width: 25,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 21),
            ),
          ],
        ),
      ),
    );
  }
}
