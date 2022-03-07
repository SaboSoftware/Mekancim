import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:mekancimapp/models/place.dart';

const GOOGLE_API_KEY = 'AIzaSyDIHmjHtROLJJDokOygcWC37l4Y-Npp_pk';
double latitute = 0;
double longitude = 0;

class LocationHelper {
  static Future<dynamic> getRequest(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    try {
      if (response.statusCode == 200) {
        String jsonData = response.body;

        var decodeData = jsonDecode(jsonData);
        return decodeData;
      } else {
        return 'No Response';
      }
    } catch (err) {
      return 'Failed! No Response';
    }
  }

  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$latitude,$longitude&key=$GOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    String placeAddress =
        json.decode(response.body)['results'][0]['formatted_address'];

    Address userAddress = new Address();
    userAddress.latitude = lat;
    userAddress.longitude = lng;
    userAddress.placeName = placeAddress;
    return placeAddress;
  }

  static Future<String> getPlaceName(
      double lat, double lng, String text) async {
    String formattedText;
    if (text.contains('')) {
      formattedText = text.replaceAll(' ', '%20');
    } else {
      formattedText = text;
    }
    final url =
        'https://maps.googleapis.com/maps/api/place/textsearch/json?location=$lat%2C$lng&query=$formattedText&radius=100&key=$GOOGLE_API_KEY';
    final response = await http.get(Uri.parse(url));
    return json.decode(response.body)['results'][0]['name'];
  }

  static Future<LatLng> getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //Location için servis ayakta mı?
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    //konum izni kontrolü
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();

      if (_permissionGranted != PermissionStatus.GRANTED) {
        return null;
      }
    }

    //izinler tamam ise
    _locationData = await location.getLocation();
    latitute = _locationData.latitude;
    longitude = _locationData.longitude;
    return LatLng(latitute, longitude);
  }
}
