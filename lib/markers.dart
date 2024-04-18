import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:upark/campus.dart';
import 'package:upark/client.dart';
import 'package:upark/home.dart';

class Markers {
  Future<List<Marker>> markers;

  Markers({
    required this.markers,
  });

  Markers.fromWidget(Widget markerWidget) : markers = createLotMarkerList(fetchLots(), markerWidget);
}

Future<List<Marker>> createLotMarkerList(
    Future<List<Lot>> lots, Widget markerWidget) async {
  return (await lots).map((lot) => createLotMarker(lot, markerWidget)).toList();
}

Marker createLotMarker(Lot lot, Widget widget) {
  return createMarker(lot.latitude, lot.longitude, widget);
}

Marker createMarker(double lattitude, double longitude, Widget markerChild) {
  return Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(lattitude, longitude),
    child: markerChild,
  );
}
