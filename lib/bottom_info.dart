import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upark/campus.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/lot_histogram.dart';
import 'package:upark/map.dart';

void showBuildingClosestLots(
    BuildContext context, Building building, MapPageState mapState) {
  var campus = mapState.campus;

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            expand: false, // TODO: Maybe change this to true
            builder: (context, scrollController) {
              return Container(
                  decoration: const BoxDecoration(
                      color: UtahColorScheme.background,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10, color: UtahColorScheme.onSurface)
                      ]),
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
                          child: FutureBuilder<Campus>(
                              future: campus,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var campusData = snapshot.data!;
                                  campusData.buildingToLotDistances ??=
                                      Campus.calculateDistances(
                                          campusData.buildings,
                                          campusData.lots);
                                  campusData.buildingToClosestLots ??=
                                      Campus.calculateClosestLots(
                                          campusData.buildingToLotDistances!);
                                  var closestLots = campusData
                                      .buildingToClosestLots![building];
                                  closestLots ??= [];
                                  closestLots.sort((lot1, lot2) =>
                                      lot1.$2.compareTo(lot2.$2));
                                  return ListView.builder(
                                      controller: scrollController,
                                      itemCount: closestLots.length,
                                      itemBuilder: (context, index) {
                                        var lot = closestLots![index].$1;
                                        var distance = closestLots[index].$2;
                                        return ListTile(
                                            title: Text(lot.name),
                                            subtitle: Text(
                                                '${distance.toStringAsFixed(0)} meters away'),
                                            onTap: () {
                                              showLotHistogram(context, lot, mapState);
                                            });
                                      });
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  return const Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('Loading...'),
                                        CircularProgressIndicator(),
                                      ],
                                    ),
                                  );
                                }
                              })),
                    ],
                  ));
            });
      });
}

// void showBuildingInfo(
//     BuildContext context, Building building, MapPageState mapState) {
//   var campus = mapState.campus;
//   showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) {
//         return DraggableScrollableSheet(
//             initialChildSize: 0.3,
//             minChildSize: 0.2,
//             maxChildSize: 0.6,
//             expand: false,
//             builder: (context, scrollController) {
//               return Container(
//                   decoration: const BoxDecoration(
//                       color: UtahColorScheme.background,
//                       borderRadius:
//                           BorderRadius.vertical(top: Radius.circular(18)),
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: 10, color: UtahColorScheme.onSurface)
//                       ]),
//                   child: const Column(
//                     children: [
//                       // TODO: Add building info
//                       SizedBox(child: Text("Building Info Sized Box")),
//                       Expanded(child: Text("Building Info Expanded"))
//                     ],
//                   ));
//             });
//       });
// }

void showLotHistogram(BuildContext context, Lot lot, MapPageState mapState) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) =>
              HistogramScreen(lot: lot, mapState: mapState),
        );
      });
}
