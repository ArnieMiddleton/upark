import 'dart:convert';
import 'constants.dart';
import 'package:upark/campus.dart';
import 'package:upark/authentication.dart';
import 'package:http/http.dart' as http;

var lotsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.lotsEndpoint);
var reportsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.reportsEndpoint);


// Lots

List<Lot> lotsFromJson(String str) =>
    List<Lot>.from(json.decode(str).map((x) => Lot.fromJson(x)));

String lotsToJson(List<Lot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Lot>> fetchLots() async {
  final response = await http.get(lotsUri);
  if (response.statusCode == 200) {
    // print(response.body);
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

// Lots

List<Building> buildingsFromJson(String str) =>
    List<Building>.from(json.decode(str).map((x) => Building.fromJson(x)));

String buildingsToJson(List<Building> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Building>> fetchBuildings() async {
  final response = await http.get(lotsUri);
  if (response.statusCode == 200) {
    // print(response.body);
    return buildingsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

// Reports

List<Report> reportsFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportsToJson(List<Report> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Lot>> fetchReports() async {
  final response = await http.get(reportsUri);
  if (response.statusCode == 200) {
    // print(response.body);
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

// User

Future<AppUser> fetchUserFromId(String userId) async {
  final response = await http.get(Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$userId'));
  if (response.statusCode == 200) {
    print(response.body);
    return AppUser.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load user');
  }
}
