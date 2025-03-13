import 'package:trackasia_gl/trackasia_gl.dart';

abstract class AppEvent {}

class UpdateCountryEvent extends AppEvent {
  final String selectedCountry;

  UpdateCountryEvent(this.selectedCountry);
}

class PointUpdatedEvent extends AppEvent {
  final LatLng point;
  final double zoom;

  PointUpdatedEvent(this.point, this.zoom);
}
