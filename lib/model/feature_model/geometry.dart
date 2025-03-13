import 'package:freezed_annotation/freezed_annotation.dart';

part 'geometry.freezed.dart';
part 'geometry.g.dart';

@freezed
class Geometry with _$Geometry {
  factory Geometry({
    String? type,
    List<double>? coordinates,
  }) = _Geometry;

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);
}
