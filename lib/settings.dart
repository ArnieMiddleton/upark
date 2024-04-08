import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:upark/login.dart';

import 'settings_pages/notifications.dart';
import 'settings_pages/permits.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // SettingsScreen({super.key});
  bool val = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand'),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(
              Icons.account_circle_outlined,
              size: 30,
            ),
            title: const Text(
              'Account',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
            onTap: () {
              // Navigate to AccountScreen or handle the tap as needed
              Navigator.push(
                context,
                MaterialPageRoute<ProfileScreen>(
                  builder: (context) => ProfileScreen(
                    actions: [
                      SignedOutAction((context) {
                        // Navigator.of(context).pop();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LogInPage()),
                          (Route<dynamic> route) => false,
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.notifications_none,
              size: 30,
            ),
            title: const Text(
              'Notifications',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationSettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.description,
              size: 30,
            ),
            title: const Text(
              'Permits',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PermitsScreen(),
                ),
              );
            },
          ),
          // SwitchListTile(
          //   leading: const Icon(
          //     Icons.remove_red_eye,
          //     size: 30,
          //   ),
          //   title: const Text(
          //     'ColorBlind',
          //     style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
          //   ),
          //   trailing: const Switch(
          //     value: true,
          //     activeColor: Colors.green,
          //     onChanged: (bool value) {},
          //   ),
          // )
          SwitchListTile(
            title: Text('ColorBlind Mode'),
            secondary: Icon(
              Icons.remove_red_eye,
              size: 30,
            ),
            value: val,
            onChanged: (bool value) {
              setState(() => val = value);
            },
          )
        ],
      ),
    );
  }
}
