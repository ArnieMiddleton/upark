import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:upark/campus.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/survey.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  final Future<Campus> campus;
  const MapPage(this.campus, {super.key});

  @override
  MapPageState createState() {
    return MapPageState();
  }
}

/// The state class for the MapPage widget.
///
/// This class extends the [State] class and implements the [WidgetsBindingObserver] mixin.
/// It manages the state of the MapPage widget and handles interactions with the map.
class MapPageState extends State<MapPage> with WidgetsBindingObserver {
  static late BuildContext currentContext;
  static MapPageState? currentMapStateInstance;
  late Future<Campus> campus = widget.campus;
  static final MapController mapController = MapController();
  var mapInitLocation = const LatLng(40.76497, -111.84611);
  late Lot selectedLot;
  bool navigated = false;
  static late LatLng currentLocation;
  static late List<Marker> markers;
  static late Timer markerUpdateTimer;

  /// Determines the color of the marker for a given parking lot.
  ///
  /// This method takes a [Lot] object as a parameter and calculates the fullness
  /// of the parking lot based on the ratio of occupied stalls to total stalls.
  /// It returns a [Color] object representing the appropriate marker color based on the fullness.
  static Color lotMarkerColor(double fullness, bool colorblind) {
    if (colorblind) {
      return gradientColor(
        colors: UtahColorScheme.lotColorsColorblind,
        value: fullness,
        // stops: [0.0, 0.7, 1.0]
      );
    } else {
      return gradientColor(
        colors: UtahColorScheme.lotColors,
        value: fullness,
        // stops: [0.0, 0.7, 1.0]
      );
    }
  }

  /// Returns a color that is interpolated between a list of colors based on a given value.
  ///
  /// The [colors] parameter is a list of colors to interpolate between.
  /// The [value] parameter is the value used to determine the interpolation factor.
  /// The [stops] parameter is an optional list of stops that define the range of values for each color. If not provided, the stops are evenly spaced between 0 and 1. The first and last stops must be 0 and 1, respectively.
  /// The [useHSV] parameter determines whether to use HSV color space for interpolation.
  ///
  /// The function returns a color that is interpolated between the two colors based on the given value.
  static Color gradientColor({
    required List<Color> colors,
    required double value,
    List<double>? stops,
    bool useHSV = true,
  }) {
    value = value.clamp(0.0, 1.0); // Value must be between 0 and 1
    stops ??= List.generate(
        colors.length, (index) => index / (colors.length - 1)); // Default stops
    if (stops.first != 0.0 || stops.last != 1.0) {
      throw ArgumentError(
          "The first and last stops must be 0 and 1, respectively.");
    }
    // Find the two colors to interpolate between
    int i = 0;
    while (i < stops.length - 1 && value > stops[i + 1]) {
      i++;
    }
    // i is the index of the first color to interpolate between
    double t =
        (value - stops[i]) / (stops[i + 1] - stops[i]); // Interpolation factor
    // Interpolate between the two colors using HSV
    if (useHSV) {
      HSVColor hsv1 = HSVColor.fromColor(colors[i]);
      HSVColor hsv2 = HSVColor.fromColor(colors[i + 1]);
      HSVColor interpolated = HSVColor.lerp(hsv1, hsv2, t)!;
      return interpolated.toColor();
    } else {
      return Color.lerp(colors[i], colors[i + 1], t)!;
    }
  }

  /// Opens the map application and displays the selected parking lot.
  ///
  /// This method takes a [Lot] object as a parameter and opens the map application
  /// to display the location of the selected parking lot. It returns a [Future<bool>]
  /// indicating whether the map application was successfully opened.
  Future<bool> openMapAppToLot(Lot lot) async {
    Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${lot.latitude},${lot.longitude}");
    Uri appleMapsUrl = Uri.parse(
        "https://maps.apple.com/?daddr=${lot.latitude},${lot.longitude}");
    Uri geoUri = Uri.parse("geo:${lot.latitude},${lot.longitude}");

    // Determine which platform the app is running on and open the appropriate map app
    Uri mapUrl = (Platform.isIOS || Platform.isAndroid)
        ? (Platform.isIOS ? appleMapsUrl : googleMapsUrl)
        : geoUri; // Default to geoUri if not on iOS or Android

    // Attempt to open via the mapUrl first, then fallback to the geoUri
    try {
      navigated = true;
      selectedLot = lot;
      try {
        await launchUrl(mapUrl);
      } catch (e) {
        log("Error opening map app: $e", name: "MapPageState");
        await launchUrl(geoUri);
      }
    } catch (e) {
      log("Error opening map app: $e", name: "MapPageState");
      navigated = false;
    }
    return navigated;
  }

