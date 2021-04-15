class User {
  final String id;
  final String fullName;
  final String email;
  final String rut;
  final String phoneNumber;
  final String userRole;
  final double currentLat;
  final double currentLng;

  User({this.id, this.rut, this.phoneNumber, this.fullName, this.email, this.userRole, this.currentLat, this.currentLng});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        rut = data['rut'],
        phoneNumber = data['phoneNumber'],
        fullName = data['fullName'],
        email = data['email'],
        userRole = data['userRole'],
        currentLat = data['currentLat'],
        currentLng = data['currentLng'];

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'fullName' : fullName,
      'rut': rut,
      'phoneNumber': phoneNumber,
      'email' : email,
      'userRole' : userRole,
      'currentLat' : currentLat,
      'currentLng' : currentLng,
    };
  }

}
