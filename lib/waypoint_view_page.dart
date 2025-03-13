import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter_mapbox_navigation/flutter_mapbox_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia/components/address_map_widget.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'package:trackasia/utils/map_utils.dart';

import 'utils/map_option_utils.dart';

class WayPointViewPage extends StatefulWidget {
  @override
  State<WayPointViewPage> createState() => _WayPointViewPageState();
}

class _WayPointViewPageState extends State<WayPointViewPage> {
  final initialLocation = const LatLng(16.25658, 106.31679);

  final double defaultZoomRate = 4.8;
  TrackasiaMapController? mapController;
  String countryId = "vn";
  bool? isShowAddressTo = true;

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
    return Stack(
      children: [
        TrackasiaMap(
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
        ),
        Stack(
          children: [
            AddressMapWidget(
              isShowLocation: true,
              title: "Nhập địa điểm đi",
              callBackSelectAddress: (point, title) {
                isShowAddressTo = false;
                mapController?.animateCamera(
                  CameraUpdate.newLatLngZoom(point, 12),
                );
                MapOptionHelper.addMarker(mapController, point);
              },
              callBackClear: () {
                isShowAddressTo = true;
              },
            ),
            Visibility(
              visible: isShowAddressTo ?? true,
              child: Positioned.fill(
                top: 60,
                child: AddressMapWidget(
                  isShowLocation: true,
                  title: "Nhập địa điểm đến",
                  callBackSelectAddress: (point, title) {
                    mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(point, 12),
                    );
                    MapOptionHelper.addMarker(mapController, point);
                  },
                ),
              ),
            ),
          ],
        ),
        Positioned(
            bottom: 0,
            width: 100,
            child: TextButton(
                onPressed: () {
                  // MapBoxNavigation.instance.setDefaultOptions(MapBoxOptions(
                  //     initialLatitude: 16.25658,
                  //     initialLongitude: 106.31679,
                  //     zoom: 13.0,
                  //     tilt: 0.0,
                  //     bearing: 0.0,
                  //     enableRefresh: false,
                  //     alternatives: true,
                  //     voiceInstructionsEnabled: true,
                  //     bannerInstructionsEnabled: true,
                  //     allowsUTurnAtWayPoints: true,
                  //     mode: MapBoxNavigationMode.drivingWithTraffic,
                  //     mapStyleUrlDay: MapHelper.getUrlStyle(countryId),
                  //     mapStyleUrlNight: MapHelper.getUrlStyle(countryId),
                  //     units: VoiceUnits.imperial,
                  //     simulateRoute: true,
                  //     language: "vn"));
                },
                child: const Text("Navigation")))
      ],
    );
  }

  void _onMapCreated(TrackasiaMapController controller) async {
    mapController = controller;
  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {}

  Future<void> _onCameraIdleCallback() async {}
}
