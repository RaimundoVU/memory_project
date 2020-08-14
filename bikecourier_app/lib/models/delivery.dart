class Delivery {
  final String status;
  final String orderedBy;
  final String deliveredBy;
  final String startId;
  final String endId;
  final String objectId;

  Delivery(
      {this.status,
      this.orderedBy,
      this.deliveredBy,
      this.startId,
      this.endId,
      this.objectId});

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'orderedBy': orderedBy,
      'deliveredBy': deliveredBy,
      'startId': startId,
      'endId': endId,
      'objectId': objectId
    };
  }

  static Delivery fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Delivery(
      status: map['status'],
      orderedBy: map['orderedBy'],
      deliveredBy: map['deliveredBy'],
      startId: map['startId'],
      endId: map['endId'],
      objectId: map['objectId']
    );
  }
}
