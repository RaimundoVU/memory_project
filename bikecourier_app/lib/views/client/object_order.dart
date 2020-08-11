import 'package:bikecourier_app/models/DeliveryObject.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ListItem {
  int value;
  String name;

  ListItem(this.value, this.name);
}

class ObjectOrder extends StatefulWidget {
  final DeliveryObject deliveryObject;
  final FirebaseUser user;
  ObjectOrder({Key key, this.user, this.deliveryObject});

  @override
  _ObjectOrderState createState() => _ObjectOrderState();
}

class _ObjectOrderState extends State<ObjectOrder> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _objectType;
  String _objectSize;
  String _objectInfo;

  List<ListItem> _dropdownItems = [
    ListItem(1, "Correspondencia"),
    ListItem(2, "Vestimenta"),
    ListItem(3, "Electrónica"),
    ListItem(4, "Alimentos"),
    ListItem(5, "Llaves"),
    ListItem(6, "Libros"),
    ListItem(7, "Otros")
  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItems;
  ListItem _selectedItem;

  List<ListItem> _dropdownItemsSize = [
    ListItem(8, "Pequeño (20x10x6cm)"),
    ListItem(9, "Mediano (30x20x12cm)"),
    ListItem(10, "Grande  (40x30x18cm)"),
  ];
  List<DropdownMenuItem<ListItem>> _dropdownMenuItemsSize;
  ListItem _selectedItemSize;

  @override
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(_dropdownItems);
    _selectedItem = null;
    _dropdownMenuItemsSize = buildDropDownMenuItems(_dropdownItemsSize);
    _selectedItemSize = null;
  }

  List<DropdownMenuItem<ListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<ListItem>> items = List();
    for (ListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  Widget createNotesInput() {
    return TextFormField(
      // focusNode: _focusNodeDirection,
      initialValue: widget.deliveryObject.extraInfo,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe notas';
        }
      },
      onSaved: (input) => _objectInfo = input,
      obscureText: false,
      decoration: InputDecoration(
          labelText: 'Notas del objeto',
          labelStyle: TextStyle(color: Colors.black),
          hintText: "Notas para el mensajero"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.black),
        backgroundColor: Color.fromRGBO(255, 251, 193, 1.0),
        title: Text(
          '',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20.0, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          children: [
            DropdownButton<ListItem>(
              isExpanded: true,
              hint: Text('Seleccionar tipo de encomienda'),
              value: _selectedItem,
              items: _dropdownMenuItems,
              onChanged: (value) {
                print('value:' + value.name.toString());
                setState(() {
                  _selectedItem = value;
                  widget.deliveryObject.objectType = value.name;
                });
              },
            ),
            DropdownButton<ListItem>(
              isExpanded: true,
              hint: Text('Seleccionar tamaño de encomienda'),
              value: _selectedItemSize,
              items: _dropdownMenuItemsSize,
              onChanged: (value) {
                print('value:' + value.name.toString());
                setState(() {
                  _selectedItemSize = value;
                  widget.deliveryObject.objectSize = value.name;
                });
              },
            ),
            Form(
              key: _formKey,
              child: createNotesInput(),
            ),
            RaisedButton(
                child: Text(
                  'Listo',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.black,
                onPressed: () {
                  _submit(context);
                })
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        widget.deliveryObject.extraInfo = _objectInfo;
      });
    }
    print(widget.deliveryObject.extraInfo);
    Navigator.pop(context, widget.deliveryObject);
  }
}
