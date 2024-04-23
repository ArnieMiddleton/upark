import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';
import 'package:upark/campus.dart';
import 'package:upark/map.dart';

class SearchBarDelegate extends SearchDelegate {
  MapPageState mapState = MapPageState.currentMapStateInstance!;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query.isEmpty ? close(context, null) : query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  List<String> getSearchedBuildingNames(Campus campusData, String query) {
    var buildings = campusData.buildings;
    List<String> buildingNamesAndCodes = [];

    for (var building in buildings) {
      String buildingName = building.name;
      String buildingCode = building.code == null ? '' : '(${building.code})';
      buildingNamesAndCodes.add('$buildingName $buildingCode');
    }

    var fuzzy = Fuzzy<String>(buildingNamesAndCodes,
        options: FuzzyOptions(
          findAllMatches: true,
          isCaseSensitive: true,
          shouldSort: true,
          tokenize: true,
          tokenSeparator: ' ',
        ));
    var results = fuzzy.search(query);
    return results.map((result) => result.item).toList();
  }

  List<Building> getSearchedBuildings(Campus campus, String query) {
    var buildings = campus.buildings;

    var fuzzy = Fuzzy<Building>(buildings,
        options: FuzzyOptions(
            findAllMatches: true,
            isCaseSensitive: true,
            shouldSort: true,
            tokenize: true,
            tokenSeparator: ' ',
            keys: [
              WeightedKey(
                name: 'name',
                weight: 0.4,
                getter: (building) => building.name,
              ),
              WeightedKey(
                name: 'code',
                weight: 0.5,
                getter: (building) => building.code ?? '',
              ),
              WeightedKey(
                name: 'address',
                weight: 0.1,
                getter: (building) => building.streetAddress ?? '',
              )
            ]));

    var results = fuzzy.search(query);
    return results.map((result) => result.item).toList();
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Campus>(
      future: mapState.campus,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final campusData = snapshot.data!;
          final buildings = getSearchedBuildings(campusData, query);

          return ListView.builder(
            itemCount: buildings.length,
            itemBuilder: (context, index) {
              final building = buildings[index];
              List<Lot> buildingParkingLots =
                  []; // TODO: Get building parking lots by location
              return ListTile(
                title: Text(building.name),
                subtitle: Text(building.code ?? ''),
                onTap: () {
                  // TODO: Update the markers on the map
                  // Mark building with blue marker
                  // Remove old building marker if it exists

                  // Close the search bar
                  close(context, building);

                  // Show the bottom shee with the building's info
                  mapState.showBuildingInfo(building, buildingParkingLots);
                },
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
