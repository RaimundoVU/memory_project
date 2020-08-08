import 'package:bikecourier_app/models/DeliveryObject.dart';
import 'package:bikecourier_app/models/Direction.dart';
import 'package:bikecourier_app/utils/app_bar.dart';
import 'package:bikecourier_app/utils/sidedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ClientOrder extends StatefulWidget {
  final FirebaseUser user;
  final String userName;

  ClientOrder({Key key, this.user, this.userName});

  @override
  _ClientOrderState createState() => _ClientOrderState();
}

class _ClientOrderState extends State<ClientOrder> {
  int _currentStep = 0;
  bool completeStep = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static var _focusNodeDirection = new FocusNode();
  static var _focusNodeEnd = new FocusNode();
  static Direction directionData = new Direction();
  static DeliveryObject objectData = new DeliveryObject();

  List<Step> steps;

  @override
  void initState() {
    super.initState();
    _focusNodeDirection.addListener(() {
      setState(() {});
      print('Has focus: $_focusNodeDirection.hasFocus');
    });
    _focusNodeEnd.addListener(() {
      setState(() {});
      print('Has focus: $_focusNodeEnd.hasFocus');
    });
  }

  void _submitDetails() {
    final FormState formState = _formKey.currentState;
    if (!formState.validate()) {
      print("FAILURE");
    } else {
      formState.save();
      showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text("Details"),
            //content: new Text("Hello World"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new Text(
                      "Dirección de origen : " + directionData.originLocation),
                  new Text(
                      "Dirección de destino :" + directionData.endLocation),
                  new Text("Object info :" + objectData.objectType),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ));
    }
  }

  Widget createDirectionInput() {
    return TextFormField(
      focusNode: _focusNodeDirection,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe una dirección';
        }
      },
      onSaved: (String input) => directionData.originLocation = input,
      obscureText: false,
      decoration: InputDecoration(hintText: "Dirección de origen"),
    );
  }

  Widget createEndDirectionInput() {
    return TextFormField(
      focusNode: _focusNodeEnd,
      validator: (input) {
        if (input.isEmpty) {
          return 'Porfavor, escribe una dirección';
        }
      },
      onSaved: (String input) => directionData.endLocation = input,
      obscureText: false,
      decoration: InputDecoration(hintText: "Dirección de destino"),
    );
  }

  Widget createObjectTypeMenu() {
    List<String> objectTypes = <String>[
      "Llaves",
      "Cuadernos",
      "Comida",
      "Herramientas",
    ];
    print(objectTypes);
    return DropdownButton(
      hint: Text("Tipo de objeto"),
      value: objectData.objectType,
      items: objectTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (String newValue) {
        setState(() {
          objectData.objectType = newValue;
        });
      },
    );
  }

  nextStep() {
    _currentStep + 1 != steps.length ? goTo(_currentStep + 1) : _submitDetails();
  }

  goTo(int step) {
    setState(() => _currentStep = step);
  }

  cancel() {
    if (_currentStep > 0) {
      goTo(_currentStep - 1);
    }
  }

  Widget createStepper() {
    steps = <Step>[
      Step(
          title: Text("Dirección"),
          content: Column(
            children: <Widget>[
              createDirectionInput(),
              createEndDirectionInput()
            ],
          )),
      Step(
          title: Text("Objetos"),
          content: Column(
            children: <Widget>[createObjectTypeMenu()],
          )),
    ];

    return Stepper(
        steps: steps,
        currentStep: _currentStep,
        onStepContinue: nextStep,
        onStepCancel: cancel,
        onStepTapped: (step) => goTo(step));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(user: widget.user, userName: widget.userName),
        drawer: SideDrawer(user: widget.user),
        body: Form(
          key: _formKey,
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                children: <Widget>[
                  createStepper(),
                  // new RaisedButton(
                  //   child: new Text(
                  //     'Save details',
                  //     style: new TextStyle(color: Colors.white),
                  //   ),
                  //   onPressed: _submitDetails,
                  //   color: Colors.blue,
                  // ),
                ],
              )),
        ));
  }
}
