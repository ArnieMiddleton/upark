import 'dart:async';
import 'dart:convert';
// import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'dart:math';
import 'package:flutter_map/flutter_map.dart';
import 'package:upark/authentication.dart';
// import 'package:flutter_map/flutter_map.dart';
import 'package:upark/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'survey.dart';
import 'package:latlong2/latlong.dart';
// import 'dart:developer' as developer;
import 'package:fuzzy/fuzzy.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:csv/csv.dart';
import 'package:upark/client.dart';
import 'package:upark/campus.dart';

// Homepage
class HomePage extends StatelessWidget {
  HomePage(Future<AppUser> user, {super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.red[700],
  //       leading: Row(
  //         children: [
  //           IconButton(
  //             icon: const Icon(Icons.settings),
  //             color: Colors.white,
  //             onPressed: () {
  //               Navigator.of(context).push(
  //                   MaterialPageRoute(builder: (context) => SettingsScreen()));
  //             },
  //           ),
  //           IconButton(
  //             icon: const Icon(Icons.info_outline),
  //             color: Colors.white,
  //             onPressed: () {  },
  //           )
  //         ],
  //       ),
  //       title: InkWell(
  //         onTap: () {
  //           showSearch(context: context, delegate: CustomSearchDelegate());
  //         },
  //         child: Container(
  //             height: 35,
  //             decoration: BoxDecoration(
  //               border: Border.all(
  //                 color: const Color.fromARGB(255, 255, 255, 255),
  //                 width: 1.4,
  //               ),
  //               borderRadius: BorderRadius.circular(25),
  //             ),
  //             child: const Row(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.symmetric(horizontal: 10.0),
  //                       child: Icon(
  //                         Icons.search,
  //                         color: Colors.white,
  //                       ),
  //                     ),
  //                     Text(
  //                       'Search Buildings',
  //                       style: TextStyle(
  //                           color: Color.fromARGB(255, 255, 255, 255)),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             )),
  //       ),
  //     ),
  //     body: HomePageMap(),
  //   );
  // }

  Widget build(BuildContext context) {
    double leadingWidth =
        100; // You may need to adjust this based on your icons' sizes
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        leadingWidth:
            leadingWidth, // Adjust this width to fit your icons comfortably
        leading: Container(
          width: leadingWidth,
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Space out icons evenly
            children: [
              IconButton(
                icon: const Icon(Icons.settings),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.info_outline),
                color: Colors.white,
                iconSize: 30.0,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                            dialogBackgroundColor: Colors.grey.shade400),
                        child: AlertDialog(
                          title: const Text('Map Info:'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.red.shade700,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "80-100% Occupied ",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.orange.shade600,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "60-80% Occupied",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.yellow.shade600,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "40-60% Occupied",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    width: 10,
                                    height: 10,
                                    color: Colors.green,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    "0-40% Occupied",
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                              // Repeat the above for more colored boxes
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        title: InkWell(
          onTap: () {
            // print("----------");
            // print(fetchLots()));
            // print("----------");
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          child: Container(
              height: 35,
              width: 250,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                mainAxisSize:
                    MainAxisSize.min, // Ensure the row takes minimum space
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    // Use Flexible to ensure the text fits the remaining space
                    child: Text(
                      'Search Buildings',
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        overflow: TextOverflow
                            .ellipsis, // Use ellipsis for text overflow
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
      body: HomePageMap(),
    );
  }
}

class HomePageMap extends StatefulWidget {
  @override
  _HomePageMapState createState() => _HomePageMapState();

  static void callStateScreen(
          Color newColor, String lotName, int listIndex, LatLng lotCoord) =>
      _HomePageMapState.updateMarkersAfterSurvey(
          newColor, lotName, listIndex, lotCoord, _HomePageMapState.contextPar);
}

Map<LatLng, String> createLotPermitDict() {
  Map<LatLng, String> parkinglotsLocation = {
    const LatLng(40.76047615, -111.8457732): " ADA, A, Visitor,",
    const LatLng(40.76551563, -111.8464372): " ADA, A, Visitor, M",
    const LatLng(40.76553734, -111.8475873): " Visitor",
    const LatLng(40.75964557, -111.8510534): " ADA, A, U",
    const LatLng(40.76184712, -111.8487463): " ADA, A, Visitor, M",
    const LatLng(40.76239342, -111.847587): " ADA, Visitor",
    const LatLng(40.76021823, -111.8443649): " ADA, A, Visitor",
    const LatLng(40.76146288, -111.8381891): " ADA, A, Visitor",
    const LatLng(40.76650879, -111.8450367): " ADA, Visitor, EV",
    const LatLng(40.76343596, -111.8532355): " ADA, A, Visitor, EV",
    const LatLng(40.76679045, -111.8514649): " ADA, A",
    const LatLng(40.76612338, -111.8456363): " ADA, A",

    const LatLng(40.76545653, -111.8375496): " ADA, Visitor",
    const LatLng(40.76108824, -111.8425409): " ADA, Visitor",
    const LatLng(40.75947206, -111.8460659): " ADA, A, U, M",
    const LatLng(40.76183744, -111.850429): " ADA, A, Visitor, M, EV",
    const LatLng(40.77022927, -111.8462263): " ADA, A, U, Visitor, EV",
    const LatLng(40.766834, -111.8437108): " ADA, A, Visitor, M",
    const LatLng(40.76930197, -111.8441186): " ADA, A, U, Visitor, M, EV",
    const LatLng(40.7678793, -111.8480301): " ADA, A, Visitor",
    const LatLng(40.76505561, -111.849477): " M, Visitor",
    const LatLng(40.76164289, -111.8414329): " CA, HCU, CU",
    // Note: 'Central Garage' and 'Northwest Garage' are repeated with the same coordinates
    const LatLng(40.76639168, -111.8487693): " CA, HCU, CU",
    const LatLng(40.76188585, -111.8404306): " ADA, Visitor",
    const LatLng(40.76173022, -111.8467084): " ADA, Visitor",
    const LatLng(40.76307923, -111.8374067): " ADA, U",
    const LatLng(40.76081929, -111.8395905): " ADA, A, Visitor, M",
    const LatLng(40.7611466, -111.8406582): " ADA, A",
    const LatLng(40.76748713, -111.8398083): " ADA, U",
    const LatLng(40.76608434, -111.8494079): " ADA, A, M",
    const LatLng(40.765003, -111.8443877): " ADA, Visitor",
    const LatLng(40.77055754, -111.843232): " ADA, A, U, M, EV",
    const LatLng(40.76906066, -111.8393496): "ADA, A, U, Visitor, M",
    const LatLng(40.76502741, -111.8421128): " ADA, Visitor, EV",
  };

  return parkinglotsLocation;
}

Map<LatLng, String> createLotCountDict() {
  Map<LatLng, String> parkinglotsCount = {
    const LatLng(40.76047615, -111.8457732): " 175",
    const LatLng(40.76551563, -111.8464372): " 103",
    const LatLng(40.76553734, -111.8475873): " 77",
    const LatLng(40.75964557, -111.8510534): " 887",
    const LatLng(40.76184712, -111.8487463): " 94",
    const LatLng(40.76239342, -111.847587): " 340",
    const LatLng(40.76021823, -111.8443649): " 50",
    const LatLng(40.76146288, -111.8381891): " 44",
    const LatLng(40.76650879, -111.8450367): " 36",
    const LatLng(40.76343596, -111.8532355): " 12",
    const LatLng(40.76679045, -111.8514649): " 9",
    const LatLng(40.76612338, -111.8456363): " 103",
    const LatLng(40.76545653, -111.8375496): " 34",
    const LatLng(40.76108824, -111.8425409): " 299",
    const LatLng(40.75947206, -111.8460659): " 279",
    const LatLng(40.76183744, -111.850429): " 341",
    const LatLng(40.77022927, -111.8462263): " 1046",
    const LatLng(40.766834, -111.8437108): " 269",
    const LatLng(40.76930197, -111.8441186): " 514",
    const LatLng(40.7678793, -111.8480301): " 175",
    const LatLng(40.76505561, -111.849477): " 210",
    const LatLng(40.76164289, -111.8414329): " 788",
    // Note: 'Central Garage' and 'Northwest Garage' are repeated with the same coordinates
    const LatLng(40.76639168, -111.8487693): " 317",
    const LatLng(40.76188585, -111.8404306): " 71",
    const LatLng(40.76173022, -111.8467084): " 49",
    const LatLng(40.76307923, -111.8374067): " 345",
    const LatLng(40.76081929, -111.8395905): " 108",
    const LatLng(40.7611466, -111.8406582): " 135",
    const LatLng(40.76748713, -111.8398083): " 220",
    const LatLng(40.76608434, -111.8494079): " 68",
    const LatLng(40.765003, -111.8443877): " 315",
    const LatLng(40.77055754, -111.843232): " 222",
    const LatLng(40.76906066, -111.8393496): " 812",
    const LatLng(40.76502741, -111.8421128): " 230",
  };

  return parkinglotsCount;
}

// Creates a dictionary (lotName (str) -> location (LatLng))
Future<Map<String, LatLng>> createLotLngDict() async {
  var lots = await fetchLots();

  Map<String, LatLng> parkinglotsLocation = {};
  for (Lot lot in lots) {
    parkinglotsLocation[lot.name] = LatLng(lot.latitude, lot.longitude);

    // print("${lot.name} ${lot.lattitude.toString()} ${lot.longitude.toString()}");
  }

  /*
  Map<String, LatLng> parkinglotsLocation = {
    'Social Work': const LatLng(40.76047615, -111.8457732),
    'Union North': const LatLng(40.76551563, -111.8464372),
    'Student Services': const LatLng(40.76553734, -111.8475873),
    'West Stadium': const LatLng(40.75964557, -111.8510534),
    'Chemistry': const LatLng(40.76184712, -111.8487463),
    'Marriott Library': const LatLng(40.76239342, -111.847587),
    'Sculpture': const LatLng(40.76021823, -111.8443649),
    'Huntsman South': const LatLng(40.76146288, -111.8381891),
    'Warnock Engineering': const LatLng(40.76650879, -111.8450367),
    'Fine Arts West': const LatLng(40.76343596, -111.8532355),
    'Gardner Hall': const LatLng(40.76679045, -111.8514649),
    'HEDCO': const LatLng(40.76612338, -111.8456363),
    'Student Life': const LatLng(40.76545653, -111.8375496),
    'Business': const LatLng(40.76108824, -111.8425409),
    'East Stadium': const LatLng(40.75947206, -111.8460659),
    'Law': const LatLng(40.76183744, -111.850429),
    'Merrill Engineering': const LatLng(40.77022927, -111.8462263),
    'Alumni': const LatLng(40.766834, -111.8437108),
    'Sorenson': const LatLng(40.76930197, -111.8441186),
    'Kennecott': const LatLng(40.7678793, -111.8480301),
    'Presidents Circle': const LatLng(40.76505561, -111.849477),
    'Central Garage': const LatLng(40.76164289, -111.8414329),
    // Note: 'Central Garage' and 'Northwest Garage' are repeated with the same coordinates
    'Northwest Garage': const LatLng(40.76639168, -111.8487693),
    'Tanner Dance': const LatLng(40.76188585, -111.8404306),
    'Marriott South': const LatLng(40.76173022, -111.8467084),
    'Huntsman East': const LatLng(40.76307923, -111.8374067),
    'Huntsman West': const LatLng(40.76081929, -111.8395905),
    'University Services': const LatLng(40.7611466, -111.8406582),
    'Soccer': const LatLng(40.76748713, -111.8398083),
    'Naval Science': const LatLng(40.76608434, -111.8494079),
    'Union East': const LatLng(40.765003, -111.8443877),
    'USTAR': const LatLng(40.77055754, -111.843232),
    'Broadcast Center': const LatLng(40.76906066, -111.8393496),
    'HPER Sports': const LatLng(40.76502741, -111.8421128),
  };
  */

  return parkinglotsLocation;
}

// Creates a list of markers that will be placed on the map from a Map (LotNames -> (Latitude, Longitude))
Future<List<Marker>> createMarkerList(MapController controller,
    BuildContext context, Map<LatLng, String> lotToPermit) async {
  List<Marker> lotMarkers = [];
  //CREATING A DICTIONARY -> KEYS: PARKING LOT NAMES, VALUES: LATITUDE AND LONGITUDE FOR THE CORRESPONDING PARKING LOT
  // print('createMarkerList called');
  Map<String, LatLng> parkinglotsLocation = await createLotLngDict();

  for (var parkingLot in parkinglotsLocation.entries) {
    String? permits = lotToPermit[
        LatLng(parkingLot.value.latitude, parkingLot.value.longitude)];
    Marker newMarker = Marker(
      point: parkingLot.value,
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(parkingLot.value, 20, 0);
          _HomePageMapState.selectedDestination =
              LatLng(parkingLot.value.latitude, parkingLot.value.longitude);

          // Show a pop-up dialog
          showDialog(
            context:
                context, // Ensure you have a BuildContext `context` available
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Parking Lot Info:'),
                content: Text("Allowed Permits: " +
                    permits! +
                    "\n \nTotal Number of Slots: " +
                    _HomePageMapState.lotToCount[LatLng(
                        parkingLot.value.latitude,
                        parkingLot.value.longitude)]!),
                actions: <Widget>[
                  // Button in the pop-up
                  TextButton(
                    child: Text('Navigate'),
                    onPressed: () {
                      // Code to open the map goes here
                      openMap(parkingLot.value.latitude,
                          parkingLot.value.longitude);
                      Navigator.of(context).pop(); // Close the pop-up
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    );
    lotMarkers.add(newMarker);
  }

  // print('createMarkerList finished: $lotMarkers');
  return lotMarkers;
}

class _HomePageMapState extends State<HomePageMap> with WidgetsBindingObserver {
  static final MapController controller = MapController();
  ValueNotifier<bool> isSheetExpanded = ValueNotifier(false);
  // static bool isReturningFromGoogleMaps = false;
  static _HomePageMapState? _currentInstance;
  static late BuildContext contextPar;
  LatLng latLng = const LatLng(40.76497, -111.84611);
  static Map<LatLng, String> lotToPermit = createLotPermitDict();
  // static List<Marker> my_markers = await createMarkerList(controller, contextPar, lotToPermit);
  static Map<LatLng, String> lotToCount = createLotCountDict();

  // static Map<String, LatLng> lot_name_TO_coordinate = createLotLngDict();
  static late LatLng selectedDestination;
  late Timer timer;

  static List<Marker> my_markers = [];

  // Define the getter for my_markers
  // static List<Marker> get my_markers => _myMarkers;

  // Fetch the markers data asynchronously
  Future<void> fetchMarkers() async {
    // Replace the following line with your actual data fetching logic
    List<Marker> fetchedMarkers =
        await createMarkerList(controller, contextPar, lotToPermit);

    // Update the state of the widget with the fetched markers
    setState(() {
      my_markers = fetchedMarkers;
    });
  }

  // given a two dictionaries (lotName -> occupancy percentage) and (lotName -> Location) updates the color of the markers
  void updateMarker(Map<String, int> occupancyPerLot,
      Map<String, LatLng> parkinglotsLocation) {
    Color green = Colors.green;
    Color yellow = Colors.yellow.shade600;
    Color orange = Colors.orange.shade600;
    Color red = Colors.red.shade700;

    for (var parkingLot in occupancyPerLot.entries) {
      String lotName = parkingLot.key;
      int occupancy = parkingLot.value;

      Color newColor;

      // Convert map keys to a list
      List<String> keysList = parkinglotsLocation.keys.toList();

      // Find the index of the key
      int listIndex = keysList.indexOf(lotName);

      // Find the new color for the marker based on occupancy.
      if (0 <= occupancy && occupancy <= 40) {
        newColor = green;
      } else if (40 < occupancy && occupancy <= 60) {
        newColor = yellow;
      } else if (60 < occupancy && occupancy <= 80) {
        newColor = orange;
      } else {
        newColor = red;
      }

      LatLng coord = parkinglotsLocation[lotName]!;
      // Create a new marker that will be replaced with current one
      String? permits = lotToPermit[coord];

      Marker replaceMarker = Marker(
        point: coord,
        width: 30,
        height: 30,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(coord, 20, 0);

            // Show a pop-up dialog
            showDialog(
              context:
                  contextPar, // Ensure you have a BuildContext `context` available
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Parking Lot Info:'),
                  content: Text("Allowed Permits: " +
                      permits! +
                      "\n \nTotal Number of Slots: " +
                      lotToCount[coord]!),
                  actions: <Widget>[
                    // Button in the pop-up
                    TextButton(
                      child: const Text('Navigate'),
                      onPressed: () {
                        // Code to open the map goes here
                        openMap(coord.latitude, coord.longitude);
                        Navigator.of(context).pop(); // Close the pop-up
                      },
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(
            Icons.location_pin,
            color: newColor,
            size: 25,
          ),
        ),
      );

      my_markers[listIndex] = replaceMarker;
    }
  }

  // updates the marker that corresponds to the parking lot that user navigated to based on the user feedback.
  static void updateMarkersAfterSurvey(Color newColor, String lotName,
      int listIndex, LatLng lotCoord, BuildContext context) {
    if (_currentInstance == null) return;
    String? permits = lotToPermit[lotCoord];

    Marker replaceMarker = Marker(
      point: lotCoord,
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(lotCoord, 20, 0);

          // Show a pop-up dialog
          showDialog(
            context:
                context, // Ensure you have a BuildContext `context` available
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Parking Lot Info:'),
                content: Text("Allowed Permits: ${permits!} \n \nTotal Number of Slots: ${lotToCount[lotCoord]}"),
                actions: <Widget>[
                  // Button in the pop-up
                  TextButton(
                    child: const Text('Navigate'),
                    onPressed: () {
                      // Code to open the map goes here
                      openMap(lotCoord.latitude, lotCoord.longitude);
                      Navigator.of(context).pop(); // Close the pop-up
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Icon(
          Icons.location_pin,
          color: newColor,
          size: 25,
        ),
      ),
    );

    _HomePageMapState.my_markers[listIndex] = replaceMarker;
    // REFRESH THE PAGE HERE
    _currentInstance!.refreshUI();
  }

  // refreshed the page
  void refreshUI() {
    setState(() {});
  }

  // Method that is being called every 'X' seconds/minutes to update the Map.
  void updateMap() async {
    // CREATING DUMMY DATA TO TEST MARKER UPDATING EVERY X SECONDS
    var latLngDict = await createLotLngDict();
    List<String> parkingNames = latLngDict.keys.toList();
    Random random = Random();
    List<int> randomOccupancy = List.generate(34, (_) => random.nextInt(101));
    Map<String, int> dummyMap =
        Map.fromIterables(parkingNames, randomOccupancy);

    setState(() {
      updateMarker(dummyMap, latLngDict);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register observer
    _currentInstance = this; // Set the current instance
    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) => updateMap());
    // call updateMap every 5 seconds to update the markers.
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Unregister observer
    timer.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && isReturningFromMaps) {
      // Reset the flag
      isReturningFromMaps = false;

      // Now navigate to the survey screen if we're not already on it
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ParkingLotSurveyScreen(
                    selectedLot: selectedDestination,
                  )),
        );
      } else {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => ParkingLotSurveyScreen(
                    selectedLot: selectedDestination,
                  )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    contextPar = context;
    fetchMarkers(); // Fetch the markers when the widget is initialized
    return FutureBuilder(
        future: createMarkerList(controller, context, lotToPermit),
        builder: (context, AsyncSnapshot<List<Marker>> snapshot) {
          if (snapshot.hasError) {
            var error = snapshot.error;
            print("Snapshot has error: $error");
            return const Text("Error");
          } else if (snapshot.hasData) {
            var data = snapshot.data;
            // print("Snapshot has data: $data");
            return FlutterMap(
              mapController: controller,
              options: MapOptions(
                initialCenter: latLng,
                initialZoom: 14,
              ),
              children: [
                TileLayer(
                    urlTemplate:
                        "https://api.mapbox.com/styles/v1/notrh99/clt8xt1yy006l01r5g8j7dmxp/wmts?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
                MarkerLayer(
                  markers: snapshot.data!,
                ),
              ],
            );
          } else {
            print("Snapshot has no data");
            return const CircularProgressIndicator();
          }
        });
    /*
    contextPar = context;
    // my_markers = createMarkerList(controller, context);
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: latLng,
        initialZoom: 14,
      ),
      children: [
        TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/notrh99/clt8xt1yy006l01r5g8j7dmxp/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
        // "https://api.mapbox.com/styles/v1/notrh99/cls4817h500dx01po4rvgauqt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
        MarkerLayer(
          markers: my_markers,
        ),
      ],
    );
    */
  }
}

Future<Map<String, List<MapEntry<String, double>>>> loadParkingData() async {
  // Load the JSON data
  String jsonString = await rootBundle.loadString('lib/assets/distances.json');

  // Parse the JSON string into a Map
  Map<String, dynamic> buildings = jsonDecode(jsonString);

  // Process the JSON to find the top 4 parking lots for each building
  Map<String, List<MapEntry<String, double>>> topParkingLots = {};

  buildings.forEach((building, parkingLots) {
    // Convert parking lots to a list of MapEntries for sorting, ensuring keys are Strings
    var parkingLotsList = (parkingLots as Map)
        .entries
        .map((entry) =>
            MapEntry(entry.key as String, double.parse(entry.value.toString())))
        .toList();

    // Take the top 4 parking lots
    topParkingLots[building] = parkingLotsList.take(4).toList();
  });

  return topParkingLots;
}

class CustomSearchDelegate extends SearchDelegate {
  _HomePageMapState myInstance = _HomePageMapState();
  String lastQuery = '';
  final Map<String, LatLng> locations = {
    'Campus Bike Shop (BIKE)': const LatLng(40.7605798, -111.8428217),
    'S.J. Quinney College of Law (LAW)': const LatLng(40.7612208, -111.8514449),
    'Mineral Processing Lab (MPL)': const LatLng(40.7665169, -111.8448861),
    'Mining Systems Research Lab (MSRL)':
        const LatLng(40.7666465, -111.8445482),
    'Experimental Studies Building (ESB)':
        const LatLng(40.7660466, -111.8447915),
    'John and Marva Warnock Engineering Building (WEB)':
        const LatLng(40.7677074, -111.845305),
    'Alice Sheets Marriott Center for Dance (MCD)':
        const LatLng(40.762399, -111.8485909),
    'Life Science Building (LS)': const LatLng(40.763534, -111.8501393),
    'Chemistry Cooling Tower': const LatLng(40.7623958, -111.8502781),
    'High Temperature Water Plant (HTW)': const LatLng(40.760472, -111.8418901),
    'Recycling Center': const LatLng(40.760223, -111.8413411),
    'Buildings & Grounds Storage Shed #2 (BLG GR)':
        const LatLng(40.7603222, -111.8403604),
    'Buildings & Grounds Storage Shed #1 (BLG GR)':
        const LatLng(40.7604644, -111.84049),
    'Motor Pool Gas Station': const LatLng(40.760738, -111.8399211),
    'Motor Pool Building (MOTOR)': const LatLng(40.7605685, -111.8402757),
    'Buildings & Grounds': const LatLng(40.760374, -111.8406457),
    'Physical Plant Services (PP SER)': const LatLng(40.7609436, -111.8412124),
    'Public Safety Storage Shed (SAFETY)':
        const LatLng(40.760029, -111.8408105),
    'George S. Eccles 2002 Legacy Bridge (BRIDGE)':
        const LatLng(40.7649731, -111.8372508),
    'Joseph F. Merrill Engineering Building (MEB)':
        const LatLng(40.7685435, -111.8461438),
    'Floyd and Jeri Meldrum Civil Engineering Building (MCE)':
        const LatLng(40.7670116, -111.8455091),
    'C. Roland Christensen Center (CRCC)':
        const LatLng(40.761274, -111.8439109),
    'Sculpture Building (SCULPT)': const LatLng(40.7604263, -111.8446468),
    'Utah Museum of Fine Arts (UMFA)': const LatLng(40.7602453, -111.843287),
    'Social and Behavioral Science Lecture Hall (S BEH)':
        const LatLng(40.7609948, -111.8459596),
    'College of Social Work (SW)': const LatLng(40.7609527, -111.8466878),
    'Questar Gas Shed #1': const LatLng(40.7630119, -111.8361847),
    'Roy W. & Elizabeth E. Simmons Pioneer Memorial Theatre (PMT)':
        const LatLng(40.7627743, -111.8510771),
    'Office Building 44 (BLDG 44)': const LatLng(40.7631331, -111.8484522),
    'Aline Wilmot Skaggs Biology Building (ASB)':
        const LatLng(40.7636844, -111.8486777),
    'Alfred C. Emery Building (AEB)': const LatLng(40.7641708, -111.8501068),
    'Steam Generating Plant': const LatLng(40.7656879, -111.8481054),
    'McCarthey Family Track and Field Storage Building':
        const LatLng(40.767219, -111.8391541),
    'Golf Pro Shop (GLF SH)': const LatLng(40.7680291, -111.8433072),
    'Sorenson Molecular Biotechnology (SMBB)':
        const LatLng(40.7689427, -111.8421158),
    'Office of Sponsored Projects (S PROJ)':
        const LatLng(40.768284, -111.8485698),
    'Fine Arts West (FAW)': const LatLng(40.7631906, -111.8528793),
    'Cauldron Legacy Plaza Visitors Center (PLAZA)':
        const LatLng(40.7588343, -111.8497591),
    'David P. Gardner Hall (DGH)': const LatLng(40.7662045, -111.8517317),
    'James Talmage Building (JTB)': const LatLng(40.7644381, -111.8495015),
    'Cowles Cooling Tower': const LatLng(40.7661025, -111.8497673),
    'Sorenson Arts & Education Complex (SAEC)':
        const LatLng(40.7628492, -111.8415156),
    'HPER (HPRNAT)': const LatLng(40.7633309, -111.8398826),
    'Skaggs Cooling Tower': const LatLng(40.7636082, -111.8482286),
    'Building 124 (BLDG 124)': const LatLng(40.7642739, -111.8491462),
    'Thatcher Chemistry (TBBC)': const LatLng(40.7617233, -111.849658),
    'Civil and Materials Engineering (CME)':
        const LatLng(40.7664854, -111.8459993),
    'Park Building (PARK)': const LatLng(40.7650072, -111.8487908),
    'Intermountain Network Scientific Computation Center (INSCC)':
        const LatLng(40.7659168, -111.848729),
    'LeRoy E. Cowles Building (LCB)': const LatLng(40.7656173, -111.8495495),
    'Naval Science Building (NS)': const LatLng(40.766645, -111.8493796),
    'Spencer Fox Eccles Business Building (SFEBB)':
        const LatLng(40.7617223, -111.8433843),
    'Spence Eccles Ski Team Building (SKI)':
        const LatLng(40.7669476, -111.8405543),
    'Grounds Storage Building (BLG GR)': const LatLng(40.7606638, -111.8412352),
    'Salt Lake City Reservoir': const LatLng(40.7592434, -111.8470646),
    'George S. Eccles Student Life Center (GSESLC)':
        const LatLng(40.7650827, -111.838233),
    'Pumphouse #3': const LatLng(40.7626118, -111.8359859),
    'North Campus Chiller Plant (BLDG 149)':
        const LatLng(40.7674303, -111.8427461),
    'Joseph T. Kingsbury Hall (KH)': const LatLng(40.7661964, -111.8509428),
    'Henry Eyring Chemistry Building (HEB)':
        const LatLng(40.7623469, -111.8494898),
    'V. Randall Turpin University Services Building (VRTUSB)':
        const LatLng(40.7613875, -111.8400721),
    'Jon M. Huntsman Center (JHC)': const LatLng(40.7620589, -111.8387518),
    'Space Planning & Management (SPACE)':
        const LatLng(40.7687097, -111.8486904),
    'Social & Behavioral Sciences (BEH S)':
        const LatLng(40.7614548, -111.8462603),
    'Biology Building (BIOL)': const LatLng(40.7635123, -111.8495492),
    'Alan W. Layton Engineering Building (LEB)':
        const LatLng(40.7665156, -111.84548),
    'Performing Arts Building (PAB)': const LatLng(40.7639132, -111.8479817),
    'Eccles House (EH)': const LatLng(40.7725992, -111.8437945),
    'Soccer Field Ticket Office': const LatLng(40.7673491, -111.8409302),
    'Equipment Shed': const LatLng(40.7679182, -111.8417775),
    'Dumke Family Softball Stadium (DFSS)':
        const LatLng(40.7677039, -111.8411626),
    'Field Storage Building': const LatLng(40.7681291, -111.8416951),
    'Einar Nielsen (FLD H)': const LatLng(40.7612137, -111.8488777),
    'Transformer Building': const LatLng(40.7587237, -111.851231),
    'William Stewart Building (ST)': const LatLng(40.7634326, -111.8509426),
    'The Gary L. and Ann T. Crocker Science Center at the George Thomas Building (CSC)':
        const LatLng(40.7640556, -111.8511161),
    'HPER West (HPR W)': const LatLng(40.762922, -111.8406218),
    'HPER East (HPR E)': const LatLng(40.7636929, -111.8391684),
    'Kenneth P. Burbidge, Jr., Family Athletics Academic Center (KBAC)':
        const LatLng(40.7629723, -111.8396537),
    'HPER North (HPR N)': const LatLng(40.7638422, -111.8403347),
    'HPER Mechanical Building Southwest (HPR SW)':
        const LatLng(40.7627283, -111.8396291),
    'Central Garage (CPG)': const LatLng(40.7616177, -111.8414221),
    'HTW Plant Cooling Tower': const LatLng(40.7607224, -111.8416042),
    'Language & Communication Building (LNCO)':
        const LatLng(40.763612, -111.843649),
    'Bldg 301 (SAFETY)': const LatLng(40.7599051, -111.8410001),
    'Art Building (ART)': const LatLng(40.7608952, -111.8448774),
    'Architecture Building (ARCH)': const LatLng(40.7611435, -111.8445216),
    'A. Ray Olpin Union (UNION)': const LatLng(40.7649585, -111.8460258),
    'Carolyn Tanner Irish Humanities Building (CTIHB)':
        const LatLng(40.764559, -111.8429781),
    'Student Services Cooling Tower': const LatLng(40.7653175, -111.8484318),
    'Student Services Building (SSB)': const LatLng(40.7650099, -111.8480666),
    'James C. Fletcher Building (JFB)': const LatLng(40.7667215, -111.8504586),
    'Physics Maintenance Shed': const LatLng(40.7663155, -111.8497409),
    'Voice & Opera Center (VOICE)': const LatLng(40.7668481, -111.8518531),
    'Frederick Albert Sutton Building (FASB)':
        const LatLng(40.7666686, -111.8477967),
    'William C. Browning Building (WBB)':
        const LatLng(40.7662422, -111.8477118),
    'SW Cooling Tower': const LatLng(40.7611313, -111.8480044),
    'John A. Widtsoe Building (JWB)': const LatLng(40.7659103, -111.8501467),
    'J. Willard Marriott Library (M LIB)':
        const LatLng(40.7624564, -111.8462009),
    'Film and Media Arts Building (FMAB)':
        const LatLng(40.7612975, -111.8454004),
    'Business Classroom Building (BU C)':
        const LatLng(40.7617724, -111.8441455),
    'Pumphouse #8': const LatLng(40.76537, -111.8393343),
    'Donna Garff Marriott Residential Scholars Community (MHC)':
        const LatLng(40.7638268, -111.8368582),
    'Cleone Peterson Eccles Alumni House (ALUMNI)':
        const LatLng(40.7658899, -111.8436309),
    'Rosenblatt House (ROSEN)': const LatLng(40.7714816, -111.845167),
    'Carolyn and Kem Gardner Commons (GC)':
        const LatLng(40.7633607, -111.8446581),
    'HPER Mechanical Building Southeast (HPR SE)':
        const LatLng(40.7629181, -111.8392586),
    'Jon M. and Karen Huntsman Basketball Facility (HBF)':
        const LatLng(40.7630993, -111.8387277),
    'Northwest Garage (Northwest)': const LatLng(40.7665208, -111.8487329),
    'Sterling Sill Center (SILL)': const LatLng(40.7653351, -111.8436888),
    'University Campus Store (U CAMPSTOR)':
        const LatLng(40.7637118, -111.8475237),
    'Physics Cooling Tower': const LatLng(40.7665293, -111.8498995),
    'Physics Building (PHYS)': const LatLng(40.7663942, -111.8500583),
    'Meldrum House': const LatLng(40.7649572948751, -111.853380680972),
    'Building 72 (BLDG 72)': const LatLng(40.7620302, -111.8514106),
    'John & Marcia Price Theatre Arts Building (PTAB)':
        const LatLng(40.7620336, -111.8518393),
    'Impact Prosperity Epicenter Building (IPE)':
        const LatLng(40.7653564842492, -111.839022701725),
    'Rio Tinto Kennecott Mechanical Engineering Building (MEK)':
        const LatLng(40.7674748, -111.8477638),
    'Lassonde Studios (LSND)': const LatLng(40.7645445, -111.8415405),
    'Rice-Eccles Stadium (STAD)': const LatLng(40.7600622, -111.8489259),
    'Robert H. and Katharine B. Garff Executive Education Building (Garff)':
        const LatLng(40.7621344, -111.8422519),
    'Dolores Dore Eccles Broadcast Center (EBC)':
        const LatLng(40.7673162, -111.8378598),
    'Kahlert Village (KV)': const LatLng(40.7637771, -111.837987),
    'Dumke Gymnastics Center (DGC)': const LatLng(40.7643456, -111.8396279),
  };

  final Map<String, LatLng> parking_locations = {
    'Parking Lot 1': const LatLng(40.76047615, -111.8457732),
    'Parking Lot 2': const LatLng(40.76551563,
        -111.8464372), //const LatLng(40.76609893830639, -111.84567689958726),
    'Parking Lot 3': const LatLng(40.76553734, -111.8475873),
    'Parking Lot 4': const LatLng(40.75964557, -111.8510534),
    'Parking Lot 5': const LatLng(40.76184712, -111.8487463),
    'Parking Lot 6': const LatLng(40.76239342, -111.847587),
    'Parking Lot 7': const LatLng(40.76021823, -111.8443649),
    'Parking Lot 8': const LatLng(40.76146288, -111.8381891),
    'Parking Lot 9': const LatLng(40.76650879, -111.8450367),
    'Parking Lot 10': const LatLng(40.76343596, -111.8532355),
    'Parking Lot 11': const LatLng(40.76679045, -111.8514649),
    'Parking Lot 12': const LatLng(40.76612338, -111.8456363),
    'Parking Lot 13': const LatLng(40.76545653, -111.8375496),
    'Parking Lot 14': const LatLng(40.76108824, -111.8425409),
    'Parking Lot 15': const LatLng(40.75947206, -111.8460659),
    'Parking Lot 16': const LatLng(40.76183744, -111.850429),
    'Parking Lot 17': const LatLng(40.77022927, -111.8462263),
    'Parking Lot 18': const LatLng(40.766834, -111.8437108),
    'Parking Lot 19': const LatLng(40.76930197, -111.8441186),
    'Parking Lot 20': const LatLng(40.7678793, -111.8480301),
    'Parking Lot 21': const LatLng(40.76505561, -111.849477),
    'Parking Lot 22': const LatLng(40.76164289, -111.8414329),
    'Parking Lot 23': const LatLng(40.76639168, -111.8487693),
    'Parking Lot 24': const LatLng(40.76188585, -111.8404306),
    'Parking Lot 25': const LatLng(40.76307923, -111.8374067),
    'Parking Lot 26': const LatLng(40.76081929, -111.8395905),
    'Parking Lot 27': const LatLng(40.7611466, -111.8406582),
    'Parking Lot 28': const LatLng(40.76748713, -111.8398083),
    'Parking Lot 29': const LatLng(40.76608434, -111.8494079),
    'Parking Lot 30': const LatLng(40.765003, -111.8443877),
    'Parking Lot 31': const LatLng(40.77055754, -111.843232),
    'Parking Lot 32': const LatLng(40.76906066, -111.8393496),
    'Parking Lot 33': const LatLng(40.76502741, -111.8421128)
  };

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResult();
  }

  Widget _buildSearchResult() {
    // Convert locations to a list of names for the fuzzy search.
    final locationNames = locations.keys.toList();

    // Perform a fuzzy search. This is a placeholder for the actual search logic.
    // Replace this with the call to your fuzzy search library.
    final fuzzy = Fuzzy(locationNames,
        options: FuzzyOptions(
          findAllMatches: true,
          threshold: 0.4, // Adjust based on your needs
        ));
    final results = fuzzy.search(query);
    print(results);

    List<String> filteredList = locations.keys
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // item.toLowerCase().contains(query.toLowerCase())).toList();
    // Extract the original location names from the search results.
    // final filteredList = results.map((r) => r.item).toList();

    // Use FutureBuilder to handle the future returned by loadParkingData
    return FutureBuilder<Map<String, List<MapEntry<String, double>>>>(
      future: loadParkingData(), // the Future your method returns
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, List<MapEntry<String, double>>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Return loading indicator while waiting for the data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle the case when there's an error fetching the data
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Once the data is fetched, you can display it
          final topParkingLots = snapshot.data!;

          // Build your list view with the actual data
          return ListView.builder(
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final item = filteredList[index];
              final LatLng coordinates = locations[item]!;
              final List<MapEntry<String, double>>? buildingParkingLots =
                  topParkingLots[item];

              return ListTile(
                title: Text(item),
                onTap: () {
                  // Take action based on the selected item (e.g., show marker on the map)
                  List<Marker> markersToRemove = [];
                  for (Marker currentMarker in _HomePageMapState.my_markers) {
                    if (currentMarker.width == 60) {
                      markersToRemove.add(currentMarker);
                    }
                  }

                  for (Marker removingMarker in markersToRemove) {
                    _HomePageMapState.my_markers.remove(removingMarker);
                  }
                  _HomePageMapState.controller
                      .moveAndRotate(coordinates, 19, 0);
                  _HomePageMapState.my_markers.add(Marker(
                    point: coordinates,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: GestureDetector(
                      onTap: () {
                        _HomePageMapState.controller
                            .moveAndRotate(coordinates, 20, 0);
                      },
                      child: const Icon(
                        Icons.location_pin,
                        color: Color.fromARGB(255, 7, 3, 238),
                        size: 30,
                      ),
                    ),
                  ));
                  // Close the search bar
                  close(context, null);

                  if (buildingParkingLots != null &&
                      buildingParkingLots.isNotEmpty) {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return _buildParkingLotBottomSheet(
                            context, buildingParkingLots);
                      },
                    );
                  }
                },
              );
            },
          );
        } else {
          // Handle the case when there's no data but also no error
          return const Center(child: Text('No data available'));
        }
      },
    );
  }

  Widget _buildParkingLotBottomSheet(
      BuildContext context, List<MapEntry<String, double>> parkingLots) {
    return DraggableScrollableSheet(
      initialChildSize: 0.3, // 30% of screen height
      minChildSize: 0.2, // 20% of screen height
      maxChildSize: 0.6, // 60% of screen height
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
            boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
          ),
          child: Column(
            children: [
              SizedBox(
                height: 24,
                child: Center(
                  child: Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(2.5)),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: parkingLots.length,
                  itemBuilder: (BuildContext context, int index) {
                    final parkingLotEntry = parkingLots[index];
                    return ListTile(
                      title: Text(
                          '${parkingLotEntry.key}: ${parkingLotEntry.value.toStringAsFixed(2)} meters'),
                      // When you want to show the HistogramScreen, pass the location parameter
                      onTap: () {
                        LatLng loc = parking_locations[parkingLotEntry
                            .key]!; // Get the location data for the selected parking lot
                        _HomePageMapState.selectedDestination = loc;
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                return HistogramScreen(
                                    location:
                                        loc); // Pass the location data here
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResult();
  }
}

bool isReturningFromMaps = false;
Future<void> openMap(double lat, double long) async {
  String googleMapsUrl =
      "https://www.google.com/maps/search/?api=1&query=$lat,$long";
  String appleMapsUrl = "https://maps.apple.com/?q=$lat,$long";
  String geoUrl = "geo:$lat,$long";
  // _HomePageMapState.selectedDestination = LatLng(lat, long);
  Uri mapUrl =
      Platform.isIOS ? Uri.parse(appleMapsUrl) : Uri.parse(googleMapsUrl);

  try {
    if (await canLaunchUrl(mapUrl)) {
      // Set the flag right before launching the maps app
      isReturningFromMaps = true;
      await launchUrl(mapUrl); //ol
    } else if (await canLaunchUrl(Uri.parse(geoUrl))) {
      // Launch the default maps app
      isReturningFromMaps = true;
      await launchUrl(Uri.parse(geoUrl));
    } else {
      throw 'Could not launch map';
    }
  } catch (e) {}
}

class HistogramScreen extends StatefulWidget {
  final LatLng location;

  // Updated constructor using super parameter for 'key'
  const HistogramScreen({super.key, required this.location});

  @override
  _HistogramScreenState createState() => _HistogramScreenState();
}

Future<List<dynamic>> loadPredictions(String day) async {
  String jsonString =
      await rootBundle.loadString('lib/assets/predictions.json');
  Map<String, dynamic> preds = jsonDecode(jsonString);

  switch (day) {
    case "Mon":
      return preds["Monday"];
    case "Tue":
      return preds["Tuesday"];
    case "Wed":
      return preds["Wednesday"];
    case "Thu":
      return preds["Thursday"];
    case "Fri":
      return preds["Friday"];
    default:
      return preds["Monday"];
  }
}

class _HistogramScreenState extends State<HistogramScreen> {
  late String selectedDay; // Default to Monday
  final List<String> _days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  // Placeholder data for the histogram
  List<ChartData> chartData = [
    ChartData('7am', 20),
    ChartData('8am', 30),
    ChartData('9am', 45),
    ChartData('10am', 70),
    ChartData('11am', 65),
    ChartData('12pm', 65),
    ChartData('1pm', 65),
    ChartData('2pm', 80),
    ChartData('3pm', 80),
    ChartData('4pm', 40),
    ChartData('5pm', 20),
    ChartData('6pm', 20)
  ];

  @override
  void initState() {
    super.initState();
    // Set the default day to today's weekday
    int currentWeekday = DateTime.now().weekday;
    // Dart's DateTime class defines Sunday as 7 instead of 0
    selectedDay = _days[currentWeekday % 7 == 0 ? 6 : currentWeekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histogram Data'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context), // Close the screen
        ),
        actions: <Widget>[
          DropdownButton<String>(
            value: selectedDay,
            icon: const Icon(Icons.arrow_drop_down),
            onChanged: (String? newValue) async {
              setState(() {
                selectedDay = newValue!;
              });
              // Update your histogram data here based on the selectedDay
              List<double> preds = loadPredictions(selectedDay) as List<double>;
              chartData = [
                ChartData('7am', preds[0]),
                ChartData('8am', preds[1]),
                ChartData('9am', preds[2]),
                ChartData('10am', preds[3]),
                ChartData('11am', preds[4]),
                ChartData('12pm', preds[5]),
                ChartData('1pm', preds[6]),
                ChartData('2pm', preds[7]),
                ChartData('3pm', preds[8]),
                ChartData('4pm', preds[9]),
                ChartData('5pm', preds[10]),
                ChartData('6pm', preds[11])
              ];
              // });
            },
            items: _days.map<DropdownMenuItem<String>>((String day) {
              return DropdownMenuItem<String>(
                value: day,
                child: Text(day),
              );
            }).toList(),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_outlined),
            onPressed: () {
              // Use the location data to open Google Maps
              openMap(widget.location.latitude, widget.location.longitude);
            },
          ),
        ],
      ),
      body: SfCartesianChart(
        // Configure the axes and series as needed
        primaryXAxis: const CategoryAxis(),
        series: <ColumnSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: chartData,
            xValueMapper: (ChartData data, _) => data.time,
            yValueMapper: (ChartData data, _) => data.value,
          ),
        ],
      ),
    );
  }
}

class ChartData {
  ChartData(this.time, this.value);
  final String time;
  final double value;
}
