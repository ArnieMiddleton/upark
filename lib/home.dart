import 'package:upark/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'survey.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
              icon: Icon(Icons.settings),
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

class _HomePageMapState extends State<HomePageMap> {
  final MapController controller = MapController();
  LatLng latLng = const LatLng(40.76497, -111.84611);

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
                "https://api.mapbox.com/styles/v1/notrh99/clrzb93vx009s01pu7y5g5wyt/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoibm90cmg5OSIsImEiOiJjbHJremlxaHUwa205MmprZGJ3dWFzYWR3In0.R-PO20FWueN9Mzx9EwmeEA"),
        MarkerLayer(
          markers: [
            Marker( //1 Done
              point: const LatLng(40.76047615, -111.8457732),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76047615, -111.8457732), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              )
            ),
            Marker( //2 //Done
              point: const LatLng(40.76609893830639, -111.84567689958726),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76609893830639, -111.84567689958726), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              )
            ),
            Marker( //3 //Done
              point: const LatLng(40.76553734, -111.8475873),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76553734, -111.8475873), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              )
            ),
            Marker( //4 //Done
              point: const LatLng(40.75964557, -111.8510534),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.75964557, -111.8510534), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              )
            ),
            Marker(//5 Done
              point: const LatLng(40.76184712, -111.8487463),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76184712, -111.8487463), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//6 Done
              point: const LatLng(40.76239342, -111.847587),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76239342, -111.847587), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//7 Done
              point: const LatLng(40.76021823, -111.8443649),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76021823, -111.8443649), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//8 Done
              point: const LatLng(40.76146288, -111.8381891),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76146288, -111.8381891), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//9 Done
              point: const LatLng(40.76650879, -111.8450367),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76650879, -111.8450367), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//10 Done
              point: const LatLng(40.76343596, -111.8532355),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76343596, -111.8532355), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//11
              point: const LatLng(40.76679045, -111.8514649),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76679045, -111.8514649), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//12
              point: const LatLng(40.76612338, -111.8456363),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76612338, -111.8456363), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//13
              point: const LatLng(40.76545653, -111.8375496),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76545653, -111.8375496), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//14
              point: const LatLng(40.76108824, -111.8425409),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76108824, -111.8425409), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//15
              point: const LatLng(40.75947206, -111.8460659),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.75947206, -111.8460659), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//16
              point: const LatLng(40.76183744, -111.850429),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76183744, -111.850429), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//17
              point: const LatLng(40.77022927, -111.8462263),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.77022927, -111.8462263), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//18
              point: const LatLng(40.766834, -111.8437108),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.766834, -111.8437108), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//19
              point: const LatLng(40.76930197, -111.8441186),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76930197, -111.8441186), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//20
              point: const LatLng(40.7678793, -111.8480301),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.7678793, -111.8480301), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//21
              point: const LatLng(40.76505561, -111.849477),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76505561, -111.849477), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//22
              point: const LatLng(40.76164289, -111.8414329),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76164289, -111.8414329), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//23
              point: const LatLng(40.76164289, -111.8414329),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76164289, -111.8414329), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//24
              point: const LatLng(40.76164289, -111.8414329),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76164289, -111.8414329), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//25
              point: const LatLng(40.76164289, -111.8414329),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76164289, -111.8414329), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//26
              point: const LatLng(40.76639168, -111.8487693),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76639168, -111.8487693), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//27
              point: const LatLng(40.76639168, -111.8487693),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76639168, -111.8487693), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//27
              point: const LatLng(40.76639168, -111.8487693),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76639168, -111.8487693), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//28
              point: const LatLng(40.76639168, -111.8487693),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76639168, -111.8487693), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//29
              point: const LatLng(40.76639168, -111.8487693),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76639168, -111.8487693), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//30
              point: const LatLng(40.76188585, -111.8404306),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76188585, -111.8404306), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//31
              point: const LatLng(40.76173022, -111.8467084),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76173022, -111.8467084), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//32
              point: const LatLng(40.76307923, -111.8374067),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76307923, -111.8374067), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//33
              point: const LatLng(40.76081929, -111.8395905),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76081929, -111.8395905), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//34
              point: const LatLng(40.7611466, -111.8406582),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.7611466, -111.8406582), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//35
              point: const LatLng(40.76748713, -111.8398083),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76748713, -111.8398083), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//36
              point: const LatLng(40.76608434, -111.8494079),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76608434, -111.8494079), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//37
              point: const LatLng(40.765003, -111.8443877),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.765003, -111.8443877), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//38
              point: const LatLng(40.77055754, -111.843232),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.77055754, -111.843232), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//39
              point: const LatLng(40.76906066, -111.8393496),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76906066, -111.8393496), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
            Marker(//40
              point: const LatLng(40.76502741, -111.8421128),
              width: 30,
              height: 30,
              alignment: Alignment.topCenter,
              child: GestureDetector(
                onTap: () {
                  controller.moveAndRotate(const LatLng(40.76502741, -111.8421128), 20, 0);
                },
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red.shade700,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  String lastQuery = '';
  List<String> searchTerms = [
    'A. Ray Olpin Union',
    'Alfred C. Emery Building',
    'Alice Sheets Marriott Center for Dance',
    'Aline Wilmot Skaggs Biology Building',
    'Annette Poulson Cumming College of Nursing Building',
    'Architecture Building',
    'Art Building',
    'Beverley Taylor Sorenson Arts and Education Complex',
    'Business Classroom Building',
    'C. Roland Christensen Center',
    'Carolyn and Kem Gardner Commons',
    'Carolyn Tanner Irish Humanities Building',
    'Cauldron Legacy Plaza Visitors Ctr',
    'Chase N. Peterson Heritage Center',
    'Cleone Peterson Eccles Alumni House',
    'College of Social Work',
    'David P. Gardner Hall',
    'Dumke Gymnastics Center',
    'Film and Media Arts Building',
    'Fine Arts West',
    'Fort Douglas Bandstand',
    'Fort Douglas Chapel',
    'Fort Douglas Commander’s House',
    'Fort Douglas Officers Club',
    'Fort Douglas Theatre',
    'Frederick Albert Sutton Building',
    'George and Dolores Eccles Institute of Human Genetics',
    'George S Eccles Student Life Center',
    'George S. Eccles Tennis Center Indoor',
    'George S. Eccles Tennis Center Outdoor',
    'Henry Eyring Chemistry Building',
    'HPER East',
    'HPER North',
    'HPER West',
    'Huntsman Cancer Institute',
    'Huntsman Cancer Institute – Primary Children’s and Families’ Cancer Research Center',
    'Intermountain Network Scientific CC',
    'J. Willard Marriott Library',
    'James C. Fletcher Building',
    'James LeVoy Sorenson Molecular Biotechnology Building – A USTAR Innovation Center',
    'James Talmage Building',
    'John & Marcia Price Theatre Arts Building',
    'John A. Moran Eye Center',
    'John A. Widtsoe Building',
    'John and Marva Warnock Engineering Building',
    'John and Marva Warnock Engineering Building (L)',
    'John R. Park Building',
    'Jon M. and Karen Huntsman Basketball Facility',
    'Jon M. Huntsman Center',
    'Joseph F. Merrill Engineering Building',
    'Joseph T. Kingsbury Hall',
    'L.S. Skaggs Jr. Research Building',
    'Language & Communication Building',
    'Lassonde Studios',
    'LeRoy E. Cowles Building',
    'Life Science Building',
    'Marcia & John Price Museum Building',
    'Natural History Museum of Utah',
    'Open Space',
    'Performing Arts Building',
    'Pierre Lassonde Entrepreneur Center',
    'Red Butte Garden Amphitheatre',
    'Red Butte Garden Rose House',
    'Rice-Eccles Stadium',
    'Richard K. Hemingway Orangerie',
    'Rio Tinto Kennecott Mechanical Engineering Building',
    'Robert H. and Katharine B. Garff Executive Education Building',
    'Roy W. & Elizabeth E. Simmons Pioneer Memorial Theatre',
    'S.J.Quinney College of Law',
    'School of Medicine',
    'Social & Behavioral Sciences',
    'Social Beh. Science Lecture Hall',
    'Spence and Cleone Eccles Football Center',
    'Spence Eccles Field House',
    'Spencer F. and Cleone P. Eccles Health Sciences Education Building',
    'Spencer Fox Eccles Business Building',
    'Spencer S. Eccles Health Sciences Library',
    'Sterling Sill Center',
    'Student Services Building',
    'Thatcher Building for Biological and Biophysical Chemistry',
    'The Gary L. and Ann T. Crocker Science Center at the George Thomas Building',
    'Thomas S. Monson Center',
    'University Guest House',
    'William C. Browning Building',
    'William Stewart Building',
  ];

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
    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const moqup1Screen(),
        ),
      );
    });

    // Placeholder for the search result view
    return const Center(
      child: Text('Searching...'),
    );
  }

  // => const Center(
  //   child: Text(
  //     "WELCOME TO HOMEPAGE",)
  // );
  // {
  //   List<String> mathcQuery = [];
  //   for (var building in searchTerms) {
  //     if (building.toLowerCase().contains(query.toLowerCase())) {
  //       mathcQuery.add(building);
  //     }
  //   }
  //   return ListView.builder(
  //     itemCount: mathcQuery.length,
  //     itemBuilder: (context, index) {
  //       var result = mathcQuery[index];
  //       return ListTile(
  //         title: Text(result),
  //         onTap: () {
  //           query = result;
  //           close(context,query);
  //           showResults((context));
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> mathcQuery = [];
    for (var building in searchTerms) {
      if (building.toLowerCase().contains(query.toLowerCase())) {
        mathcQuery.add(building);
      }
    }
    return ListView.builder(
      itemCount: mathcQuery.length,
      itemBuilder: (context, index) {
        var result = mathcQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
            showResults((context));
          },
        );
      },
    );
  }
}

class moqup2Screen extends StatelessWidget {
  const moqup2Screen({super.key});

  static Future<void> openMap(double lat, double long) async {
    Uri googleMapUrl =
        Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long");
    if (await canLaunchUrl(googleMapUrl)) {
      // Checking if google map is installed on the device
      await launchUrl(googleMapUrl);
    } else {
      // If Google Maps is not installed, you might want to show a dialog to the user or handle it otherwise
      throw 'Could not open the map.';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Capture the Navigator state before the async operation
    final NavigatorState navigator = Navigator.of(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () async {
          await openMap(40.76497, -111.84611); // Open Google Maps first
          if (!navigator.mounted) {
            return;
          }
          // Use the navigator after the async operation
          navigator.push(
            MaterialPageRoute(
              builder: (context) => const ParkingLotSurveyScreen(),
            ),
          );
        },
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/moqup_2.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class moqup1Screen extends StatelessWidget {
  const moqup1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const moqup2Screen()));
      },
      child: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/moqup_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
