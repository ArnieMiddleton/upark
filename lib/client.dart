import 'dart:convert';
import 'dart:developer';
import 'constants.dart';
import 'package:upark/campus.dart';
import 'package:http/http.dart' as http;

var lotsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.lotsEndpoint);
var reportsUri = Uri.parse(ApiConstants.baseUrl + ApiConstants.reportsEndpoint);

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
    print("Fetched lots: ${response.contentLength} bytes");
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
  var response = await http.get(lotsUri);
  while (response.statusCode != 200 && retryCount < maxRetries) {
    retryCount++;
    await Future.delayed(const Duration(seconds: 1));
    response = await http.get(lotsUri);
    log('Failed to fetch lots $retryCount times with response: ${response.body}. Attempting again...');
  }
  if (response.statusCode == 200) {
    print("Fetched buildings: ${response.contentLength} bytes");
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
    print("Fetched reports: ${response.contentLength} bytes");
    return lotsFromJson(response.body);
  } else {
    throw Exception('Failed to load lots');
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
    print("Fetched user data: ${response.body}");
    return userFromJson(response.body);
  } else {
    throw Exception('Failed to load user');
  }
}
