import 'package:freezed_annotation/freezed_annotation.dart';

part 'properties.freezed.dart';
part 'properties.g.dart';

@freezed
class Properties with _$Properties {
  factory Properties({
    String? id,
    String? name,
    String? street,
    String? label,
  }) = _Properties;

  factory Properties.fromJson(Map<String, dynamic> json) =>
      _$PropertiesFromJson(json);
}
