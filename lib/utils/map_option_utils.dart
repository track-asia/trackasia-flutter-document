import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:trackasia_gl/trackasia_gl.dart';

class MapOptionHelper {
  static void addMarker(mapController, LatLng position) {
    mapController?.addSymbol(
      SymbolOptions(
        geometry: position,
        iconImage: 'location',
        iconSize: 2.0,
      ),
    );
  }

  static Future<Position?> getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      log("Vị trí hiện tại: ${position.latitude}, ${position.longitude}");
      return position;
    } catch (e) {
      log("Không thể lấy vị trí: $e");
    }
    return null;
  }
}
