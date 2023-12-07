import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class PermitsScreen extends StatefulWidget {
  const PermitsScreen({Key? key}) : super(key: key);

  @override
  PermitsScreenState createState() => PermitsScreenState();
}

class PermitsScreenState extends State<PermitsScreen> {
  int selectedPermitIndex = 0;
  final List<String> permits = [
    'U Permit',
    'A Permit',
    'HU Permit',
    'CU Permit',
    'CA Permit',
    'HCU Permit',
    'R Permit',
    'SHU Permit',
    'M Permit',
    'T Permit',
    'DT Permit',
    'RP Permit',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Permits',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: CupertinoPicker(
          itemExtent: 32.0,
          onSelectedItemChanged: (int index) {
            setState(() {
              selectedPermitIndex = index;
            });
          },
          children: List<Widget>.generate(permits.length, (int index) {
            return Center(
              child: Text(
                permits[index],
                style: const TextStyle(fontSize: 25, fontFamily: 'Quicksand'),
              ),
            );
          }),
        ),
      ),
    );
  }
}

