import 'package:flutter/material.dart';

class ParkingLotSurveyScreen extends StatefulWidget {
  const ParkingLotSurveyScreen({Key? key}) : super(key: key);

  @override
  State<ParkingLotSurveyScreen> createState() => _ParkingLotSurveyScreenState();
}

class _ParkingLotSurveyScreenState extends State<ParkingLotSurveyScreen> {
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
