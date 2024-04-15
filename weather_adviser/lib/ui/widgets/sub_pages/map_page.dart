import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'map_widget.dart';
import 'package:geolocator/geolocator.dart';

class MapPage extends StatelessWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(248, 54, 123, 219),
        title: const Text('Map'),
      ),
      body: Center(
        child: Text('abcccss'),
      ),
    );
  }
}