  /// Opens the map application and displays the selected parking lot.
  ///
  /// This method takes a [Building] object as a parameter and opens the map application
  /// to display the location of the selected building. It returns a [Future<bool>]
  /// indicating whether the map application was successfully opened.
  Future<bool> openMapAppToBuilding(Building building) async {
    Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${selectedLot.latitude},${selectedLot.longitude}");
    Uri appleMapsUrl = Uri.parse(
        "https://maps.apple.com/?daddr=${selectedLot.latitude},${selectedLot.longitude}");
    Uri geoUri =
        Uri.parse("geo:${selectedLot.latitude},${selectedLot.longitude}");

    if (building.streetAddress != null && building.streetAddress!.isNotEmpty) {
      googleMapsUrl = Uri.parse(
          "https://www.google.com/maps/dir/?api=1&destination=${building.streetAddress}");
      appleMapsUrl =
          Uri.parse("https://maps.apple.com/?daddr=${building.streetAddress}");
      geoUri = Uri.parse(
          "geo:${building.latitude},${building.longitude}?q=${building.streetAddress}");
    } // TODO: Verify these links work

    // Determine which platform the app is running on and open the appropriate map app
    Uri mapUrl = (Platform.isIOS || Platform.isAndroid)
        ? (Platform.isIOS ? appleMapsUrl : googleMapsUrl)
        : geoUri; // Default to geoUri if not on iOS or Android

    // Attempt to open via the mapUrl first, then fallback to the geoUri
    try {
      navigated = true;
      try {
        await launchUrl(mapUrl);
      } catch (e) {
        log("Error opening map app: $e", name: "MapPageState");
        await launchUrl(geoUri);
      }
    } catch (e) {
      log("Error opening map app: $e", name: "MapPageState");
      navigated = false;
    }
    return navigated;
  }

  /// Opens the map application and displays the selected parking lot.
  ///
  /// This method takes a [LatLng] object as a parameter and opens the map application
  /// to display the location of the selected location. It returns a [Future<bool>]
  /// indicating whether the map application was successfully opened.
  Future<bool> openMapAppToLatLng(LatLng location) async {
    Uri googleMapsUrl = Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}");
    Uri appleMapsUrl = Uri.parse(
        "https://maps.apple.com/?daddr=${location.latitude},${location.longitude}");
    Uri geoUri = Uri.parse("geo:${location.latitude},${location.longitude}");

    // Determine which platform the app is running on and open the appropriate map app
    Uri mapUrl = (Platform.isIOS || Platform.isAndroid)
        ? (Platform.isIOS ? appleMapsUrl : googleMapsUrl)
        : geoUri; // Default to geoUri if not on iOS or Android

