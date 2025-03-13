import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackasia/constants.dart';
import 'package:trackasia/utils/trackasia_cluster_source.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'package:trackasia/utils/map_utils.dart';
import 'package:http/http.dart' as http;

class ClusterViewPage extends StatefulWidget {
  @override
  State<ClusterViewPage> createState() => _ClusterViewPageState();
}

class _ClusterViewPageState extends State<ClusterViewPage> {
  final initialLocation = const LatLng(16.25658, 106.31679);
  Map<String, dynamic> dataMap = {};
  final double defaultZoomRate = 4.8;
  TrackasiaClusterSource clusterSource = TrackasiaClusterSource();
  TrackasiaMapController? mapController;
  final sourceId = "trackasia_pet";
  final keyChartName = "pet";
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
      onStyleLoadedCallback: _onStyleLoadedCallback,
      trackCameraPosition: true,
    );
  }

  void _onMapCreated(TrackasiaMapController controller) async {
    mapController = controller;
  }

  void _onMapClick(Point<double> point, LatLng coordinates) async {}

  Future<void> _onCameraIdleCallback() async {}

  void _onStyleLoadedCallback() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Đang tải.."),
      backgroundColor: Theme.of(context).primaryColor,
      duration: const Duration(seconds: 1),
    ));
    await getClusterPoint();
  }

  Future<void> getClusterPoint() async {
    const apiPetMap = "https://panel.hainong.vn/api/v2/diagnostics/pets_map";
    final response = await http.get(Uri.parse(apiPetMap));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> features = data['features'] ?? [];
      final halfFeatures = features.take(features.length ~/ 2).toList();
      final partialData = {'type': 'FeatureCollection', 'features': halfFeatures};
      addResponseDataClusterMap(partialData);
    }
  }

  Future<void>? addResponseDataClusterMap(Map<String, dynamic> dataMap) async {
    if (dataMap.isNotEmpty) {
      dataMap["type"] = "FeatureCollection";
      clusterSource.addTrackasiaClusterMap(mapController: mapController, dataMap: dataMap, sourceId: sourceId, keyChartName: keyChartName);
    }
  }
}
