class SavedPlaces {
  String location = '';
  String name = '';
  double lat;
  double lng;


  SavedPlaces({
    this.location,
    this.name,
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'name': name,
      'lat': lat,
      'lng': lng,
    };
  }

  static SavedPlaces fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return SavedPlaces(
      location: map['location'],
      name: map['name'],
      lat: map['lat'],
      lng: map['lng'],
    );
  }
}
