import 'package:flutter/material.dart';
import 'package:upark/authentication.dart';
import 'package:upark/components/color_scheme.dart';

Widget mapInfoDialog(
    List<double> legendPercentages, Color Function(double percentage, bool coloblind) percentageToColor, Future<AppUser> user) {
  return FutureBuilder<AppUser>(
      future: user,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
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
                        color: percentageToColor(percentage, data.colorblind),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${percentage * 100}%',
                        style: const TextStyle(color: UtahColorScheme.onSecondary),
                      )
                    ],
                  ),
              ],
            )
          );
        } else if (snapshot.hasError) {
          return AlertDialog(
            backgroundColor:
                UtahColorScheme.error,
            title: const Text('Error'),
            titleTextStyle: const TextStyle(
                color: UtahColorScheme.onError),
            contentTextStyle: const TextStyle(
                color: UtahColorScheme.onError),
            content: Text('${snapshot.error}'),
          );
        } else {
          return const AlertDialog(
            backgroundColor: UtahColorScheme.error,
            title: Text('Loading...'),
            titleTextStyle: TextStyle(
                color: UtahColorScheme.onError),
            content: CircularProgressIndicator(),
          );
        }
      });
}

