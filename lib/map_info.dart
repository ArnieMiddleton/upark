import 'package:flutter/material.dart';
import 'package:upark/campus.dart';
import 'package:upark/components/color_scheme.dart';

Widget mapInfoDialog(
    List<double> legendPercentages,
    Color Function(double percentage, bool coloblind) percentageToColor,
    Future<Campus> campus) {
  return FutureBuilder<Campus>(
      future: campus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var campusData = snapshot.data!;
          return AlertDialog(
              backgroundColor: UtahColorScheme.secondary,
              title: const Text('Map Legend:'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (var percentage in legendPercentages)
                    Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          color: percentageToColor(
                              percentage, campusData.user.colorblind),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${percentage * 100}%',
                          style: const TextStyle(
                              color: UtahColorScheme.onSecondary),
                        )
                      ],
                    ),
                ],
              ));
        } else if (snapshot.hasError) {
          return AlertDialog(
            backgroundColor: UtahColorScheme.error,
            title: Text('Error ${snapshot.error}'),
            titleTextStyle: const TextStyle(color: UtahColorScheme.onError),
            contentTextStyle: const TextStyle(color: UtahColorScheme.onError),
            content: Text('${snapshot.error}'),
          );
        } else {
          return const AlertDialog(
            backgroundColor: UtahColorScheme.error,
            title: Text('Loading...'),
            titleTextStyle: TextStyle(color: UtahColorScheme.onError),
            content: CircularProgressIndicator(),
          );
        }
      });
}
