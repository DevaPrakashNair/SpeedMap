class DirectionModel {
  DirectionModel({
      this.routes, 
      this.waypoints, 
      this.code, 
      this.uuid,});

  DirectionModel.fromJson(dynamic json) {
    if (json['routes'] != null) {
      routes = [];
      json['routes'].forEach((v) {
        routes?.add(Routes.fromJson(v));
      });
    }
    if (json['waypoints'] != null) {
      waypoints = [];
      json['waypoints'].forEach((v) {
        waypoints?.add(Waypoints.fromJson(v));
      });
    }
    code = json['code'];
    uuid = json['uuid'];
  }
  List<Routes>? routes;
  List<Waypoints>? waypoints;
  String? code;
  String? uuid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (routes != null) {
      map['routes'] = routes?.map((v) => v.toJson()).toList();
    }
    if (waypoints != null) {
      map['waypoints'] = waypoints?.map((v) => v.toJson()).toList();
    }
    map['code'] = code;
    map['uuid'] = uuid;
    return map;
  }

}

class Waypoints {
  Waypoints({
      this.distance, 
      this.name, 
      this.location,});

  Waypoints.fromJson(dynamic json) {
    distance = json['distance'];
    name = json['name'];
    location = json['location'] != null ? json['location'].cast<double>() : [];
  }
  num? distance;
  String? name;
  List<double>? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['distance'] = distance;
    map['name'] = name;
    map['location'] = location;
    return map;
  }

}

class Routes {
  Routes({
      this.countryCrossed, 
      this.weightName, 
      this.weight, 
      this.duration, 
      this.distance, 
      this.legs, 
      this.geometry,});

  Routes.fromJson(dynamic json) {
    countryCrossed = json['country_crossed'];
    weightName = json['weight_name'];
    weight = json['weight'];
    duration = json['duration'];
    distance = json['distance'];
    if (json['legs'] != null) {
      legs = [];
      json['legs'].forEach((v) {
        legs?.add(Legs.fromJson(v));
      });
    }
    geometry = json['geometry'] != null ? Geo.fromJson(json['geometry']) : null;
  }
  bool? countryCrossed;
  String? weightName;
  num? weight;
  num? duration;
  num? distance;
  List<Legs>? legs;
  Geo? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_crossed'] = countryCrossed;
    map['weight_name'] = weightName;
    map['weight'] = weight;
    map['duration'] = duration;
    map['distance'] = distance;
    if (legs != null) {
      map['legs'] = legs?.map((v) => v.toJson()).toList();
    }
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }

}

class Geo {
  Geo({
      this.coordinates, 
      this.type,});

  Geo.fromJson(dynamic json) {
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    type = json['type'];
  }
  List<double>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }

}

class Legs {
  Legs({
      this.viaWaypoints, 
      this.admins, 
      this.weight, 
      this.duration, 
      this.steps, 
      this.distance, 
      this.summary,});

  Legs.fromJson(dynamic json) {
    if (json['via_waypoints'] != null) {
      viaWaypoints = [];
      json['via_waypoints'].forEach((v) {
        viaWaypoints?.add(v);
      });
    }
    if (json['admins'] != null) {
      admins = [];
      json['admins'].forEach((v) {
        admins?.add(Admins.fromJson(v));
      });
    }
    weight = json['weight'];
    duration = json['duration'];
    if (json['steps'] != null) {
      steps = [];
      json['steps'].forEach((v) {
        steps?.add(Steps.fromJson(v));
      });
    }
    distance = json['distance'];
    summary = json['summary'];
  }
  List<dynamic>? viaWaypoints;
  List<Admins>? admins;
  num? weight;
  num? duration;
  List<Steps>? steps;
  num? distance;
  String? summary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (viaWaypoints != null) {
      map['via_waypoints'] = viaWaypoints?.map((v) => v.toJson()).toList();
    }
    if (admins != null) {
      map['admins'] = admins?.map((v) => v.toJson()).toList();
    }
    map['weight'] = weight;
    map['duration'] = duration;
    if (steps != null) {
      map['steps'] = steps?.map((v) => v.toJson()).toList();
    }
    map['distance'] = distance;
    map['summary'] = summary;
    return map;
  }
}

class Steps {
  Steps({
      this.intersections, 
      this.maneuver, 
      this.name, 
      this.duration, 
      this.distance, 
      this.drivingSide, 
      this.weight, 
      this.mode, 
      this.geometry,});

