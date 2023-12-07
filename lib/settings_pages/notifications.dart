import 'package:flutter/material.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({Key? key}) : super(key: key);

  @override
  NotificationSettingsScreenState createState() =>
      NotificationSettingsScreenState();
}

class NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  bool allowNotifications = true;
  bool uAlert = false;
  bool parkingLotClosure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: const Text(
              'Allow notifications',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            value: allowNotifications,
            onChanged: (bool value) {
              setState(() {
                allowNotifications = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text(
              'UAlert',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            value: uAlert,
            onChanged: (bool value) {
              setState(() {
                uAlert = value;
              });
            },
          ),
          SwitchListTile(
            title: const Text(
              'Parking lot closure',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            value: parkingLotClosure,
            onChanged: (bool value) {
              setState(() {
                parkingLotClosure = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
