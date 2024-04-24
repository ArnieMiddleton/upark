import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:latlong2/latlong.dart';
import 'package:upark/client.dart';

enum StallType {
// ignore: constant_identifier_names
  ADA(name: 'Disabled Parking'),
// ignore: constant_identifier_names
  A(name: 'A Permit'),
// ignore: constant_identifier_names
  CA(name: 'Central Garage A Permit'),
// ignore: constant_identifier_names
  U(name: 'U Permit'),
// ignore: constant_identifier_names
  M(name: 'Motorcycle Permit'),
// ignore: constant_identifier_names
  EV(name: 'Electric Vehicle Permit'),
// ignore: constant_identifier_names
  CU(name: 'Central Garage U Permit'),
// ignore: constant_identifier_names
  HU(name: 'Housing U Permit'),
// ignore: constant_identifier_names
  HCU(name: 'Housing Central Garage U Permit'),
// ignore: constant_identifier_names
  SHU(name: 'Shoreline Garage U Permit'),
// ignore: constant_identifier_names
  V(name: 'Visitor Parking');

  final String name;

  const StallType({
    required this.name,
  });
}

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
  List<StallType> stalls = [StallType.V, StallType.U, StallType.ADA];

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

class AppUser {
  String id;
  String email;
  String name;
  Permit permit;
  bool colorblind;

  AppUser({
    required this.id,
    this.email = '',
    this.name = '',
    this.permit = Permit.Visitor,
    this.colorblind = false,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        colorblind: json["colorblind"] == 1 ? true : false,
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "colorblind": colorblind,
        "id": id,
        "name": name,
      };
}

class Report {
  int? id;
  double? latitude;
  double? longitude;
  LatLng? get location => latitude == null
      ? null
      : longitude == null
          ? null
          : LatLng(latitude!, longitude!);
  set location(LatLng? location) {
    if (location == null) {
      latitude = null;
      longitude = null;
      return;
    }
    latitude = location.latitude;
    longitude = location.longitude;
  }

  int lotId;
  DateTime time;
  double approxFullness;
  int weight;

  Report({
    required this.approxFullness,
    required this.lotId,
    required this.time,
    required this.weight,
    this.id,
    this.latitude,
    this.longitude,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
        approxFullness: double.parse(json["approx_fullness"]),
        id: json["id"],
        latitude: double.parse(json["latitude"]),
        longitude: double.parse(json["longitude"]),
        lotId: json["lot_id"],
        time: DateTime.parse(json["time"]),
        weight: json["weight"],
      );

  Map<String, dynamic> toJson(AppUser user) => {
        "approx_fullness": approxFullness,
        "lot_id": lotId,
        "user_id": user.id,
        "time": time.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Campus {
  String name = "University of Utah";
  AppUser user;
  List<Lot> lots;
  List<Building> buildings;
  // Map<Building, List<(Lot, int)>> buildingClosestLots = {};

  Campus({
    required this.name,
    required this.user,
    required this.lots,
    required this.buildings,
    // required this.buildingClosestLots,
  });

  static Future<Campus> getFromApi() async {
    List<Lot> newLots = [];
    List<Building> newBuildings = [];
    AppUser newUser = AppUser(id: '');
    // Map<Building, List<(Lot, int)>> newBuildingClosestLots = {};
    try {
      newLots = await fetchLots();
    } catch (e) {
      log('Failed to fetch lots with error: $e');
    }
    try {
      newBuildings = await fetchBuildings();
    } catch (e) {
      log('Failed to fetch buildings with error: $e');
    }
    try {
      var authUser = FirebaseAuth.instance.currentUser;
      if (authUser != null) {
        newUser = await fetchUserFromId(authUser.uid);
      }
    } catch (e) {
      print('Failed to fetch user with error: $e');
      log('Failed to fetch user with error: $e');
    }
    // try {
    //   for (var building in newBuildings) {
    //     var closestDistances = await fetchDistancesByBuilding(building);
    //     List<(Lot, int)> closestLots = [];
    //     for (var lotIdDistTuple in closestDistances) {
    //       var lot = newLots.firstWhere((lot) => lot.id == lotIdDistTuple.$1);
    //       closestLots.add((lot, lotIdDistTuple.$2));
    //     }
    //     newBuildingClosestLots[building] = closestLots;
    //   }
    // } catch (e) {
    //   print('Failed to fetch closest lots with error: $e');
    //   log('Failed to fetch closest lots with error: $e');
    // }
    return Campus(
      name: "University of Utah",
      user: newUser,
      lots: newLots,
      buildings: newBuildings,
      // buildingClosestLots: newBuildingClosestLots,
    );
  }

  Future<bool> updateCampusFromApi() async {
    bool success = true;
    try {
      Campus newCampus = await Campus.getFromApi();
      user = newCampus.user;
      lots = newCampus.lots;
      buildings = newCampus.buildings;
      // buildingClosestLots = newCampus.buildingClosestLots;
    } catch (e) {
      log('Failed to update campus with error: $e');
      success = false;
    }
    return success;
  }
}
