import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as _ui;

class TrackasiaUtils {
  static Future<Uint8List> svgToBytes(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    return byteData.buffer.asUint8List();
  }

  static final Map<Color, double> segments = {
    Colors.orange: 0.25,
    Colors.green: 0.25,
    Colors.blue: 0.25,
    Colors.yellow: 0.25,
  };

  static final List<String> colors = [
    '#0304af', '#0077b6', '#00b4d8', '#90e0ef', '#00ff99', // Cây lúa
    '#006600', '#004A5B', '#007369', '#02A676', // Cây cà phê
    '#99cc00', '#FFA500', '#FF8C00', '#FF7F50', '#FF6347', '#FF4500', // Cây tiêu
    '#00ff00' // Loại cây khác
  ];

  static Map<Color, double> createSegments(Map<String, double> percentages, List<Color> colors) {
    Map<Color, double> segments = {};
    int index = 0;
    percentages.forEach((_, double percentage) {
      segments[colors[index]] = percentage / 100; // Chia tỷ lệ về phạm vi [0, 1]
      index = (index + 1) % colors.length; // Sử dụng màu sắc tiếp theo hoặc quay lại đầu danh sách
    });
    return segments;
  }

  static Future<Uint8List?> createDonutChartPng(Map<Color, double> segments, {double width = 100, double height = 100, double strokeWidth = 20}) async {
    final double radius = min(width, height) / 2 - strokeWidth / 2;

    final _ui.PictureRecorder pictureRecorder = _ui.PictureRecorder();
    final _ui.Canvas canvas = _ui.Canvas(pictureRecorder);
    final _ui.Offset center = _ui.Offset(width / 2, height / 2);

    double startAngle = -pi / 2;
    segments.forEach((color, percentage) {
      final _ui.Paint paint = _ui.Paint()
        ..color = color
        ..style = _ui.PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      final double sweepAngle = 2 * pi * percentage;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    });

    final _ui.Image image = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
    final ByteData? byteData = await image.toByteData(format: _ui.ImageByteFormat.png);
    if (byteData != null) {
      return byteData.buffer.asUint8List();
    }
    return null;
  }
}
