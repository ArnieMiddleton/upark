import 'dart:convert';
import 'constants.dart';
import 'package:http/http.dart' as http;

var lotsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.lotsEndpoint);
var reportsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.reportsEndpoint);

List<Lot> lotsFromJson(String str) =>
    List<Lot>.from(json.decode(str).map((x) => Lot.fromJson(x)));

String lotsToJson(List<Lot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Lot {
  int lotId;
  double lattitude;
  double longitude;
  String name;
  int stallCount;

  Lot({
    required this.lotId,
    required this.lattitude,
    required this.longitude,
    required this.name,
    required this.stallCount,
  });

  factory Lot.fromJson(Map<String, dynamic> json) => Lot(
        lotId: json["lot_id"],
        lattitude: double.parse(json["lot_lattitude"]),
        longitude: double.parse(json["lot_longitude"]),
        name: json["lot_name"],
        stallCount: json["stall_count"],
      );

  Map<String, dynamic> toJson() => {
        "lot_id": lotId,
        "lot_lattitude": lattitude,
        "lot_longitude": longitude,
        "lot_name": name,
        "stall_count": stallCount,
      };
}

List<Report> reportsFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportsToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Report {
  double estFullness;
  int lotId;
  int reportId;
  DateTime time;
  int weight;

  Report({
    required this.estFullness,
    required this.lotId,
    required this.reportId,
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

Future<List<Lot>> fetchLots() async {
  final response = await http.get(lotsUri);
  if (response.statusCode == 200) {
    print(response.body);
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

Future<List<dynamic>> fetchListFromUri(Uri uri) async {
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    print(response.body);
    print(json.decode(response.body));
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

// Future<List<Lot>> fetchLots() async {
//   List<Lot> lots = await (<List<Lot>>)fetchListFromUri(lotsUri);
//   return lots;
// }

Future<List<Lot>> fetchReports() async {
  final response = await http.get(reportsUri);
  if (response.statusCode == 200) {
    print(response.body);
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}
