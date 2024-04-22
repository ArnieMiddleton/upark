import 'package:flutter/material.dart';
import 'package:upark/authentication.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/map.dart';
import 'package:upark/map_info.dart';
import 'package:upark/search.dart';
import 'package:upark/settings.dart';

class HomePage extends StatelessWidget {
  final Future<AppUser> user;

  const HomePage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    double leadingWidth = 100;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: UtahColorScheme.background,
            leadingWidth: leadingWidth,
            leading: SizedBox(
                width: leadingWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.settings),
                        color: UtahColorScheme.onBackground,
                        iconSize: 30.0,
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SettingsPage()));
                        }),
                    IconButton(
                        icon: const Icon(Icons.info_outline),
                        color: UtahColorScheme.onBackground,
                        iconSize: 30.0,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return mapInfoDialog(
                                    [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
                                    MapPageState.lotMarkerColor,
                                    user);
                              });
                        })
                  ],
                )),
            title: InkWell(
              onTap: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              },
              child: Container(
                  height: 35,
                  width: 250,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: UtahColorScheme.onBackground,
                      width: 1.4,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Icon(
                          Icons.search,
                          color: UtahColorScheme.onBackground,
                        ),
                      ),
                      Flexible(
                        // Use Flexible to ensure the text fits the remaining space
                        child: Text(
                          'Search Buildings',
                          style: TextStyle(
                            color: UtahColorScheme.onBackground,
                            overflow: TextOverflow
                                .ellipsis, // Use ellipsis for text overflow
                          ),
                        ),
                      ),
                    ],
                  )),
            )),
        body: MapPage(user));
  }
}
