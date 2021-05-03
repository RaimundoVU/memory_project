import 'dart:io';
import 'dart:math';
import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';
import 'package:bikecourier_app/services/authentication_service.dart';
import 'package:bikecourier_app/services/firestore_service.dart';
import 'package:bikecourier_app/services/navigation_service.dart';
import 'package:bikecourier_app/viewmodels/base_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../locator.dart';

class CreateObjectViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  DeliveryObject _edittingObject;
  String _selectedType = "Seleccionar tipo de objecto";
  String _selectedSize = "Seleccionar tamaño de objeto";
  String _imageUrl = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.incubaweb.com%2Fsubir-archivos-wordpress%2Fupload%2F&psig=AOvVaw3PCD9sv1kCCAelY0ItM_Cd&ust=1618625094558000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCMjK0MHWgfACFQAAAAAdAAAAABAD";
  
  String get selectedType => _selectedType;
  String get selectedSize => _selectedSize;
  String get imageUrl     => _imageUrl;

  void setEditting(DeliveryObject object) {
    _edittingObject = object;
  }

  void setSelectedType(String type) {
    _selectedType = type;
    notifyListeners();
  }

  String setSelectedSize(String size) {
    _selectedSize = size;
    notifyListeners();
  }

  String setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
    notifyListeners();
  }

  bool get _editting => _edittingObject != null;

  void addObject({String notes}) {
    DeliveryObject object =
        DeliveryObject(type: _selectedType, size: _selectedSize, info: notes, imageUrl: _imageUrl);
    _navigationService.popResult(object);
  }

  Future<Function> uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.camera);
      var file = File(image.path);
      if (image != null) {
        var r = Random();
        const _chars =
            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        var name =
            List.generate(15, (index) => _chars[r.nextInt(_chars.length)])
                .join();
        var sp =
            await _storage.ref().child('clientUploads/$name').putFile(file);
        var downloadUrl = await sp.ref.getDownloadURL();
        print('-------DOWNLOAD URL------');
        print(downloadUrl);
        setImageUrl(downloadUrl);
        notifyListeners();
      } else {
        print('no path received');
      }
    } else {
      print('Grant permissions and try again');
    }
  }
}
