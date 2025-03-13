import 'package:freezed_annotation/freezed_annotation.dart';

import 'geometry.dart';
import 'properties.dart';

part 'feature_model.freezed.dart';
part 'feature_model.g.dart';

@freezed
class FeatureModel with _$FeatureModel {
  factory FeatureModel({
    String? type,
    Geometry? geometry,
    Properties? properties,
  }) = _FeatureModel;

  factory FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$FeatureModelFromJson(json);
}
