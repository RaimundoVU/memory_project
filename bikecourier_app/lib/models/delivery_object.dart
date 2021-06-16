class DeliveryObject {
  final String type;
  final String size;
  final String info;
  final String imageUrl;

  DeliveryObject({this.type, this.size, this.info, this.imageUrl});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'size': size,
      'info': info,
      'imageUrl': imageUrl
    };
  }

  static DeliveryObject fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DeliveryObject(
        type: map['type'], size: map['size'], info: map['info'], imageUrl: map['imageUrl']);
  }
}
