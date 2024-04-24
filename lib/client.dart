import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'constants.dart';
import 'package:upark/campus.dart';
import 'package:http/http.dart' as http;

var lotsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.lotsEndpoint);
var buildingsUri =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.buildingsEndpoint);
var reportsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.reportsEndpoint);
var postReportUri =
    Uri.parse(ApiConstants.baseUrl + ApiConstants.postReportEndpoint);

// Lots

List<Lot> lotsFromJson(String str) =>
    List<Lot>.from(json.decode(str).map((x) => Lot.fromJson(x)));

String lotsToJson(List<Lot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Future<List<Lot>> fetchLots({int maxRetries = 5}) async {
  int retryCount = 0;
  var response = await http.get(lotsUri);
  while (response.statusCode != 200 && retryCount < maxRetries) {
    retryCount++;
    await Future.delayed(const Duration(seconds: 1));
    response = await http.get(lotsUri);
    log('Failed to fetch lots $retryCount times with response: ${response.body}. Attempting again...');
  }
  if (response.statusCode == 200) {
    // print("Fetched lots: ${response.contentLength} bytes");
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

Future<List<Building>> fetchBuildings({int maxRetries = 5}) async {
  int retryCount = 0;
  var response = await http.get(buildingsUri);
  while (response.statusCode != 200 && retryCount < maxRetries) {
    retryCount++;
    await Future.delayed(const Duration(seconds: 1));
    response = await http.get(lotsUri);
    log('Failed to fetch lots $retryCount times with response: ${response.body}. Attempting again...');
  }
  if (response.statusCode == 200) {
    // print("Fetched buildings: ${response.contentLength} bytes");
    return buildingsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

// Reports

List<Report> reportsFromJson(String str) =>
    List<Report>.from(json.decode(str).map((x) => Report.fromJson(x)));

String reportsToJson(List<Report> data, AppUser user) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson(user))));

Future<List<Lot>> fetchReports({int maxRetries = 5}) async {
  int retryCount = 0;
  var response = await http.get(reportsUri);
  while (response.statusCode != 200 && retryCount < maxRetries) {
    retryCount++;
    await Future.delayed(const Duration(seconds: 1));
    response = await http.get(reportsUri);
    log('Failed to fetch reports $retryCount times with response: ${response.body}. Attempting again...');
  }
  if (response.statusCode == 200) {
    // print("Fetched reports: ${response.contentLength} bytes");
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
  }
}

Report reportFromJson(String str) => Report.fromJson(json.decode(str));

String reportToJson(Report data, AppUser user) =>
    json.encode(data.toJson(user));

Future<Response> postReport(Report report, AppUser user) async {
  var reportJson = reportToJson(report, user);
  // print("Posting report: $reportJson");
  var response = await http.post(postReportUri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: reportJson);
  // print("Report Response: ${response.body}");
  if (response.statusCode == 201 || response.statusCode == 200) {
    // print("Posted report: ${response.body}");
    return response;
  } else {
    throw Exception('Failed to post report');
  }
}

// User

AppUser userFromJson(String str) => AppUser.fromJson(json.decode(str));

String userToJson(AppUser data) => json.encode(data.toJson());

Future<AppUser> fetchUserFromId(String userId, {int maxRetries = 5}) async {
  int retryCount = 0;
  var response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$userId'));
  while (response.statusCode != 200 && retryCount < maxRetries) {
    retryCount++;
    await Future.delayed(const Duration(seconds: 1));
    response = await http.get(Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.userEndpoint}/$userId'));
    log('Failed to fetch users $retryCount times with response: ${response.body}. Attempting again...');
  }
  if (response.statusCode == 200) {
    // print("Fetched user data: ${response.body}");
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to load user');
  }
}

// Distances

Future<List<(Lot lot, int distance)>> fetchLotDistancesByCampusAndBuilding(Future<Campus> campus, Building building, {int limit = 5}) async {
  var distances = await fetchDistancesByBuilding(building, limit: limit);
  var fetchedCampus = await campus;
  List<(Lot lot, int distance)> lotDistances = [];
  for (var dist in distances) {
    var lot = fetchedCampus.lots.firstWhere((lot) => lot.id == dist.$1);
    var distance = (lot, dist.$2);
    lotDistances.add(distance);
  }
  return lotDistances;
}

Future<List<(int lotId, int distance)>> fetchDistancesByBuilding(Building building, {int limit = 5}) async {
  var dynamicDistances = await fetchDistances(building: building, limit: limit);
  List<(int lotId, int distance)> distances = [];
  for (var dist in dynamicDistances) {
    var distance = (dist.$1 as int, dist.$2 as int);
    distances.add(distance);
  }
  return distances;
}

Future<List<dynamic>> fetchDistances(
    {int limit = 5, Lot? lot, Building? building}) async {
  Uri uri;
  String fetchType = '';
  if (lot != null && building != null) {
    fetchType = 'both';
    uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.distancesByBothEndpoint}/${building.id}/${lot.id}');
  } else if (lot != null) {
    fetchType = 'lot';
    uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.distancesByLotEndpoint}/${lot.id}/$limit');
  } else if (building != null) {
    fetchType = 'building';
    uri = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.distancesByBuildingEndpoint}/${building.id}/$limit');
  } else {
    fetchType = 'all';
    uri = Uri.parse(ApiConstants.baseUrl + ApiConstants.distancesEndpoint);
  }
  var response = await http.get(uri);


  if (response.statusCode == 200) {
    // print("Fetched distances: ${response.contentLength} bytes");
    var responseJson = json.decode(response.body);

    switch (fetchType) {
      case 'lot':
        List<(int buildingId, int distance)> distances = [];
        for (var bld in responseJson) {
          var distance = (
            bld['id'] as int,
            bld['distance'] as int,
          );
          distances.add(distance);
        }
        return distances;
      case 'building':
        List<(int lotId, int distance)> distances = [];
        for (var lot in responseJson) {
          var distance = (
            lot['id'] as int,
            lot['distance'] as int,
          );
          distances.add(distance);
        }
        return distances;
      case 'both' || 'all':
        List<(int lotId, int buildingId, int distance)> distances = [];
        for (var dist in responseJson) {
          var distance = (
            dist['lot_id'] as int,
            dist['building_id'] as int,
            dist['distance'] as int,
          );
          distances.add(distance);
        }
        return distances;
      default:
        throw Exception('Failed to load distances');
    }
  } else {
    throw Exception('Failed to load distances');
  }
}

void updateUserColorblind(AppUser user) async {
  var response = await http.put(
    Uri.parse('${ApiConstants.baseUrl}${ApiConstants.setUserColorblindEndpoint}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'colorblind': user.colorblind ? 1 : 0,
      'id': user.id,
    }),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    log("Updated user: ${response.body}");
  } else {
    throw Exception('Failed to update user');
  }
}