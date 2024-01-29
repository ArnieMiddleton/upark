import 'package:upark/settings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'survey.dart';

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
      body: HomePageImage(),
    );
  }
}

class HomePageImage extends StatefulWidget {
  @override
  _HomePageImageState createState() => _HomePageImageState();
}

class _HomePageImageState extends State<HomePageImage> {
  Offset _position = const Offset(0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const moqup1Screen()));
      },
      child: Stack(
        children: <Widget>[
          Positioned(
              left: _position.dx,
              top: _position.dy,
              child: Container(
                alignment: Alignment.center,
                child: Draggable(
                  feedback: Image.asset('lib/images/Parking-Lot-Occupancy.png',
                      fit: BoxFit.cover),
                  childWhenDragging: Container(),
                  onDraggableCanceled: (_, __) {},
                  onDragEnd: (details) {
                    setState(() {
                      _position = details.offset;
                    });
                  },
                  child: Image.asset('lib/images/Parking-Lot-Occupancy.png',
                      fit: BoxFit.cover),
                ),
              )),
        ],
      ),
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
