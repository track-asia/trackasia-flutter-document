# TrackAsia Flutter Demo Application

## Giới Thiệu

Đây là ứng dụng demo cho TrackAsia Flutter GL - một thư viện bản đồ mạnh mẽ dành cho ứng dụng Flutter. Ứng dụng demo này minh họa các tính năng chính của TrackAsia bao gồm hiển thị bản đồ, tìm kiếm địa chỉ, clustering, animation, và nhiều tính năng khác trên nhiều quốc gia khác nhau.

## Tính Năng Chính

- 🗺️ **Hiển thị bản đồ đa quốc gia**: Hỗ trợ Việt Nam, Singapore, Thailand, Taiwan, Malaysia
- 🔍 **Tìm kiếm địa chỉ**: Autocomplete với API geocoding
- 📍 **Định vị GPS**: Lấy vị trí hiện tại của người dùng
- 🎯 **Waypoint Navigation**: Tính năng điều hướng với điểm đi và điểm đến
- 🔘 **Clustering**: Hiển thị dữ liệu cluster từ API
- ✨ **Animation**: Demo các hiệu ứng animation trên bản đồ
- 📊 **Analytics**: Tích hợp RudderStack để theo dõi user behavior

## Mục Lục

1. [Yêu Cầu Hệ Thống](#yêu-cầu-hệ-thống)
2. [Cài Đặt](#cài-đặt)
3. [Cấu Trúc Dự Án](#cấu-trúc-dự-án)
4. [Các Trang Demo](#các-trang-demo)
5. [Cấu Hình Theo Nền Tảng](#cấu-hình-theo-nền-tảng)
6. [API và Services](#api-và-services)
7. [Xử Lý Sự Cố](#xử-lý-sự-cố)
8. [Tài Nguyên](#tài-nguyên)

## Yêu Cầu Hệ Thống

Trước khi chạy ứng dụng demo này, hãy đảm bảo bạn có:

- Flutter SDK đã cài đặt (phiên bản 2.18.6 hoặc cao hơn)
- Dart SDK 2.18.6 hoặc cao hơn
- Android Studio hoặc Xcode (cho development mobile)
- Hiểu biết cơ bản về phát triển Flutter

## Cài Đặt

### Bước 1: Clone Repository

```bash
git clone <repository-url>
cd trackasia-document-flutter-github
```

### Bước 2: Cài Đặt Dependencies

Ứng dụng sử dụng các dependencies chính sau:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # TrackAsia Core
  trackasia_gl: 2.0.3
  
  # State Management
  flutter_bloc: ^8.1.4
  
  # Location & Geocoding
  geolocator: ^11.0.0
  
  # Networking
  dio: ^4.0.0
  http: ^1.2.0
  
  # Data Persistence
  shared_preferences: ^2.0.0
  
  # Analytics
  rudder_sdk_flutter: ^3.1.0
  
  # UI & Utils
  flutter_screenutil: ^5.7.0
  textfield_tags: ^3.0.1
  dropdown_button2: ^2.3.9
  permission_handler: 10.2.0
  url_launcher: ^6.2.5
  intl: 0.18.0
  
  # JSON Serialization
  freezed: ^2.0.4
  json_serializable: ^6.2.0
```

Chạy lệnh sau để cài đặt dependencies:

```bash
flutter pub get
```

### Bước 3: Cấu Hình Platform

## Triển Khai Cơ Bản

### Bước 1: Import Package TrackAsia

Thêm dòng import sau vào file Dart của bạn:

```dart
import 'package:trackasia_gl/trackasia_gl.dart';
```

### Bước 2: Tạo Map Controller

Định nghĩa biến controller để quản lý bản đồ:

```dart
TrackasiaMapController? mapController;
```

### Bước 3: Triển Khai Widget Bản Đồ

Thêm widget TrackasiaMap vào phương thức build:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: TrackasiaMap(
      onMapCreated: _onMapCreated,
      styleString: "https://maps.track-asia.com/styles/v1/streets.json?key=public",
      initialCameraPosition: const CameraPosition(target: LatLng(16.25658, 106.31679), zoom: 4.8),
      onStyleLoadedCallback: _onStyleLoadedCallback,
    ),
  );
}
```

### Bước 4: Triển Khai Các Callback

Thêm các phương thức callback cần thiết:

```dart
void _onMapCreated(TrackasiaMapController controller) {
  mapController = controller;
}

void _onStyleLoadedCallback() {
  // Code thực thi sau khi style bản đồ được tải
  // Ví dụ: thêm markers, polylines, v.v.
}
```

## Tính Năng Nâng Cao

### Thêm Markers

Để thêm marker vào bản đồ:

```dart
Symbol addMarker(LatLng position) {
  final SymbolOptions symbolOptions = SymbolOptions(
    geometry: position,
    iconImage: 'marker-icon', // Đảm bảo asset này có sẵn
    iconSize: 1.5,
  );
  
  return mapController!.addSymbol(symbolOptions);
}
```

### Theo Dõi Vị Trí Người Dùng

Bật tính năng theo dõi vị trí người dùng:

```dart
TrackasiaMap(
  // Các thuộc tính khác...
  myLocationEnabled: true,
  myLocationTrackingMode: MyLocationTrackingMode.Tracking,
  myLocationRenderMode: MyLocationRenderMode.COMPASS,
)
```

### Điều Khiển Tương Tác Bản Đồ

Bật các điều khiển tương tác bản đồ:

```dart
TrackasiaMap(
  // Các thuộc tính khác...
  compassEnabled: true,
  zoomGesturesEnabled: true,
  tiltGesturesEnabled: true,
  rotateGesturesEnabled: true,
)
```

### Xử Lý Sự Kiện Click Bản Đồ

Xử lý sự kiện click trên bản đồ:

```dart
TrackasiaMap(
  // Các thuộc tính khác...
  onMapClick: (Point<double> point, LatLng coordinates) {
    // Xử lý sự kiện click
    print("Đã click tại: ${coordinates.latitude}, ${coordinates.longitude}");
  },
)
```

### Di Chuyển Camera

Điều khiển camera theo chương trình:

```dart
// Di chuyển camera đến vị trí cụ thể
mapController?.animateCamera(
  CameraUpdate.newLatLngZoom(LatLng(latitude, longitude), zoomLevel),
);

// Di chuyển camera để vừa với vùng giới hạn
mapController?.animateCamera(
  CameraUpdate.newLatLngBounds(
    LatLngBounds(
      southwest: LatLng(southwestLat, southwestLng),
      northeast: LatLng(northeastLat, northeastLng),
    ),
    left: 50,
    top: 50,
    right: 50,
    bottom: 50,
  ),
);
```

## Cấu Hình Theo Nền Tảng

### Cấu Hình Android

1. Cập nhật file `android/app/build.gradle`:

```gradle
android {
    // ...
    defaultConfig {
        // ...
        minSdkVersion 26
        // ...
    }
    // ...
}
```

2. Thêm các quyền sau vào `AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### Cấu Hình iOS

1. Cập nhật file `ios/Runner/Info.plist`:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Ứng dụng cần quyền truy cập vị trí khi đang mở.</string>
<key>io.flutter.embedded_views_preview</key>
<true/>
<key>MGLMapboxMetricsEnabledSettingShownInApp</key>
<true/>
```

2. Nếu bạn sử dụng Cocoapods, hãy đảm bảo có repository TrackAsia Cocoapods:
   [TrackAsia Cocoapods Repository](https://github.com/track-asia/trackasia-cocoapods)

### Cấu Hình Web

Đối với hỗ trợ web, đảm bảo bạn đã cài đặt và cấu hình đúng package `trackasia_gl_web`.

## Xử Lý Sự Cố

### Vấn Đề Thường Gặp

1. **Bản đồ không hiển thị**: Kiểm tra URL style và kết nối internet.
2. **Vị trí không hoạt động**: Kiểm tra cấu hình quyền truy cập.
3. **Markers không hiển thị**: Xác minh assets marker đã được thêm đúng cách.

### Mẹo Debug

- Sử dụng lệnh `print` hoặc logger để theo dõi các sự kiện vòng đời bản đồ.
- Kiểm tra console để xem thông báo lỗi liên quan đến TrackAsia.
- Xác minh tất cả dependencies đã được cài đặt và cập nhật đúng cách.

## Hình Ảnh Demo

<p align="center">
  <img src="https://git.advn.vn/sangnguyen/trackasia-document/-/raw/master/images/flutter_1.png" alt="FLUTTER" width="18%">   
  <img src="https://git.advn.vn/sangnguyen/trackasia-document/-/raw/master/images/flutter_2.png" alt="FLUTTER" width="18%">
  <img src="https://git.advn.vn/sangnguyen/trackasia-document/-/raw/master/images/flutter_3.png" alt="FLUTTER" width="18%">
  <img src="https://git.advn.vn/sangnguyen/trackasia-document/-/raw/master/images/flutter_4.png" alt="FLUTTER" width="18%">
</p>

## Tài Nguyên

### Repository Chính Thức

- [TrackAsia Flutter GL (Thư viện chính)](https://github.com/track-asia/trackasia-flutter-gl)
- [TrackAsia Cocoapods (Cài đặt iOS)](https://github.com/track-asia/trackasia-cocoapods)
- [TrackAsia Flutter Podspecs (Cấu hình Podspec)](https://github.com/track-asia/trackasia-flutter-podspecs)

### Dự Án Mẫu

Repository TrackAsia Flutter GL chứa các dự án mẫu minh họa các tính năng và trường hợp sử dụng khác nhau. Clone repository và khám phá các ví dụ để hiểu rõ hơn cách triển khai các tính năng cụ thể.

### Hỗ Trợ Cộng Đồng

Nếu bạn gặp vấn đề hoặc có câu hỏi, bạn có thể:
- Tạo issue trên GitHub repository
- Kiểm tra các issue hiện có để tìm giải pháp
- Đóng góp cho dự án bằng cách gửi pull requests

## Kết Luận

TrackAsia cung cấp giải pháp bản đồ mạnh mẽ cho ứng dụng Flutter với nhiều tính năng và tùy chọn tùy chỉnh. Bằng cách làm theo hướng dẫn này, bạn có thể tích hợp thành công TrackAsia vào dự án Flutter của mình và tận dụng các khả năng của nó để tạo trải nghiệm bản đồ hấp dẫn cho người dùng.