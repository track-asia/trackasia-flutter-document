// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FeatureModel _$$_FeatureModelFromJson(Map<String, dynamic> json) =>
    _$_FeatureModel(
      type: json['type'] as String?,
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
      properties: json['properties'] == null
          ? null
          : Properties.fromJson(json['properties'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_FeatureModelToJson(_$_FeatureModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'geometry': instance.geometry,
      'properties': instance.properties,
    };
