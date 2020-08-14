class DeliveryLocation {
  String location = '';
  double lat;
  double lng;
  String notes = '';
  String deliveryId = '';

  DeliveryLocation({this.location, this.lat, this.lng, this.notes, this.deliveryId});
  
  Map<String, dynamic> toMap(){
    return {
      'location': location,
      'lat': lat,
      'lng': lng,
      'notes': notes,
      'deliveryId': deliveryId
    };
  }

  static DeliveryLocation fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return DeliveryLocation(
      location: map['location'],
      lat: map['lat'],
      lng: map['lng'],
      notes: map['notes'],
      deliveryId: map['deliveryId']
    );
  }

}