  Steps.fromJson(dynamic json) {
    if (json['intersections'] != null) {
      intersections = [];
      json['intersections'].forEach((v) {
        intersections?.add(Intersections.fromJson(v));
      });
    }
    maneuver = json['maneuver'] != null ? Maneuver.fromJson(json['maneuver']) : null;
    name = json['name'];
    duration = json['duration'];
    distance = json['distance'];
    drivingSide = json['driving_side'];
    weight = json['weight'];
    mode = json['mode'];
    geometry = json['geometry'] != null ? Geo.fromJson(json['geometry']) : null;
  }
  List<Intersections>? intersections;
  Maneuver? maneuver;
  String? name;
  num? duration;
  num? distance;
  String? drivingSide;
  num? weight;
  String? mode;
  Geo? geometry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (intersections != null) {
      map['intersections'] = intersections?.map((v) => v.toJson()).toList();
    }
    if (maneuver != null) {
      map['maneuver'] = maneuver?.toJson();
    }
    map['name'] = name;
    map['duration'] = duration;
    map['distance'] = distance;
    map['driving_side'] = drivingSide;
    map['weight'] = weight;
    map['mode'] = mode;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    return map;
  }

}

class Geo_2 {
  Geo_2({
      this.coordinates, 
      this.type,});

  Geo_2 .fromJson(dynamic json) {
    coordinates = json['coordinates'] != null ? json['coordinates'].cast<double>() : [];
    type = json['type'];
  }
  List<double>? coordinates;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['coordinates'] = coordinates;
    map['type'] = type;
    return map;
  }

}

class Maneuver {
  Maneuver({
      this.type, 
      this.instruction, 
      this.bearingAfter, 
      this.bearingBefore, 
      this.location,});

  Maneuver.fromJson(dynamic json) {
    type = json['type'];
    instruction = json['instruction'];
    bearingAfter = json['bearing_after'];
    bearingBefore = json['bearing_before'];
    location = json['location'] != null ? json['location'].cast<double>() : [];
  }
  String? type;
  String? instruction;
  int? bearingAfter;
  int? bearingBefore;
  List<double>? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['instruction'] = instruction;
    map['bearing_after'] = bearingAfter;
    map['bearing_before'] = bearingBefore;
    map['location'] = location;
    return map;
  }

}

class Intersections {
  Intersections({
      this.bearings, 
      this.entry, 
      this.mapboxStreetsV8, 
      this.isUrban, 
      this.adminIndex, 
      this.out, 
      this.geometryIndex, 
      this.location,});

  Intersections.fromJson(dynamic json) {
    bearings = json['bearings'] != null ? json['bearings'].cast<int>() : [];
    entry = json['entry'] != null ? json['entry'].cast<bool>() : [];
    mapboxStreetsV8 = json['mapbox_streets_v8'] != null ? MapboxStreetsV8.fromJson(json['mapbox_streets_v8']) : null;
    isUrban = json['is_urban'];
    adminIndex = json['admin_index'];
    out = json['out'];
    geometryIndex = json['geometry_index'];
    location = json['location'] != null ? json['location'].cast<double>() : [];
  }
  List<int>? bearings;
  List<bool>? entry;
  MapboxStreetsV8? mapboxStreetsV8;
  bool? isUrban;
  int? adminIndex;
  int? out;
  int? geometryIndex;
  List<double>? location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['bearings'] = bearings;
    map['entry'] = entry;
    if (mapboxStreetsV8 != null) {
      map['mapbox_streets_v8'] = mapboxStreetsV8?.toJson();
    }
    map['is_urban'] = isUrban;
    map['admin_index'] = adminIndex;
    map['out'] = out;
    map['geometry_index'] = geometryIndex;
    map['location'] = location;
    return map;
  }

}

class MapboxStreetsV8 {
  MapboxStreetsV8({
      this.c_lass,});

  MapboxStreetsV8.fromJson(dynamic json) {
    c_lass = json['class'];
  }
  String? c_lass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['class'] = c_lass;
    return map;
  }

}

class Admins {
  Admins({
      this.iso31661Alpha3, 
      this.iso31661,});

  Admins.fromJson(dynamic json) {
    iso31661Alpha3 = json['iso_3166_1_alpha3'];
    iso31661 = json['iso_3166_1'];
  }
  String? iso31661Alpha3;
  String? iso31661;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_3166_1_alpha3'] = iso31661Alpha3;
    map['iso_3166_1'] = iso31661;
    return map;
  }

}