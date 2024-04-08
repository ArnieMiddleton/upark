import 'package:flutter/cupertino.dart';
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
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 22, // Adjust the font size if needed
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(
                height: 35), // Spacing at the top for the first section
            _buildCupertinoSettingSwitchItem(
              title: 'Allow Notifications',
              value: allowNotifications,
              onChanged: (bool value) {
                setState(() {
                  allowNotifications = value;
                });
              },
            ),
            _buildCupertinoSettingSwitchItem(
              title: 'UAlert System',
              value: uAlert,
              onChanged: (bool value) {
                setState(() {
                  uAlert = value;
                });
              },
            ),
            _buildCupertinoSettingSwitchItem(
              title: 'Parking Lot Closures',
              value: parkingLotClosure,
              onChanged: (bool value) {
                setState(() {
                  parkingLotClosure = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCupertinoSettingSwitchItem({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return CupertinoFormSection(
      children: [
        CupertinoFormRow(
          prefix: Text(
            title,
            style: const TextStyle(
              fontSize: 18, // Adjust the font size if needed
              color: CupertinoColors.black,
            ),
          ),
          child: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
