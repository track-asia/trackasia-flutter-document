import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:trackasia/model/feature_model/feature_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<FeatureModel>> autocomplete(String searchText) async {
    try {
      final response = await _dio.get(
        'https://maps.track-asia.com/api/v1/autocomplete',
        queryParameters: {
          'lang': 'vi',
          'key': 'public',
          'text': searchText,
        },
      );

      if (response.statusCode == 200) {
        try {
          log(response.data["features"].toString());
          final featuresList = (response.data["features"] as List<dynamic>).map((item) {
            return FeatureModel.fromJson(item);
          }).toList();
          return featuresList;
        } catch (e) {
          return [];
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
