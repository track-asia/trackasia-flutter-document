import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia/app_bloc.dart';
import 'package:trackasia/app_state.dart';
import 'package:trackasia/utils/map_option_utils.dart';
import 'package:trackasia/utils/map_utils.dart';
import 'package:trackasia_gl/trackasia_gl.dart';

class TrackAsiaMapWidget extends StatefulWidget {
  const TrackAsiaMapWidget({super.key});

  @override
  State<TrackAsiaMapWidget> createState() => _TrackAsiaMapWidgetState();
}

class _TrackAsiaMapWidgetState extends State<TrackAsiaMapWidget> {
  String countryId = "vn";
  final initialLocation = const LatLng(16.25658, 106.31679);

  final double defaultZoomRate = 4.8;

  TrackasiaMapController? mapController;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    countryId = prefs.getString('country') ?? 'vn';
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is CountryUpdatedState) {
          countryId = state.selectedCountry;
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(MapHelper.getLatLng(countryId), MapHelper.zoom(countryId)),
          );
        } else if (state is PointUpdatedState) {
          mapController?.animateCamera(
            CameraUpdate.newLatLngZoom(state.point, state.zoom),
          );
          MapOptionHelper.addMarker(mapController, state.point);
        }
        return TrackasiaMap(
          styleString: MapHelper.getUrlStyle(countryId),
          compassEnabled: true,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          tiltGesturesEnabled: true,
          rotateGesturesEnabled: true,
          initialCameraPosition: MapHelper.getCameraPosition(countryId),
          onMapCreated: _onMapCreated,
          onMapClick: _onMapClick,
          onMapIdle: () {},
          onCameraTrackingChanged: (position) {},
          onCameraIdle: _onCameraIdleCallback,
          trackCameraPosition: true,
        );
      },
    );
  }

  void _onMapCreated(TrackasiaMapController controller) async {
    mapController = controller;
  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {}

  Future<void> _onCameraIdleCallback() async {}
}
