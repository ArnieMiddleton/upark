import 'package:latlong2/latlong.dart';
import 'package:upark/client.dart';

// ignore: constant_identifier_names
enum StallType { ADA, A, CA, U, M, EV, CU, HU, HCU, SHU, V }

enum Permit {
  // ignore: constant_identifier_names
  ADA(name: 'ADA', stalls: [StallType.ADA]),
  // ignore: constant_identifier_names
  U(name: 'U', stalls: [StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  A(name: 'A', stalls: [StallType.A, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  HU(name: 'HU', stalls: [StallType.HU, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  CU(name: 'CU', stalls: [StallType.CU, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  HCU(
      name: 'HCU',
      stalls: [StallType.HCU, StallType.HU, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  CA(name: 'CA', stalls: [StallType.A, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  SHU(
      name: 'SHU',
      stalls: [StallType.SHU, StallType.HU, StallType.U, StallType.V]),
  // ignore: constant_identifier_names
  M(name: 'M', stalls: [StallType.M, StallType.V]),
  // ignore: constant_identifier_names
  Visitor(name: 'Visitor', stalls: [StallType.V]);

  final String name;
  final List<StallType> stalls;

  const Permit({
    required this.name,
    required this.stalls,
  });

  @override
  String toString() => name;
}

class Lot {
  int id;
  double latitude;
  double longitude;
  LatLng get location => LatLng(latitude, longitude);
  String name;
  int stallCount;
  int carCount;
  bool enabled;
  List<StallType> stalls = [StallType.V];

  Lot({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    required this.stallCount,
    required this.carCount,
    required this.enabled,
  });

  factory Lot.fromJson(Map<String, dynamic> json) => Lot(
        id: json["id"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        name: json["name"],
        stallCount: json["stall_count"],
        carCount: json["car_count"],
        enabled: json["enabled"] == 1 ? true : false,
      );

  Map<String, dynamic> toJson() => {
        "car_count": carCount,
        "enabled": enabled,
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "stall_count": stallCount,
      };
}

class Building {
  int id;
  double latitude;
  double longitude;
  LatLng get location => LatLng(latitude, longitude);
  String name;
  String? code;
  String? streetAddress;

  Building({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
    this.code,
    this.streetAddress,
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        id: json["id"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        name: json["name"],
        code: json["code"],
        streetAddress: json["street_address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "name": name,
        "code": code,
        "street_address": streetAddress,
      };
}

class Report {
  int id;
  String? latitude;
  String? longitude;
  int lotId;
  DateTime time;
  String approxFullness;
  int weight;

  Report({
    required this.approxFullness,
    required this.id,
    required this.lotId,
    required this.time,
    required this.weight,
    this.latitude,
    this.longitude,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        approxFullness: json["approx_fullness"],
        id: json["id"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lotId: json["lot_id"],
        time: DateTime.parse(json["time"]),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "approx_fullness": approxFullness,
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "lot_id": lotId,
        "time": time,
        "weight": weight,
      };
}

class Campus {
  String name = "University of Utah";
  List<Lot> lots = [];
  List<Building> buildings = [];
  Map<Building, Map<Lot, double>> buildingToLotDistances =
      {}; // Building -> Lot -> Distance in meters
  Map<Building, List<(Lot lot, double distance)>> buildingToClosestLots =
      {}; // Building -> List of sorted closest lots and their distances in meters
  // TODO: Add changing of units
  var unit = LengthUnit.Meter;

  Campus({
    required this.name,
    required this.lots,
    required this.buildings,
  });

  Map<Building, Map<Lot, double>> calculateDistances(
      List<Building> buildings, List<Lot> lots) {
    Map<Building, Map<Lot, double>> distances = {};
    Distance distance = const Distance();

    for (var building in buildings) {
      Map<Lot, double> buildingDistances = {};
      for (var lot in lots) {
        var distanceBetween =
            distance.as(unit, building.location, lot.location);
        buildingDistances[lot] = distanceBetween;
      }
      distances[building] = buildingDistances;
    }
    buildingToLotDistances = distances;
    return distances;
  }

  Map<Building, List<(Lot lot, double distance)>> calculateClosestLots(
      Map<Building, Map<Lot, double>> distances) {
    Map<Building, List<(Lot lot, double distance)>> closestLots = {};
    for (var building in distances.keys) {
      var buildingDistancesMap = distances[building]!;
      List<(Lot lot, double distance)> buildingClosestLots = [];
      for (var lot in buildingDistancesMap.keys) {
        buildingClosestLots.add((lot, buildingDistancesMap[lot]!));
      }
      buildingClosestLots.sort((a, b) => a.$2.compareTo(b.$2));
      closestLots[building] = buildingClosestLots;
    }
    buildingToClosestLots = closestLots;
    return closestLots;
  }

  static Future<Campus> getFromApi() async {
    var newLots = await fetchLots();
    var newBuildings = await fetchBuildings();
    return Campus(
      name: "University of Utah",
      lots: newLots,
      buildings: newBuildings,
    );
  }
}
