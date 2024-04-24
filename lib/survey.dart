import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:upark/campus.dart';
import 'package:upark/client.dart';
import 'package:upark/components/color_scheme.dart';

class ParkingLotSurveyPage extends StatefulWidget {
  final Future<Campus> campusFuture;
  final Lot selectedLot;

  const ParkingLotSurveyPage(
      {super.key, required this.selectedLot, required this.campusFuture});

  @override
  State<StatefulWidget> createState() => ParkingLotSurveyPageState();
}

class ParkingLotSurveyPageState extends State<ParkingLotSurveyPage> {
  late Future<Campus> campusFuture = widget.campusFuture;
  late Lot selectedLot = widget.selectedLot;
  String? chosenOption;
  Map<String, double> surveyOptions = {
    'Full': 1.0,
    'Almost Full': 0.85,
    'Moderately Full': 0.7,
    'Some Spots': 0.5,
    'Plenty of Spots': 0.2,
  };

  Future<Response?> submitSurvey(BuildContext context, Lot chosenLot,
      Future<Campus> campus, double? chosenValue) async {
    if (chosenValue == null) {
      log('No answer selected, or answer not found in surveyOptions.');
      return null;
    }
    // Create a new report
    Report report = Report(
      lotId: chosenLot.id,
      approxFullness: chosenValue,
      time: DateTime.now(),
      weight: 1,
      latitude: chosenLot.location.latitude,
      longitude: chosenLot.location.longitude,
    );

    // Close the survey page
    Navigator.of(context).popUntil((route) => route.isFirst);

    // Get the user
    var user = await campus.then((campus) => campus.user);

    if (report.approxFullness < 0) {
      log('Reported approxFullness is less than 0.0: ${report.approxFullness}, likely because reported unknown. Not sending report.');
      return null;
    }
    // Send the report to the server
    return postReport(report, user);
  }

  void showNoAnswerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('No Answer Selected'),
            content: const Text(
                'Please select an answer before submitting the survey.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Parking Lot Survey',
            style: TextStyle(
              color: UtahColorScheme.onBackground,
              fontWeight: FontWeight.bold,
              fontSize: 30,
              fontFamily: 'Quicksand',
            ),
          ),
          backgroundColor: UtahColorScheme.background,
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'How full is ${selectedLot.name}?',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: UtahColorScheme.onBackground,
                      fontSize: 22,
                      fontFamily: 'Quicksand',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ...surveyOptions.entries.map((entry) {
                    String option = entry.key;
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                chosenOption = option;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: chosenOption == option
                                  ? UtahColorScheme.primary
                                  : UtahColorScheme.background,
                              foregroundColor: chosenOption == option
                                  ? UtahColorScheme.onPrimary
                                  : UtahColorScheme.onBackground,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                  color: chosenOption == option
                                      ? UtahColorScheme.primary
                                      : UtahColorScheme.onBackground,
                                ),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                            ),
                            child: Text(
                              option,
                              style: const TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 22,
                              ),
                            )));
                  }),
                  const SizedBox(
                      height:
                          20), // Spacing between buttons and the submit button
                  ElevatedButton(
                      onPressed: () {
                        if (chosenOption == null) {
                          showNoAnswerDialog(context);
                        } else {
                          submitSurvey(context, selectedLot, campusFuture,
                              surveyOptions[chosenOption]);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: chosenOption != null
                            ? UtahColorScheme.primary
                            : UtahColorScheme.secondary,
                        foregroundColor: UtahColorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                      ),
                      child: const Text(
                        'Submit Survey',
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          fontSize: 22,
                        ),
                      ))
                ])));
  }
}
