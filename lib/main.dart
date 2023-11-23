import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Settings Screen',
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
          ListTile(
            leading: const Icon(
              Icons.exit_to_app,
              size: 30,
            ),
            iconColor: const Color.fromARGB(255, 255, 0, 0),
            title: const Text(
              'Logout',
              style: TextStyle(fontSize: 22, fontFamily: 'Quicksand'),
            ),
            onTap: () {
              // Handle logout
            },
          ),
        ],
      ),
    );
  }
}

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
