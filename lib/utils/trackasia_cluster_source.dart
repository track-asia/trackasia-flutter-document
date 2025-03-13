import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trackasia_gl/trackasia_gl.dart';
import 'trackasia_util.dart';

class TrackasiaClusterSource {
  //================MAP CHART LAYER==============//
  Future<void>? addTrackasiaClusterMap(
      {required TrackasiaMapController? mapController, required String sourceId, required Map<String, dynamic> dataMap, required String keyChartName}) async {
    final keyChartImageCircleRate = keyChartName + "_chart_image_circle_rate";
    final keyChartCircleRate = keyChartName + "_chart_circle_rate";
    final keyChartChildren = keyChartName + "_chart_circle_children";
    final keyChartCircleCount = keyChartName + "_chart_circle_count";
    if (dataMap.isNotEmpty) {
      dataMap["type"] = "FeatureCollection";
      await addClusteredPointSource(mapController: mapController, sourceId: sourceId, data: dataMap);
      await addClusteredPointLayers(
          mapController: mapController,
          dataMap: dataMap,
          sourceId: sourceId,
          keyChartImageCircleRate: keyChartImageCircleRate,
          keyChartCircleRate: keyChartCircleRate,
          keyChartChildren: keyChartChildren,
          keyChartCircleCount: keyChartCircleCount);
    }
  }

  Future<void>? addClusteredPointSource({required TrackasiaMapController? mapController, required String sourceId, required Map<String, dynamic>? data}) async {
    final sourceIds = await mapController?.getSourceIds();
    if (sourceIds?.contains(sourceId) == true) {
      if (data != null) {
        return mapController?.setGeoJsonSource(sourceId, data);
      }
    } else {
      return mapController?.addSource(
          sourceId,
          GeojsonSourceProperties(
            data: data,
            cluster: true,
          ));
    }
  }

  Future<void> addClusteredPointLayers(
      {required TrackasiaMapController? mapController,
      required Map<String, dynamic> dataMap,
      required String sourceId,
      required String keyChartImageCircleRate,
      required String keyChartCircleRate,
      required String keyChartChildren,
      required String keyChartCircleCount}) async {
    await addImageCircleRate(mapController: mapController, keyLayer: keyChartImageCircleRate);
    await addChartCircleRate(mapController: mapController, sourceId: sourceId, keyLayer: keyChartCircleRate, keyImage: keyChartImageCircleRate);
    await addChartChildren(mapController: mapController, sourceId: sourceId, keyLayer: keyChartChildren);
    await addCircleCount(mapController: mapController, sourceId: sourceId, keyLayer: keyChartCircleCount);
  }

  //================MAP CHART LAYER==============//

  //================MAP CHART ADD==============//
  Future<void> addImageCircleRate({required TrackasiaMapController? mapController, required String keyLayer}) async {
    final svgBytes = await TrackasiaUtils.createDonutChartPng(TrackasiaUtils.segments);
    if (svgBytes != null) {
      await removeLayer(mapController: mapController, keyLayer: keyLayer);
      await mapController?.addImage(keyLayer, svgBytes);
    }
  }

  Future<void> addChartCircleRate(
      {required TrackasiaMapController? mapController, required String sourceId, required String keyLayer, required String keyImage}) async {
    const pointKey = "point_count";
    await removeLayer(mapController: mapController, keyLayer: keyLayer);
    await mapController?.addSymbolLayer(
        sourceId,
        keyLayer,
        SymbolLayerProperties(
          textHaloWidth: 1,
          textSize: 6,
          iconImage: keyImage,
          iconSize: [
            Expressions.step,
            [Expressions.get, pointKey],
            0.8,
            100,
            1.0,
            400,
            1.0,
            600,
            1.2,
            800,
            1.2,
            1000,
            1.4
          ],
          iconAllowOverlap: true,
        ),
        filter: [Expressions.has, pointKey]);
  }

  Future<void> addChangeChartCircleRate(
      {required TrackasiaMapController? mapController,
      required String sourceId,
      required String keyLayer,
      required String keyImage,
      required String suggest}) async {
    await removeLayer(mapController: mapController, keyLayer: keyLayer);
    await mapController?.addLayer(
        sourceId,
        keyLayer,
        SymbolLayerProperties(
          iconImage: keyImage,
          iconAllowOverlap: true,
        ),
        filter: [
          '==',
          ['get', 'suggest'],
          suggest,
        ]);
  }

