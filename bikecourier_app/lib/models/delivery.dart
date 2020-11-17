import 'package:bikecourier_app/models/delivery_location.dart';
import 'package:bikecourier_app/models/delivery_object.dart';

class Delivery {
  final String status;
  final String orderedBy;
  final String deliveredBy;
  final String documentId;

  final DeliveryLocation start;
  final DeliveryLocation end;
  final DeliveryObject object;

  Delivery(
      {this.status,
      this.orderedBy,
      this.deliveredBy,
      this.start,
      this.end,
      this.object,
      this.documentId});

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

  static Delivery fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;
    // print(map['start']);
    // DeliveryLocation localStart = DeliveryLocation.fromMap(map[])
    return Delivery(
      status: map['status'],
      orderedBy: map['orderedBy'],
      deliveredBy: map['deliveredBy'],
      start: DeliveryLocation.fromMap(map['start']),
      end: DeliveryLocation.fromMap(map['end']),
      object: DeliveryObject.fromMap(map['object']),
      documentId: documentId,
    );
  }
}
