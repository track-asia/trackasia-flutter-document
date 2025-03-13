import 'package:trackasia_gl/trackasia_gl.dart';

abstract class AppState {}

class InitialAppState extends AppState {
  InitialAppState();
}

class CountryUpdatedState extends AppState {
  final String selectedCountry;

  CountryUpdatedState(this.selectedCountry);
}

class PointUpdatedState extends AppState {
  final LatLng point;
  final double zoom;

  PointUpdatedState(this.point, this.zoom);
}
