import 'package:flutter/material.dart';
import 'package:upark/campus.dart';
import 'package:upark/client.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/lot_histogram.dart';
import 'package:upark/map.dart';

void showBuildingClosestLots(
    BuildContext context, Building building, MapPageState mapState) {
  Future<Campus> campus = mapState.campus;
  Future<List<(Lot lot, int distance)>> closestLots = fetchLotDistancesByCampusAndBuilding(campus, building, limit: 10);

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
            initialChildSize: 0.3,
            minChildSize: 0.2,
            maxChildSize: 0.6,
            expand: false,
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Closest Parking Lots to ${building.name}',
                          style: const TextStyle(
                              color: UtahColorScheme.primary, fontSize: 16, fontWeight: FontWeight.bold),
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Divider(
                        color: UtahColorScheme.onBackground,
                        thickness: 1,
                      ),
                      Expanded(
                          child: FutureBuilder<List<(Lot lot, int distance)>>(
                              future: closestLots,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var closestLots = snapshot.data!;
                                  return ListView.builder(
                                      controller: scrollController,
                                      padding: const EdgeInsets.only(bottom: 8), // Ensure that the last item is not partially hidden
                                      itemExtent: 50,
                                      itemCount: closestLots.length,
                                      itemBuilder: (context, index) {
                                        var lot = closestLots[index].$1;
                                        var distance = closestLots[index].$2;
                                        return ListTile(
                                            title: Text('${lot.name} Parking Lot'),
                                            subtitle:
                                                Text('$distance meters away from building'),
                                            trailing: const Icon(Icons.local_parking, color: UtahColorScheme.primary),
                                            leading: Text('${index + 1}', style: const TextStyle(color: UtahColorScheme.primary, fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center,),
                                            onTap: () {
                                              showLotHistogram(
                                                  context, lot, mapState);
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
