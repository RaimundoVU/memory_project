import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';

class Delivery {
  final String status;
  final String orderedBy;
  final String deliveredBy;

  final DeliveryLocation start;
  final DeliveryLocation end;
  final DeliveryObject object;

  Delivery(
      {this.status,
      this.orderedBy,
      this.deliveredBy,
      this.start,
      this.end,
      this.object});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'orderedBy': orderedBy,
      'deliveredBy': deliveredBy,
      'start': start.toMap(),
      'end': end.toMap(),
      'object': object.toMap(),
    };
  }

  static Delivery fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Delivery(
        status: map['status'],
        orderedBy: map['orderedBy'],
        deliveredBy: map['deliveredBy'],
        start: map['start'].fromMap(),
        end: map['end'].fromMap(),
        object: map['object'].fromMap());
  }
}
