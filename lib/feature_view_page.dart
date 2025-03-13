import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia/constants.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'package:trackasia/utils/map_utils.dart';

class FeatureViewPage extends StatefulWidget {
  @override
  State<FeatureViewPage> createState() => _FeatureViewPageState();
}

class _FeatureViewPageState extends State<FeatureViewPage> {
  final initialLocation = const LatLng(16.25658, 106.31679);

  final double defaultZoomRate = 4.8;

  TrackasiaMapController? mapController;

  String countryId = "vn";

  @override
  void initState() {
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryId = prefs.getString('country') ?? 'vn';
  }

  @override
  Widget build(BuildContext context) {
    return TrackasiaMap(
      styleString: MapHelper.getUrlStyle(countryId),
      compassEnabled: true,
      tiltGesturesEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: const CameraPosition(target: LatLng(15.7146441, 106.401633), zoom: 4.8),
      onMapCreated: _onMapCreated,
      onMapClick: _onMapClick,
      onMapIdle: () {},
      onCameraIdle: _onCameraIdleCallback,
      trackCameraPosition: true,
    );
  }

  void _onMapCreated(TrackasiaMapController controller) async {
    mapController = controller;
  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {}

  Future<void> _onCameraIdleCallback() async {}
}
