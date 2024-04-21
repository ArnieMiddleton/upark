import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:upark/campus.dart';
import 'package:upark/map.dart';

class HistogramScreen extends StatefulWidget {
  final Lot lot;
  final MapPageState mapState;

  // Updated constructor using super parameter for 'key'
  const HistogramScreen({super.key, required this.lot, required this.mapState});

  @override
  State<StatefulWidget> createState() {
    return HistogramScreenState();
  }
}

enum DayOfWeek {
  // Weekdays start at 0 (Monday) and end at 6 (Sunday) to match Dart's DateTime class
  Monday(name: "Monday", abbreviation: "Mon"),
  Tuesday(name: "Tuesday", abbreviation: "Tue"),
  Wednesday(name: "Wednesday", abbreviation: "Wed"),
  Thursday(name: "Thursday", abbreviation: "Thu"),
  Friday(name: "Friday", abbreviation: "Fri"),
  Saturday(name: "Saturday", abbreviation: "Sat"),
  Sunday(name: "Sunday", abbreviation: "Sun");

  final String name;
  final String abbreviation;

  const DayOfWeek({
    required this.name,
    required this.abbreviation,
  });

  @override
  String toString() {
    return name;
  }

  String toShortString() {
    return abbreviation;
  }

  DayOfWeek fromString(String day) {
    return DayOfWeek.values
        .firstWhere((e) => (e.name == day) || (e.abbreviation == day));
  }
}

class HistogramScreenState extends State<HistogramScreen> {
  late Future<LotPrediction> prediction;

  Future<LotPrediction> loadPrediction(Lot lot, DayOfWeek day) async {
    // List<dynamic> jsonPredictions = await loadPredictions(day.abbreviation);
    // List<(TimeOfDay, double)> parsedPredictions = [];
    // for (var pred in jsonPredictions) {
    //   TimeOfDay time = TimeOfDay(hour: pred[0], minute: pred[1]);
    //   double value = pred[2];
    //   parsedPredictions.add((time, value));
    // }
    // return LotPrediction(lot: lot, day: day, predictions: parsedPredictions);
    // TODO: Implement this method
    // As a temporary placeholder, return a prediction with random data
    return LotPrediction(
        lot: lot,
        day: day,
        predictions: List.generate(
            12,
            (index) => (TimeOfDay(hour: index + 8, minute: 0), Random().nextDouble())
        )
    );
  }

  @override
  void initState() {
    super.initState();
    // Load the predictions for the selected day (default to today)
    prediction =
        loadPrediction(widget.lot, DayOfWeek.values[DateTime.now().weekday]);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LotPrediction>(
        future: prediction,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return Scaffold(
                appBar: AppBar(
                    title: Text('Availability Prediction for ${data.lot.name}'),
                    leading: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          Navigator.pop(context), // Close the histogram
                    ),
                    actions: [
                      DropdownButton<String>(
                          value: data.day.toShortString(),
                          icon: const Icon(Icons.arrow_drop_down),
                          onChanged: (String? newValue) async {
                            setState(() {
                              prediction = loadPrediction(
                                  data.lot, data.day.fromString(newValue!));
                            });
                          },
                          items: DayOfWeek.values
                              .map<DropdownMenuItem<String>>((DayOfWeek day) {
                            return DropdownMenuItem<String>(
                              value: day.toShortString(),
                              child: Text(day
                                  .toString()), // May need to change to day.toShortString() depending on the display
                            );
                          }).toList()),
                      IconButton(
                          icon: const Icon(Icons.arrow_forward_outlined),
                          onPressed: () {
                            widget.mapState.openMapAppToLot(data.lot); // May need to be updated if bugs occur
                          })
                    ]),
                body: SfCartesianChart(
                    // Configure the axes and series as needed
                    primaryXAxis: const CategoryAxis(
                      name: 'Time',
                      title: AxisTitle(text: 'Time'),
                    ),
                    primaryYAxis: const NumericAxis(
                      name: 'Occupancy',
                      title: AxisTitle(text: 'Occupancy'),
                      minimum: 0,
                      maximum: 100,
                    ),
                    series: <ColumnSeries<(TimeOfDay, double), String>>[
                      ColumnSeries<(TimeOfDay, double), String>(
                        dataSource: data.predictions,
                        xValueMapper: (pred, _) => pred.$1.format(
                            context), // Formats according to the user's locale
                        yValueMapper: (pred, _) => (pred.$2 * 100)
                            .floor()
                            .toInt(), // Convert to percentage
                      )
                    ]));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const CircularProgressIndicator();
            // TODO: Add a loading spinner or message
          }
        });
  }
}

class LotPrediction {
  final Lot lot;
  final DayOfWeek day;
  final List<(TimeOfDay, double)> predictions;

  LotPrediction(
      {required this.lot, required this.day, required this.predictions});
}
