import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class ForecastTileProvider implements TileProvider {
  final String _overlayType;

  ForecastTileProvider(this._overlayType);
  @override
  Future<Tile> getTile(int x, int y, int? zoom) async {
    Uint8List tileBytes = Uint8List(0);
    try {
      final url =
          "http://tile.openweathermap.org/map/$_overlayType/$zoom/$x/$y.png?&appid=1b1f336d07a1bece2c3728a25f60e393";
      final uri = Uri.parse(url);
      final imageData = await NetworkAssetBundle(uri).load("");
      tileBytes = imageData.buffer.asUint8List();
      //TilesCache.tiles[url] = tileBytes;
    } catch (e) {
      print(e.toString());
    }
    return Tile(256, 256, tileBytes);
  }
}
