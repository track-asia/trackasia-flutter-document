// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feature_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) {
  return _FeatureModel.fromJson(json);
}

/// @nodoc
mixin _$FeatureModel {
  String? get type => throw _privateConstructorUsedError;
  Geometry? get geometry => throw _privateConstructorUsedError;
  Properties? get properties => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeatureModelCopyWith<FeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureModelCopyWith<$Res> {
  factory $FeatureModelCopyWith(
          FeatureModel value, $Res Function(FeatureModel) then) =
      _$FeatureModelCopyWithImpl<$Res, FeatureModel>;
  @useResult
  $Res call({String? type, Geometry? geometry, Properties? properties});

  $GeometryCopyWith<$Res>? get geometry;
  $PropertiesCopyWith<$Res>? get properties;
}

/// @nodoc
class _$FeatureModelCopyWithImpl<$Res, $Val extends FeatureModel>
    implements $FeatureModelCopyWith<$Res> {
  _$FeatureModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? geometry = freezed,
    Object? properties = freezed,
  }) {
    return _then(_value.copyWith(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      geometry: freezed == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Properties?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $GeometryCopyWith<$Res>? get geometry {
    if (_value.geometry == null) {
      return null;
    }

    return $GeometryCopyWith<$Res>(_value.geometry!, (value) {
      return _then(_value.copyWith(geometry: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PropertiesCopyWith<$Res>? get properties {
    if (_value.properties == null) {
      return null;
    }

    return $PropertiesCopyWith<$Res>(_value.properties!, (value) {
      return _then(_value.copyWith(properties: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_FeatureModelCopyWith<$Res>
    implements $FeatureModelCopyWith<$Res> {
  factory _$$_FeatureModelCopyWith(
          _$_FeatureModel value, $Res Function(_$_FeatureModel) then) =
      __$$_FeatureModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? type, Geometry? geometry, Properties? properties});

  @override
  $GeometryCopyWith<$Res>? get geometry;
  @override
  $PropertiesCopyWith<$Res>? get properties;
}

/// @nodoc
class __$$_FeatureModelCopyWithImpl<$Res>
    extends _$FeatureModelCopyWithImpl<$Res, _$_FeatureModel>
    implements _$$_FeatureModelCopyWith<$Res> {
  __$$_FeatureModelCopyWithImpl(
      _$_FeatureModel _value, $Res Function(_$_FeatureModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? geometry = freezed,
    Object? properties = freezed,
  }) {
    return _then(_$_FeatureModel(
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      geometry: freezed == geometry
          ? _value.geometry
          : geometry // ignore: cast_nullable_to_non_nullable
              as Geometry?,
      properties: freezed == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as Properties?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FeatureModel implements _FeatureModel {
  _$_FeatureModel({this.type, this.geometry, this.properties});

  factory _$_FeatureModel.fromJson(Map<String, dynamic> json) =>
      _$$_FeatureModelFromJson(json);

  @override
  final String? type;
  @override
  final Geometry? geometry;
  @override
  final Properties? properties;

  @override
  String toString() {
    return 'FeatureModel(type: $type, geometry: $geometry, properties: $properties)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FeatureModel &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.geometry, geometry) ||
                other.geometry == geometry) &&
            (identical(other.properties, properties) ||
                other.properties == properties));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, geometry, properties);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FeatureModelCopyWith<_$_FeatureModel> get copyWith =>
      __$$_FeatureModelCopyWithImpl<_$_FeatureModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeatureModelToJson(
      this,
    );
  }
}

abstract class _FeatureModel implements FeatureModel {
  factory _FeatureModel(
      {final String? type,
      final Geometry? geometry,
      final Properties? properties}) = _$_FeatureModel;

  factory _FeatureModel.fromJson(Map<String, dynamic> json) =
      _$_FeatureModel.fromJson;

  @override
  String? get type;
  @override
  Geometry? get geometry;
  @override
  Properties? get properties;
  @override
  @JsonKey(ignore: true)
  _$$_FeatureModelCopyWith<_$_FeatureModel> get copyWith =>
      throw _privateConstructorUsedError;
}
