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
        title: const Text('Weather Map'),
      ),
      body: Center(
        child: MapSample(),
      ),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(51.5052, 0.1276),
    zoom: 5,
  );

  Future<void> _animateToUser() async {
    final GoogleMapController controller = await _controller.future;
    Position pos = await Geolocator.getCurrentPosition();
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(pos.latitude, pos.longitude),
      zoom: 5,
    )));
  }

  Set<TileOverlay> _tileOverlays = {};
  String? _overlayType = 'precipitation_new';

  _initTiles() async {
    final String overlayId = DateTime.now().microsecondsSinceEpoch.toString();
    final tileOverlay = TileOverlay(
        tileOverlayId: TileOverlayId(overlayId),
        tileProvider: ForecastTileProvider(_overlayType!));
    setState(() {
      _tileOverlays = {tileOverlay};
    });
  }

  void _changeOverlayType(String? type) {
    setState(() {
      _overlayType = type;
      _tileOverlays.clear();
    });
    _initTiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text("Selected Overlay Type"),
              trailing: DropdownButton<String>(
                value: _overlayType,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Theme.of(context).primaryColor),
                underline: Container(
                  height: 2,
                  color: Theme.of(context).primaryColor,
                ),
                onChanged: (String? newValue) {
                  _changeOverlayType(newValue);
                },
                items: <String>[
                  'precipitation_new',
                  'wind_new',
                  'pressure_new',
                  'clouds_new',
                  'temp_new'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.replaceAll('_new', '').capitalize()),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _initialPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                _animateToUser();
                _initTiles();
              },
              tileOverlays: _tileOverlays,
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
