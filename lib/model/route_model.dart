class RouteModel {
  final String? geometry;
  final double? distance;
  final double? duration;
  final List<RouteLeg>? legs;
  final String? weightName;
  final double? weight;

  RouteModel({
    this.geometry,
    this.distance,
    this.duration,
    this.legs,
    this.weightName,
    this.weight,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      geometry: json['geometry'],
      distance: (json['distance'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
      legs: json['legs'] != null
          ? (json['legs'] as List).map((leg) => RouteLeg.fromJson(leg)).toList()
          : null,
      weightName: json['weight_name'],
      weight: (json['weight'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geometry': geometry,
      'distance': distance,
      'duration': duration,
      'legs': legs?.map((leg) => leg.toJson()).toList(),
      'weight_name': weightName,
      'weight': weight,
    };
  }
}

class RouteLeg {
  final double? distance;
  final double? duration;
  final String? summary;
  final List<RouteStep>? steps;

  RouteLeg({
    this.distance,
    this.duration,
    this.summary,
    this.steps,
  });

  factory RouteLeg.fromJson(Map<String, dynamic> json) {
    return RouteLeg(
      distance: (json['distance'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
      summary: json['summary'],
      steps: json['steps'] != null
          ? (json['steps'] as List).map((step) => RouteStep.fromJson(step)).toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'distance': distance,
      'duration': duration,
      'summary': summary,
      'steps': steps?.map((step) => step.toJson()).toList(),
    };
  }
}

class RouteStep {
  final String? geometry;
  final String? name;
  final double? distance;
  final double? duration;
  final String? drivingSide;
  final String? maneuver;
  final Instruction? instruction;

  RouteStep({
    this.geometry,
    this.name,
    this.distance,
    this.duration,
    this.drivingSide,
    this.maneuver,
    this.instruction,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    return RouteStep(
      geometry: json['geometry'],
      name: json['name'],
      distance: (json['distance'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toDouble(),
      drivingSide: json['driving_side'],
      maneuver: json['maneuver']?['type'],
      instruction: json['instruction'] != null
          ? Instruction.fromJson(json['instruction'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'geometry': geometry,
      'name': name,
      'distance': distance,
      'duration': duration,
      'driving_side': drivingSide,
      'maneuver': maneuver,
      'instruction': instruction?.toJson(),
    };
  }
}

class Instruction {
  final String? text;
  final String? type;

  Instruction({
    this.text,
    this.type,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      text: json['text'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type,
    };
  }
}

class WaypointModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final int order;
  final WaypointType type;

  WaypointModel({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.order,
    required this.type,
  });

  factory WaypointModel.fromLatLng(String name, double lat, double lng, int order, WaypointType type) {
    return WaypointModel(
      id: '${lat}_${lng}_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      latitude: lat,
      longitude: lng,
      order: order,
      type: type,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'order': order,
      'type': type.toString(),
    };
  }
}

enum WaypointType {
  origin,
  destination,
  waypoint,
}

class RouteInfo {
  final String distance;
  final String duration;
  final List<RouteStep> instructions;

  RouteInfo({
    required this.distance,
    required this.duration,
    required this.instructions,
  });

  static String formatDistance(double distanceInMeters) {
    if (distanceInMeters < 1000) {
      return '${distanceInMeters.toInt()} m';
    } else {
      return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
    }
  }

  static String formatDuration(double durationInSeconds) {
    final hours = (durationInSeconds / 3600).floor();
    final minutes = ((durationInSeconds % 3600) / 60).floor();
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}