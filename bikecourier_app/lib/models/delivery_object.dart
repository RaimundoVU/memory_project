class DeliveryObject {
  final String type;
  final String size;
  final String info;

  DeliveryObject({this.type, this.size, this.info});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'size': size,
      'info': info,
    };
  }

  static DeliveryObject fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DeliveryObject(
        type: map['type'], size: map['size'], info: map['info']);
  }
}