    // Attempt to open via the mapUrl first, then fallback to the geoUri
    try {
      navigated = true;
      try {
        await launchUrl(mapUrl);
      } catch (e) {
        log("Error opening map app: $e", name: "MapPageState");
        await launchUrl(geoUri);
      }
    } catch (e) {
      log("Error opening map app: $e", name: "MapPageState");
      navigated = false;
    }
    return navigated;
  }

  /// Builds the child widget for a marker on the map.
  ///
  /// This method takes a [Lot] object and an optional [Color] object as parameters.
  /// It returns a [Widget] representing the child widget for a marker on the map.
  Widget markerChild(Lot lot, bool colorblind, {Color? markerColor}) {
    markerColor ??= lotMarkerColor(lot.carCount / lot.stallCount, colorblind);
    return GestureDetector(
        onTap: () {
          selectedLot = lot;
          mapController.move(lot.location, 18.0);
          log("Map Controller moved to (${lot.location.latitude}, ${lot.location.longitude}",
              name: "MapState");
          log("Marker for lot ${lot.name} (${lot.id}) tapped",
              name: "MapState");
          showDialog(
            context: currentContext,
            builder: (context) {
              return AlertDialog(
                  title: Text('${lot.name} Lot info:'),
                  titleTextStyle: const TextStyle(
                    color: UtahColorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  alignment: Alignment.center,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RichText(
                            text: TextSpan(
                                text: 'Stalls: ',
                                style: const TextStyle(
                                  color: UtahColorScheme.onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${lot.stallCount}',
                                    style: const TextStyle(
                                      color: UtahColorScheme.onBackground,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Capacity: ',
                                style: const TextStyle(
                                  color: UtahColorScheme.onBackground,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        '${(lot.carCount / lot.stallCount * 100).floor()}%',
                                    style: const TextStyle(
                                      color: UtahColorScheme.onBackground,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  )
                                ]),
                          )
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: Column(children: [
                            const Text('Permit Types',
                                style: TextStyle(
                                    color: UtahColorScheme.onBackground,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16)),
                            const Divider(
                              color: UtahColorScheme.onBackground,
                              thickness: 1.5,
                              indent: 10,
                              endIndent: 10,
                            ),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ...lot.stalls
                                      .map((stall) => stall.name)
                                      .map((stallName) => Text(stallName))
                                ])
                          ]))
                    ],
                  ),
                  actions: [
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              UtahColorScheme.primary),
                          foregroundColor: MaterialStateProperty.all(
                              UtahColorScheme.onPrimary),
                        ),
                        child: const Text('Navigate'),
                        onPressed: () {
                          navigated = true;
                          openMapAppToLot(selectedLot);
                          Navigator.of(context).pop(); // Close Dialog
                        }),
                    TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              UtahColorScheme.primary),
                          foregroundColor: MaterialStateProperty.all(
                              UtahColorScheme.onPrimary),
                        ),
                        child: const Text('Fullness Survey'),
                        onPressed: () {
                          Navigator.of(context).pop(); // Close Dialog
                          Navigator.of(context).push(
                            // Open Survey
                            MaterialPageRoute(
                              builder: (context) {
                                return ParkingLotSurveyPage(
                                    selectedLot: selectedLot,
                                    campusFuture: campus);
                              },
                            ),
                          );
                        })
                  ]);
            },
          );
        },
        child: Icon(Icons.location_pin, color: markerColor, size: 25));
  }

  /// Generates a list of markers from a given campus.
  ///
  /// This function takes a [Campus] object, a [markerWidget], and a [mapController]
  /// as input and returns a list of [Marker] objects. Each marker represents a parking lot
  /// on the campus. The [markerWidget] is used as the child widget for each marker.
  List<Marker> markersFromCampus(Campus campus, MapController mapController) {
    print("Generating markers from campus data");
    print(
        "User data: {name: ${campus.user.name}, colorblind: ${campus.user.colorblind}, id: ${campus.user.id}}");
    List<Marker> newMarkers = [];
    for (var lot in campus.lots) {
      Marker marker = Marker(
        width: 30,
        height: 30,
        point: lot.location,
        alignment: Alignment.topCenter,
        child: markerChild(lot, campus.user.colorblind),
      );
      newMarkers.add(marker);
    }
    return newMarkers;
  }

  @override
  Widget build(BuildContext context) {
    currentContext = context;
    return FutureBuilder<Campus>(
      future: campus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var campusData = snapshot.data!;
          markers = markersFromCampus(campusData, mapController);
          return FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: mapInitLocation,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/notrh99/clt8xt1yy006l01r5g8j7dmxp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
                MarkerLayer(
                  markers: markers,
                ),
              ]);
        } else if (snapshot.hasError) {
          log("Error loading campus data",
              error: snapshot.error, name: "MapPageState.build");
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        // TODO: Show something while loading
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    currentMapStateInstance = this;
    currentLocation = mapInitLocation;
    campus = Campus.getFromApi();
    WidgetsBinding.instance.addObserver(this);
    campus.then((cmps) => {
          markerUpdateTimer =
              Timer.periodic(const Duration(seconds: 5), (timer) {
            cmps.updateCampusFromApi();
            setState(() {});
          }),
        }); // Update campus data every 5 seconds
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    markerUpdateTimer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    setState(() {});

    if (state == AppLifecycleState.resumed && navigated) {
      navigated = false;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return ParkingLotSurveyPage(
                selectedLot: selectedLot, campusFuture: campus);
          },
        ),
      );
    }
  }
}