  Future<void> addCircleCount({required TrackasiaMapController? mapController, required String sourceId, required String keyLayer}) async {
    const pointKey = "point_count";
    const pointAbbreviated = "point_count_abbreviated";
    const font = "Roboto Regular";
    await removeLayer(mapController: mapController, keyLayer: keyLayer);
    await mapController?.addSymbolLayer(sourceId, keyLayer, const SymbolLayerProperties(textField: [Expressions.get, pointAbbreviated], textFont: [font]),
        filter: [Expressions.has, pointKey]);
  }

  Future<void> addChartChildren({required TrackasiaMapController? mapController, required String sourceId, required String keyLayer}) async {
    const pointKey = "point_count";
    await removeLayer(mapController: mapController, keyLayer: keyLayer);
    await mapController?.addCircleLayer(
        sourceId,
        keyLayer,
        CircleLayerProperties(circleColor: [
          'match',
          ['get', 'mag'],
          1,
          TrackasiaUtils.colors[0],
          2,
          TrackasiaUtils.colors[1],
          3,
          TrackasiaUtils.colors[2],
          4,
          TrackasiaUtils.colors[3],
          5,
          TrackasiaUtils.colors[4],
          100,
          TrackasiaUtils.colors[5],
          101,
          TrackasiaUtils.colors[6],
          102,
          TrackasiaUtils.colors[7],
          103,
          TrackasiaUtils.colors[8],
          200,
          TrackasiaUtils.colors[9],
          201,
          TrackasiaUtils.colors[10],
          202,
          TrackasiaUtils.colors[11],
          203,
          TrackasiaUtils.colors[12],
          204,
          TrackasiaUtils.colors[13],
          205,
          TrackasiaUtils.colors[14],
          TrackasiaUtils.colors[15],
        ], circleRadius: 10, circleStrokeWidth: 1, circleStrokeColor: "#FFA500"),
        filter: [
          "!",
          [Expressions.has, pointKey]
        ]);
  }

  Future<void> removeLayer({required TrackasiaMapController? mapController, required String keyLayer}) async {
    final sourceIds = await mapController?.getLayerIds();
    if (sourceIds?.contains(keyLayer) == true) {
      await mapController?.removeLayer(keyLayer);
    }
  }

  // Map<String, List<Map<String, dynamic>>> groupChartCircleData({required List<dynamic> dataMap}) {
  //   Map<String, List<Map<String, dynamic>>> groupedFeatures = {};
  //   for (Map<String, dynamic> feature in dataMap) {
  //     String suggest = feature['properties']['suggest'];
  //     if (groupedFeatures.containsKey(suggest)) {
  //       groupedFeatures[suggest]?.add(feature);
  //     } else {
  //       groupedFeatures[suggest] = [feature];
  //     }
  //   }
  //   return groupedFeatures;
  // }

  Future<void> addChangeChartCircleData({required TrackasiaMapController? mapController, required String sourceId, required List<dynamic> dataMap}) async {
    if (dataMap.isNotEmpty == true) {
      // final groupedFeatures = groupChartCircleData(dataMap: dataMap);
      // groupedFeatures.forEach((String suggest, List<Map<String, dynamic>> group) async {
      //   double percentage = (group.length / dataMap.length) * 100;
      //   Map<String, double> percentages = {};
      //   percentages[suggest] = percentage;
      //   for (String suggest in percentages.keys) {
      //     String keyLayer = createKeyLayer(suggest);
      //     String keyImage = createImageId(suggest);
      //     double percentage = percentages[suggest]!;
      //     var rnd = Random();
      //     Map<Color, double> segment = {TrackasiaUtils.colors[rnd.nextInt(4)]: percentage / 100}; // Chỉ sử dụng một màu sắc cho mỗi biểu đồ
      //     Uint8List? chartPng = await TrackasiaUtils.createDonutChartPng(segment);
      //     if (chartPng != null) {
      //       await mapController?.addImage(keyLayer, chartPng);
      //       addChangeChartCircleRate(sourceId: sourceId, mapController: mapController, keyLayer: keyLayer, keyImage: keyImage, suggest: suggest);
      //     }
      //   }
      // });
      for (Map<String, dynamic> feature in dataMap) {
        var rnd = Random();
        String id = feature['properties']['id'] ?? rnd.nextInt(1000);
        String keyLayer = createKeyLayer(id);
        // Map<Color, double> segment = {TrackasiaUtils.colors[rnd.nextInt(4)]: percentage / 100};
      }
    }
  }

  String createKeyLayer(String id) {
    return 'pet_chart_keylayer_circle_rate$id';
  }

  String createImageId(String suggest) {
    return 'pet_chart_image_circle_rate$suggest';
  }

  //================MAP CHART ADD==============//
}
