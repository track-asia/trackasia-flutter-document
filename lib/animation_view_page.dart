import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'package:trackasia/utils/map_utils.dart';

class AnimationViewPage extends StatefulWidget {
  @override
  State<AnimationViewPage> createState() => _AnimationViewPageState();
}

class _AnimationViewPageState extends State<AnimationViewPage> {
  final initialLocation = const LatLng(16.25658, 106.31679);

  final double defaultZoomRate = 4.8;

  TrackAsiaMapController? mapController;

  String countryId = "vn";

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryId = prefs.getString('country') ?? 'vn';
  }

  @override
  Widget build(BuildContext context) {
    return TrackAsiaMap(
      styleString: MapHelper.getUrlStyle(countryId),
      compassEnabled: true,
      myLocationEnabled: true,
      tiltGesturesEnabled: true,
      scrollGesturesEnabled: true,
      initialCameraPosition: const CameraPosition(
          target: LatLng(15.7146441, 106.401633), zoom: 4.8),
      onMapCreated: _onMapCreated,
      onMapClick: _onMapClick,
      onMapIdle: () {},
      onCameraIdle: _onCameraIdleCallback,
      trackCameraPosition: true,
    );
  }

  void _onMapCreated(controller) async {
    mapController = controller;
  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {}

  Future<void> _onCameraIdleCallback() async {}
}
