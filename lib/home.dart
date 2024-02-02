import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:upark/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'survey.dart';
import 'package:latlong2/latlong.dart';
import 'dart:developer' as developer;

// Homepage
class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.settings),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsScreen()));
              },
            ),
          ],
        ),
        title: InkWell(
          onTap: () {
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
          child: Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 1.4,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Search Buildings',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ],
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
}

class _HomePageMapState extends State<HomePageMap> with WidgetsBindingObserver {
  static final MapController controller = MapController();
  ValueNotifier<bool> isSheetExpanded = ValueNotifier(false);
  static bool isReturningFromGoogleMaps = false;
  LatLng latLng = const LatLng(40.76497, -111.84611);
  static List<Marker> my_markers = [
    Marker(
        //1 Done
        point: const LatLng(40.76047615, -111.8457732),
        width: 30,
        height: 30,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(
                const LatLng(40.76047615, -111.8457732), 20, 0);
            openMap(40.76047615, -111.8457732);
          },
          child: Icon(
            Icons.location_pin,
            color: Colors.red.shade700,
            size: 25,
          ),
        )),
    Marker(
        //2 //Done
        point: const LatLng(40.76609893830639, -111.84567689958726),
        width: 30,
        height: 30,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(
                const LatLng(40.76609893830639, -111.84567689958726), 20, 0);

            openMap(40.76609893830639, -111.84567689958726);
          },
          child: Icon(
            Icons.location_pin,
            color: Colors.red.shade700,
            size: 25,
          ),
        )),
    Marker(
        //3 //Done
        point: const LatLng(40.76553734, -111.8475873),
        width: 30,
        height: 30,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(
                const LatLng(40.76553734, -111.8475873), 20, 0);
            openMap(40.76553734, -111.8475873);
          },
          child: Icon(
            Icons.location_pin,
            color: Colors.red.shade700,
            size: 25,
          ),
        )),
    Marker(
        //4 //Done
        point: const LatLng(40.75964557, -111.8510534),
        width: 30,
        height: 30,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(
                const LatLng(40.75964557, -111.8510534), 20, 0);
            openMap(40.75964557, -111.8510534);
          },
          child: Icon(
            Icons.location_pin,
            color: Colors.red.shade700,
            size: 25,
          ),
        )),
    Marker(
      //5 Done
      point: const LatLng(40.76184712, -111.8487463),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76184712, -111.8487463), 20, 0);
          openMap(40.76184712, -111.8487463);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //6 Done
      point: const LatLng(40.76239342, -111.847587),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76239342, -111.847587), 20, 0);
          openMap(40.76239342, -111.847587);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //7 Done
      point: const LatLng(40.76021823, -111.8443649),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76021823, -111.8443649), 20, 0);
          openMap(40.76021823, -111.8443649);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //8 Done
      point: const LatLng(40.76146288, -111.8381891),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76146288, -111.8381891), 20, 0);
          openMap(40.76146288, -111.8381891);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //9 Done
      point: const LatLng(40.76650879, -111.8450367),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76650879, -111.8450367), 20, 0);
          openMap(40.76650879, -111.8450367);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //10 Done
      point: const LatLng(40.76343596, -111.8532355),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76343596, -111.8532355), 20, 0);
          openMap(40.76343596, -111.8532355);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //11
      point: const LatLng(40.76679045, -111.8514649),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76679045, -111.8514649), 20, 0);
          openMap(40.76679045, -111.8514649);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //12
      point: const LatLng(40.76546238902576, -111.84641257823544),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76546238902576, -111.84641257823544), 20, 0);
          openMap(40.76546238902576, -111.84641257823544);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //13
      point: const LatLng(40.76545653, -111.8375496),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76545653, -111.8375496), 20, 0);
          openMap(40.76545653, -111.8375496);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //14
      point: const LatLng(40.76108824, -111.8425409),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76108824, -111.8425409), 20, 0);
          openMap(40.76108824, -111.8425409);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //15
      point: const LatLng(40.75947206, -111.8460659),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.75947206, -111.8460659), 20, 0);
          openMap(40.75947206, -111.8460659);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //16
      point: const LatLng(40.76183744, -111.850429),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76183744, -111.850429), 20, 0);
          openMap(40.76183744, -111.850429);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //17
      point: const LatLng(40.77022927, -111.8462263),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.77022927, -111.8462263), 20, 0);
          openMap(40.77022927, -111.8462263);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //18
      point: const LatLng(40.766834, -111.8437108),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.766834, -111.8437108), 20, 0);
          openMap(40.766834, -111.8437108);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //19
      point: const LatLng(40.76930197, -111.8441186),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76930197, -111.8441186), 20, 0);
          openMap(40.76930197, -111.8441186);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //20
      point: const LatLng(40.7678793, -111.8480301),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.7678793, -111.8480301), 20, 0);
          openMap(40.7678793, -111.8480301);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //21
      point: const LatLng(40.76505561, -111.849477),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76505561, -111.849477), 20, 0);
          openMap(40.76505561, -111.849477);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //22
      point: const LatLng(40.76164289, -111.8414329),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76164289, -111.8414329), 20, 0);
          openMap(40.76164289, -111.8414329);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //23
      point: const LatLng(40.76164289, -111.8414329),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76164289, -111.8414329), 20, 0);
          openMap(40.76164289, -111.8414329);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //24
      point: const LatLng(40.76164289, -111.8414329),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76164289, -111.8414329), 20, 0);
          openMap(40.76164289, -111.8414329);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //25
      point: const LatLng(40.76164289, -111.8414329),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76164289, -111.8414329), 20, 0);
          openMap(40.76164289, -111.8414329);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //26
      point: const LatLng(40.76639168, -111.8487693),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76639168, -111.8487693), 20, 0);
          openMap(40.76639168, -111.8487693);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //27
      point: const LatLng(40.76639168, -111.8487693),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76639168, -111.8487693), 20, 0);
          openMap(40.76639168, -111.8487693);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //27
      point: const LatLng(40.76639168, -111.8487693),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76639168, -111.8487693), 20, 0);
          openMap(40.76639168, -111.8487693);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //28
      point: const LatLng(40.76639168, -111.8487693),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76639168, -111.8487693), 20, 0);
          openMap(40.76639168, -111.8487693);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //29
      point: const LatLng(40.76639168, -111.8487693),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76639168, -111.8487693), 20, 0);
          openMap(40.76639168, -111.8487693);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //30
      point: const LatLng(40.76188585, -111.8404306),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76188585, -111.8404306), 20, 0);
          openMap(40.76188585, -111.8404306);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //31
      point: const LatLng(40.76173022, -111.8467084),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76307923, -111.8374067), 20, 0);
          openMap(40.76307923, -111.8374067);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //32
      point: const LatLng(40.76307923, -111.8374067),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76307923, -111.8374067), 20, 0);
          openMap(40.76307923, -111.8374067);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //33
      point: const LatLng(40.76081929, -111.8395905),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76081929, -111.8395905), 20, 0);
          openMap(40.76081929, -111.8395905);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //34
      point: const LatLng(40.7611466, -111.8406582),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.7611466, -111.8406582), 20, 0);
          openMap(40.7611466, -111.8406582);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //35
      point: const LatLng(40.76748713, -111.8398083),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76748713, -111.8398083), 20, 0);
          openMap(40.76748713, -111.8398083);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //36
      point: const LatLng(40.76608434, -111.8494079),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76608434, -111.8494079), 20, 0);
          openMap(40.76608434, -111.8494079);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //37
      point: const LatLng(40.765003, -111.8443877),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.765003, -111.8443877), 20, 0);
          openMap(40.765003, -111.8443877);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //38
      point: const LatLng(40.77055754, -111.843232),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.77055754, -111.843232), 20, 0);
          openMap(40.77055754, -111.843232);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //39
      point: const LatLng(40.76906066, -111.8393496),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76906066, -111.8393496), 20, 0);
          openMap(40.76906066, -111.8393496);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
    Marker(
      //40
      point: const LatLng(40.76502741, -111.8421128),
      width: 30,
      height: 30,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          controller.moveAndRotate(
              const LatLng(40.76502741, -111.8421128), 20, 0);
          openMap(40.76502741, -111.8421128);
        },
        child: Icon(
          Icons.location_pin,
          color: Colors.red.shade700,
          size: 25,
        ),
      ),
    ),
  ];

  void addMarker(LatLng coordinates) {
    setState(() {
      my_markers.add(Marker(
        point: coordinates,
        width: 60,
        height: 60,
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            controller.moveAndRotate(
                const LatLng(40.76502741, -111.8421128), 20, 0);
          },
          child: const Icon(
            Icons.location_pin,
            color: Color.fromARGB(255, 7, 3, 238),
            size: 30,
          ),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // Register observer
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this); // Unregister observer
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && isReturningFromGoogleMaps) {
      // Reset the flag
      isReturningFromGoogleMaps = false;

      // Now navigate to the survey screen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const ParkingLotSurveyScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: MapOptions(
        initialCenter: latLng,
        initialZoom: 14,
      ),
      children: [
        TileLayer(
            urlTemplate:
                "https://api.mapbox.com/styles/v1/notrh99/cls4817h500dx01po4rvgauqt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
        MarkerLayer(
          markers: my_markers,
        ),
      ],
    );
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
    'Campus Bike Shop': const LatLng(40.7605798, -111.8428217),
    'S.J. Quinney College of Law': const LatLng(40.7612208, -111.8514449),
    'Mineral Processing Lab': const LatLng(40.7665169, -111.8448861),
    'Mining Systems Research Lab': const LatLng(40.7666465, -111.8445482),
    'Experimental Studies Building': const LatLng(40.7660466, -111.8447915),
    'John and Marva Warnock Engineering Building':
        const LatLng(40.7677074, -111.845305),
    'Alice Sheets Marriott Center for Dance':
        const LatLng(40.762399, -111.8485909),
    'Life Science Building': const LatLng(40.763534, -111.8501393),
    'Chemistry Cooling Tower': const LatLng(40.7623958, -111.8502781),
    'High Temperature Water Plant': const LatLng(40.760472, -111.8418901),
    'Recycling Center': const LatLng(40.760223, -111.8413411),
    'Buildings & Grounds Storage Shed #2':
        const LatLng(40.7603222, -111.8403604),
    'Buildings & Grounds Storage Shed #1': const LatLng(40.7604644, -111.84049),
    'Motor Pool Gas Station': const LatLng(40.760738, -111.8399211),
    'Motor Pool Building': const LatLng(40.7605685, -111.8402757),
    'Buildings & Grounds': const LatLng(40.760374, -111.8406457),
    'Physical Plant Services': const LatLng(40.7609436, -111.8412124),
    'Public Safety Storage Shed': const LatLng(40.760029, -111.8408105),
    'George S. Eccles 2002 Legacy Bridge':
        const LatLng(40.7649731, -111.8372508),
    'Joseph F. Merrill Engineering Building':
        const LatLng(40.7685435, -111.8461438),
    'Floyd and Jeri Meldrum Civil Engineering Building':
        const LatLng(40.7670116, -111.8455091),
    'C. Roland Christensen Center': const LatLng(40.761274, -111.8439109),
    'Sculpture Building': const LatLng(40.7604263, -111.8446468),
    'Marcia & John Price Museum Building':
        const LatLng(40.7602453, -111.843287),
    'Social and Behavioral Science Lecture Hall':
        const LatLng(40.7609948, -111.8459596),
    'College of Social Work': const LatLng(40.7609527, -111.8466878),
    'Questar Gas Shed #1': const LatLng(40.7630119, -111.8361847),
    'Roy W. & Elizabeth E. Simmons Pioneer Memorial Theatre':
        const LatLng(40.7627743, -111.8510771),
    'Office Building 44': const LatLng(40.7631331, -111.8484522),
    'Aline Wilmot Skaggs Biology Building':
        const LatLng(40.7636844, -111.8486777),
    'Alfred C. Emery Building': const LatLng(40.7641708, -111.8501068),
    'Steam Generating Plant': const LatLng(40.7656879, -111.8481054),
    'McCarthey Family Track and Field Storage Building':
        const LatLng(40.767219, -111.8391541),
    'Golf Pro Shop': const LatLng(40.7680291, -111.8433072),
    'James LeVoy Sorenson Molecular Biotechnology Building - A USTAR Innovation Center':
        const LatLng(40.7689427, -111.8421158),
    'Office of Sponsored Projects': const LatLng(40.768284, -111.8485698),
    'Fine Arts West': const LatLng(40.7631906, -111.8528793),
    'Cauldron Legacy Plaza Visitors Center':
        const LatLng(40.7588343, -111.8497591),
    'David P. Gardner Hall': const LatLng(40.7662045, -111.8517317),
    'James Talmage Building': const LatLng(40.7644381, -111.8495015),
    'Cowles Cooling Tower': const LatLng(40.7661025, -111.8497673),
    'Beverley Taylor Sorenson Arts & Education Complex':
        const LatLng(40.7628492, -111.8415156),
    'HPER Natatorium': const LatLng(40.7633309, -111.8398826),
    'Skaggs Cooling Tower': const LatLng(40.7636082, -111.8482286),
    'Building 124': const LatLng(40.7642739, -111.8491462),
    'Thatcher Building for Biological & Biophysical Chemistry':
        const LatLng(40.7617233, -111.849658),
    'Civil and Materials Engineering': const LatLng(40.7664854, -111.8459993),
    'John R. Park Building': const LatLng(40.7650072, -111.8487908),
    'Intermountain Network Scientific Computation Center':
        const LatLng(40.7659168, -111.848729),
    'LeRoy E. Cowles Building': const LatLng(40.7656173, -111.8495495),
    'Naval Science Building': const LatLng(40.766645, -111.8493796),
    'Spencer Fox Eccles Business Building':
        const LatLng(40.7617223, -111.8433843),
    'Spence Eccles Ski Team Building': const LatLng(40.7669476, -111.8405543),
    'Grounds Storage Building': const LatLng(40.7606638, -111.8412352),
    'Salt Lake City Reservoir': const LatLng(40.7592434, -111.8470646),
    'George S. Eccles Student Life Center':
        const LatLng(40.7650827, -111.838233),
    'Pumphouse #3': const LatLng(40.7626118, -111.8359859),
    'North Campus Chiller Plant': const LatLng(40.7674303, -111.8427461),
    'Joseph T. Kingsbury Hall': const LatLng(40.7661964, -111.8509428),
    'Henry Eyring Chemistry Building': const LatLng(40.7623469, -111.8494898),
    'V. Randall Turpin University Services Building':
        const LatLng(40.7613875, -111.8400721),
    'Jon M. Huntsman Center': const LatLng(40.7620589, -111.8387518),
    'Space Planning & Management': const LatLng(40.7687097, -111.8486904),
    'Social & Behavioral Sciences': const LatLng(40.7614548, -111.8462603),
    'Biology Building': const LatLng(40.7635123, -111.8495492),
    'Alan W. Layton Engineering Building': const LatLng(40.7665156, -111.84548),
    'Performing Arts Building': const LatLng(40.7639132, -111.8479817),
    'Eccles House': const LatLng(40.7725992, -111.8437945),
    'Soccer Field Ticket Office': const LatLng(40.7673491, -111.8409302),
    'Equipment Shed': const LatLng(40.7679182, -111.8417775),
    'Dumke Family Softball Stadium': const LatLng(40.7677039, -111.8411626),
    'Field Storage Building': const LatLng(40.7681291, -111.8416951),
    'Einar Nielsen Fieldhouse': const LatLng(40.7612137, -111.8488777),
    'Transformer Building': const LatLng(40.7587237, -111.851231),
    'William Stewart Building': const LatLng(40.7634326, -111.8509426),
    'The Gary L. and Ann T. Crocker Science Center at the George Thomas Building':
        const LatLng(40.7640556, -111.8511161),
    'HPER West': const LatLng(40.762922, -111.8406218),
    'HPER East': const LatLng(40.7636929, -111.8391684),
    'Kenneth P. Burbidge, Jr., Family Athletics Academic Center':
        const LatLng(40.7629723, -111.8396537),
    'HPER North': const LatLng(40.7638422, -111.8403347),
    'HPER Mechanical Building Southwest':
        const LatLng(40.7627283, -111.8396291),
    'Central Garage': const LatLng(40.7616177, -111.8414221),
    'HTW Plant Cooling Tower': const LatLng(40.7607224, -111.8416042),
    'Language & Communication Building': const LatLng(40.763612, -111.843649),
    'Bldg 301': const LatLng(40.7599051, -111.8410001),
    'Art Building': const LatLng(40.7608952, -111.8448774),
    'Architecture Building': const LatLng(40.7611435, -111.8445216),
    'A. Ray Olpin Union': const LatLng(40.7649585, -111.8460258),
    'Carolyn Tanner Irish Humanities Building':
        const LatLng(40.764559, -111.8429781),
    'Student Services Cooling Tower': const LatLng(40.7653175, -111.8484318),
    'Student Services Building': const LatLng(40.7650099, -111.8480666),
    'James C. Fletcher Building': const LatLng(40.7667215, -111.8504586),
    'Physics Maintenance Shed': const LatLng(40.7663155, -111.8497409),
    'Voice & Opera Center': const LatLng(40.7668481, -111.8518531),
    'Frederick Albert Sutton Building': const LatLng(40.7666686, -111.8477967),
    'William C. Browning Building': const LatLng(40.7662422, -111.8477118),
    'SW Cooling Tower': const LatLng(40.7611313, -111.8480044),
    'John A. Widtsoe Building': const LatLng(40.7659103, -111.8501467),
    'J. Willard Marriott Library': const LatLng(40.7624564, -111.8462009),
    'Film and Media Arts Building': const LatLng(40.7612975, -111.8454004),
    'Business Classroom Building': const LatLng(40.7617724, -111.8441455),
    'Pumphouse #8': const LatLng(40.76537, -111.8393343),
    'Donna Garff Marriott Residential Scholars Community':
        const LatLng(40.7638268, -111.8368582),
    'Cleone Peterson Eccles Alumni House':
        const LatLng(40.7658899, -111.8436309),
    'Rosenblatt House': const LatLng(40.7714816, -111.845167),
    'Carolyn and Kem Gardner Commons': const LatLng(40.7633607, -111.8446581),
    'HPER Mechanical Building Southeast':
        const LatLng(40.7629181, -111.8392586),
    'Jon M. and Karen Huntsman Basketball Facility':
        const LatLng(40.7630993, -111.8387277),
    'Northwest Garage': const LatLng(40.7665208, -111.8487329),
    'Sterling Sill Center': const LatLng(40.7653351, -111.8436888),
    'University Campus Store': const LatLng(40.7637118, -111.8475237),
    'Physics Cooling Tower': const LatLng(40.7665293, -111.8498995),
    'SW Cooling Tower': const LatLng(40.7612905, -111.8480052),
    'Physics Building': const LatLng(40.7663942, -111.8500583),
    'Meldrum House': const LatLng(40.7649572948751, -111.853380680972),
    'Building 72': const LatLng(40.7620302, -111.8514106),
    'John & Marcia Price Theatre Arts Building':
        const LatLng(40.7620336, -111.8518393),
    'Impact Prosperity Epicenter Building':
        const LatLng(40.7653564842492, -111.839022701725),
    'Rio Tinto Kennecott Mechanical Engineering Building':
        const LatLng(40.7674748, -111.8477638),
    'Lassonde Studios': const LatLng(40.7645445, -111.8415405),
    'Rice-Eccles Stadium': const LatLng(40.7600622, -111.8489259),
    'Robert H. and Katharine B. Garff Executive Education Building':
        const LatLng(40.7621344, -111.8422519),
    'Dolores Dore Eccles Broadcast Center':
        const LatLng(40.7673162, -111.8378598),
    'Kahlert Village': const LatLng(40.7637771, -111.837987),
    'Dumke Gymnastics Center': const LatLng(40.7643456, -111.8396279),
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
          List<String> filteredList = locations.keys
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();

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
                      onTap: () {
                        //open the parking lot the user selected from the list using openMap(double lat, double long).
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

Future<void> openMap(double lat, double long) async {
  Uri googleMapUrl =
      Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");
  if (await canLaunchUrl(googleMapUrl)) {
    _HomePageMapState.isReturningFromGoogleMaps = true;
    // Checking if google map is installed on the device
    await launchUrl(googleMapUrl);
  } else {
    // If Google Maps is not installed, you might want to show a dialog to the user or handle it otherwise
    throw 'Could not open the map.';
  }
}

// class moqup2Screen extends StatelessWidget {
//   const moqup2Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Capture the Navigator state before the async operation
//     final NavigatorState navigator = Navigator.of(context);

//     return Scaffold(
//       body: GestureDetector(
//         onTap: () async {
//           await openMap(40.76497, -111.84611); // Open Google Maps first
//           if (!navigator.mounted) {
//             return;
//           }
//           // Use the navigator after the async operation
//           navigator.push(
//             MaterialPageRoute(
//               builder: (context) => const ParkingLotSurveyScreen(),
//             ),
//           );
//         },
//         child: Container(
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('lib/images/moqup_2.jpg'),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class moqup1Screen extends StatelessWidget {
//   const moqup1Screen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//             MaterialPageRoute(builder: (context) => const moqup2Screen()));
//       },
//       child: Container(
//         alignment: Alignment.center,
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('lib/images/moqup_1.jpg'),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     ));
//   }
// }
