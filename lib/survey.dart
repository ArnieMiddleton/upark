import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'home.dart';


class ParkingLotSurveyScreen extends StatefulWidget {
  final LatLng selectedLot;

  const ParkingLotSurveyScreen({Key? key, required this.selectedLot}) : super(key: key);

  @override
  State<ParkingLotSurveyScreen> createState() => _ParkingLotSurveyScreenState();
}

class _ParkingLotSurveyScreenState extends State<ParkingLotSurveyScreen> {
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
  int? _chosenIndex;
  String? _selectedOption;
  final List<String> _options = [
    'Full',
    'Almost Full',
    'Moderate',
    'Some Spots',
    'Plenty of Spots'
  ];
  
  void _submitSurvey() {
    if (_chosenIndex != null) {
      // Update the _selectedOption with the chosen option's text
      setState(() {
        _selectedOption = _options[_chosenIndex!];

        // print("selected option is ");
        // print(_selectedOption);
        List<LatLng> valsList = parkinglotsLocation.values.toList();
        int listIndex = valsList.indexOf(widget.selectedLot);
        String lotName = parkinglotsLocation.keys.toList()[listIndex];

        Color green = Colors.green;
        Color yellow = Colors.yellow.shade600;
        Color orange = Colors.orange.shade600;
        Color red = Colors.red.shade700;
        Color updatedColor;
        if (_chosenIndex == 0 || _chosenIndex == 1)
        {
          updatedColor = red;
        }
        else if(_chosenIndex == 2)
        {
          updatedColor = orange;
        }
        else if(_chosenIndex == 3)
        {
          updatedColor = yellow;
        }
        else {
          updatedColor = green;
        }


        // FOR TESTING/DEMOING 
        // updatedColor = Colors.black;
        HomePageMap.callStateScreen(updatedColor, lotName, listIndex, widget.selectedLot);
        
      });

      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Parking Lot Survey',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: Colors.red[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'How busy was the parking lot?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontFamily: 'Quicksand',
              ),
            ),
            const SizedBox(height: 20), // Spacing between question and buttons
            ..._options.asMap().entries.map((entry) {
              int idx = entry.key;
              String text = entry.value;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _chosenIndex = idx;
                  }),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _chosenIndex == idx ? Colors.blue : Colors.white,
                    foregroundColor:
                        _chosenIndex == idx ? Colors.white : Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(
                        color: _chosenIndex == idx
                            ? Colors.blue
                            : Colors.grey.shade300,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                  ),
                  child: Text(
                    // `child` is the last property as recommended.
                    text,
                    style: const TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 22,
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(
                height: 20), // Spacing between buttons and the submit button
            ElevatedButton(
              onPressed: _chosenIndex != null ? _submitSurvey : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _chosenIndex != null ? Colors.green : Colors.grey,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: const Text(
                // `child` is the last property as recommended.
                'Submit',
                style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 22,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
