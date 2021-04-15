import 'dart:convert';
import 'dart:io';

import 'package:bikecourier_app/models/Suggestion.dart';
import 'package:http/http.dart';

class Place {
  double lat;
  double lng;

  Place({this.lat, this.lng});

  @override
  String toString() {
    return 'Place(lat: $lat, lng: $lng)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyDdsRv69Vj2zLIoYCDt62AtB7JDvOU-HH8';
  static final String iosKey = 'AIzaSyDdsRv69Vj2zLIoYCDt62AtB7JDvOU-HH8';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        Uri.parse('https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=es&components=country:cl&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(request);
    print(response);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  Future<Place> getPlaceDetailFromId(String placeId) async {
    final request =
        Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_component,geometry&key=$apiKey&sessiontoken=$sessionToken');
    final response = await client.get(request);

    if (response.statusCode == 200) {
      print("----------------------");
      final result = json.decode(response.body);
      print(result);
      print("----------------------");

      if (result['status'] == 'OK') {
        final location =
            result['result']['geometry']['location'] as Map<String, dynamic>;
        // build result
        final place = Place();

        print("-----");

        location.forEach((key, value) {
          if (key == "lat") {
            place.lat = value;
          }
          if (key == "lng") {
            place.lng = value;
          }
        });
        print("-----");
        print(place.toString());
        print("-----");

        return place;
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
