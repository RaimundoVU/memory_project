import 'dart:convert';
import 'dart:io';

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    // TODO: implement toString
    return 'Sugestion(description: $description, placeId: $placeId)';
  }
}