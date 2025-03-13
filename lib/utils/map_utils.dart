import 'package:flutter/foundation.dart';
import 'package:trackasia/constants.dart';
import 'package:trackasia_gl/trackasia_gl.dart';

class MapHelper {
  static String urlStyle(String idCountry, {bool is3D = false}) {
    switch (idCountry) {
      case "vn":
        return is3D ? Constants.urlStyle3DVN : Constants.urlStyleVN;
      case "sg":
        return is3D ? Constants.urlStyle3DSG : Constants.urlStyleSG;
      case "th":
        return is3D ? Constants.urlStyle3DTH : Constants.urlStyleTH;
      case "tw":
        return is3D ? Constants.urlStyle3DTW : Constants.urlStyleTW;
      case "my":
        return is3D ? Constants.urlStyle3DMI : Constants.urlStyleMI;
      default:
        return is3D ? Constants.urlStyle3DVN : Constants.urlStyleVN;
    }
  }

  static String urlDomain(String idCountry) {
    switch (idCountry) {
      case "vn":
        return Constants.baseurl;
      case "sg":
        return Constants.baseurlSG;
      case "th":
        return Constants.baseurlTH;
      case "tw":
        return Constants.baseurlTW;
      case "my":
        return Constants.baseurlMI;
      default:
        return Constants.baseurl;
    }
  }

  static String getUrlStyle(String idCountry, {bool is3D = false}) {
    switch (idCountry) {
      case "vn":
        return is3D ? Constants.urlStyle3DVN : Constants.urlStyleVN;
      case "sg":
        return is3D ? Constants.urlStyle3DSG : Constants.urlStyleSG;
      case "th":
        return is3D ? Constants.urlStyle3DTH : Constants.urlStyleTH;
      case "tw":
        return is3D ? Constants.urlStyle3DTW : Constants.urlStyleTW;
      case "my":
        return is3D ? Constants.urlStyle3DMI : Constants.urlStyleMI;
      default:
        return is3D ? Constants.urlStyle3DVN : Constants.urlStyleVN;
    }
  }

  static CameraPosition getCameraPosition(String idCountry) {
    return CameraPosition(target: getLatLng(idCountry), zoom: zoom(idCountry));
  }

  static double zoom(String idCountry) {
    switch (idCountry) {
      case "vn":
      case "sg":
        return 10.0;
      case "th":
      case "tw":
      case "my":
        return 6.0;
      default:
        return 10.0;
    }
  }

  static String getNameCountry(String idCountry) {
    switch (idCountry) {
      case "vn":
        return "Việt Nam";
      case "sg":
        return "Singapore";
      case "th":
        return "Thailand";
      case "tw":
        return "Taiwan";
      case "my":
        return "Malaysia";
      default:
        return "Việt Nam";
    }
  }

  static LatLng getLatLng(String idCountry) {
    switch (idCountry) {
      case "vn":
        return const LatLng(10.728073, 106.624054);
      case "sg":
        return const LatLng(1.3302, 103.8104);
      case "th":
        return const LatLng(13.27, 101.96);
      case "tw":
        return const LatLng(23.670467, 120.960998);
      case "my":
        return const LatLng(3.5799465, 102.2791128);
      default:
        return const LatLng(10.728073, 106.624054);
    }
  }
}

void logDebug(dynamic message) {
  if (kDebugMode) {
    print("MAP=====$message");
  }
}
