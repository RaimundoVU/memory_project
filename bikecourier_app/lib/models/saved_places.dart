class SavedPlaces {
  String location = '';
  String name = '';
  double lat;
  double lng;
  String documentId;
  String userId;

  SavedPlaces({this.location, this.name, this.lat, this.lng, this.documentId, this.userId});

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'name': name,
      'lat': lat,
      'lng': lng,
      'userId': userId
    };
  }

  static SavedPlaces fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;
    return SavedPlaces(
      location: map['location'],
      name: map['name'],
      lat: map['lat'],
      lng: map['lng'],
      userId: map['userId'],
      documentId: documentId,
    );
  }
}
