import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 54, 123, 219),
        title: const Text('Life Indices'),
      ),
      body: Center(
        child: Text('1'),
      ),
    );
  }
}

Future<void> fetchData() async {
  final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  final String lat = position.latitude.toString();
  //print(lat);
  final String lon = position.longitude.toString();
  //print(lon);
  final geoUrl = Uri.parse(
      'https://geoapi.qweather.com/v2/city/lookup?location=$lon,$lat&key=3750971dc4f04622ad1ee2f8757e16ae');
  final geoResponse = await http.get(geoUrl);
  final locationData = json.decode(geoResponse.body)['location'][0];
  final locationid = locationData['id'];
  print(locationid);
}
