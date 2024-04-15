import 'package:latlong2/latlong.dart';
import 'package:upark/client.dart';

enum StallType { ADA, A, CA, U, M, EV, CU, HU, HCU, SHU, V }

enum Permit {
  ADA(name: 'ADA', stalls: [StallType.ADA]),
  U(name: 'U', stalls: [StallType.U, StallType.V]),
  A(name: 'A', stalls: [StallType.A, StallType.U, StallType.V]),
  HU(name: 'HU', stalls: [StallType.HU, StallType.U, StallType.V]),
  CU(name: 'CU', stalls: [StallType.CU, StallType.U, StallType.V]),
  HCU(
      name: 'HCU',
      stalls: [StallType.HCU, StallType.HU, StallType.U, StallType.V]),
  CA(name: 'CA', stalls: [StallType.A, StallType.U, StallType.V]),
  SHU(
      name: 'SHU',
      stalls: [StallType.SHU, StallType.HU, StallType.U, StallType.V]),
  M(name: 'M', stalls: [StallType.M, StallType.V]),
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
  int lotId;
  double lattitude;
  double longitude;
  LatLng get location => LatLng(lattitude, longitude);
  String name;
  int stallCount;
  List<StallType> stalls = [];

  Lot({
    required this.lotId,
    required this.lattitude,
    required this.longitude,
    required this.name,
    required this.stallCount,
    required this.stalls,
  });

  factory Lot.fromJson(Map<String, dynamic> json) => Lot(
        lotId: json["lot_id"],
        lattitude: double.parse(json["lot_lattitude"]),
        longitude: double.parse(json["lot_longitude"]),
        name: json["lot_name"],
        stallCount: json["stall_count"],
        stalls: (json["stalls"] ?? [])
            .map<StallType>((stall) => StallType.values[stall])
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        "lot_id": lotId,
        "lot_lattitude": lattitude,
        "lot_longitude": longitude,
        "lot_name": name,
        "stall_count": stallCount,
      };
}

class Report {
  int reportId;
  int lotId;
  double estFullness;
  DateTime time;
  int weight;

  Report({
    required this.reportId,
    required this.lotId,
    required this.estFullness,
    required this.time,
    required this.weight,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      estFullness: double.parse(json['est_fullness']),
      lotId: json['lot_id'],
      reportId: json['report_id'],
      time: DateTime.parse(json['time']),
      weight: json['weight'],
    );
  }

  Map<String, dynamic> toJson() => {
        "est_fullness": estFullness,
        "lot_id": lotId,
        "report_id": reportId,
        "time": time.toIso8601String(),
        "weight": weight,
      };
}

class Building {
  int bldId;
  String name;
  double lattitude;
  double longitude;
  String address;
  LatLng get location => LatLng(lattitude, longitude);

  Building({
    required this.bldId,
    required this.name,
    required this.lattitude,
    required this.longitude,
    this.address = '',
  });

  factory Building.fromJson(Map<String, dynamic> json) => Building(
        bldId: json["bld_id"],
        name: json["bld_name"],
        lattitude: double.parse(json["bld_lattitude"]),
        longitude: double.parse(json["bld_longitude"]),
        address: json["bld_address"],
      );
}

class Campus {
  String name = "University of Utah";
  List<Lot> parkingLots = [];
  List<Building> buildings = [];

  Campus({
    required this.name,
    required this.parkingLots,
    required this.buildings,
  });

  static Future<Campus> getFromApi() async {
    return Campus(
      name: "University of Utah",
      parkingLots: await fetchLots(),
      buildings: await fetchBuildings(),
    );
  }
}


