import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:user_app/provider/auth_provider.dart';

// For storing our result
class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  static final String androidKey = 'AIzaSyB3fSigu_W-20QYRUY8S2Fzxyc8-jdkSAU';
  static final String iosKey = 'YOUR_API_KEY_HERE';
  final apiKey = Platform.isAndroid ? androidKey : iosKey;

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

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

  Future<List<double>> getPlaceDetailFromId(
      BuildContext context, String placeId) async {
    print("placeId");
    print(placeId);
    final request =
        'https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&key=$apiKey';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        print(response.body.toString());
        print(result['result']['geometry']);
        print(result['result']['name']);
        print(result['result']['geometry']['location']);
        print(result['result']['geometry']['location']['lat']);
        print(result['result']['geometry']['location']['lng']);
        List<double> list = [];
        list.add(result['result']['geometry']['location']['lat']);
        list.add(result['result']['geometry']['location']['lng']);
        Provider.of<AuthProvider>(context, listen: false)
            .onchangeAddres(result['result']['name']);
        // compose suggestions in a list
        // return result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //
        //    .toList();
        return list;
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}
