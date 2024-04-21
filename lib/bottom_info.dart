import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upark/campus.dart';
import 'package:upark/components/color_scheme.dart';

void showBuildingClosestLots(BuildContext context, Building building, List<Lot> buildingParkingLots) {
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
                  child: const Column(
                    children: [
                      // TODO: Add building info
                      SizedBox(child: Text("Building Info Sized Box")),
                      Expanded(child: Text("Building Info Expanded"))
                    ],
                  ));
            });
      });
}

void showLotHistogram(BuildContext context, Lot lot) {

}
