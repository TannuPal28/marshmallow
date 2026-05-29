import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marshmallow/core/network/api_constants.dart';
import 'package:marshmallow/features/auth/data/models/location_response_model.dart';

class LocationRemoteDatasource {
  //Address to LAT LONG
  Future<LocationResponseModel?> getCoordinatesFromAddress(
      String address,) async {
    final url =
        "${ApiConstants.nominatimBaseUrl}"
        "${ApiConstants.searchLocation}"
        "?format=json"
        "&q=${Uri.encodeComponent(address)}"
        "&limit=1";

    final response = await http.get(
      Uri.parse(url),
      headers: {"User-Agent": "FlutterApp"},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        return LocationResponseModel.fromSearchJson(data[0]);
      }
    }
    return null;
  }

// LAT LONG -> ADDRESS

  Future<LocationResponseModel?> reverseGeocode(double lat,
      double lng) async {
    final url =
        "${ApiConstants.nominatimBaseUrl}"
        "${ApiConstants.reverseLocation}"
        "?format=json"
        "&lat=$lat"
        "&lon=$lng"
        "&zoom=18"
        "&addressdetails=1";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "User-Agent": "FlutterApp",
      },
    );
    if(response.statusCode ==200){
      final data= jsonDecode(response.body);
      return LocationResponseModel.fromReverseJson(data);
    }
    return null;
  }

}
