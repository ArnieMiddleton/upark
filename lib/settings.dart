import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upark/authentication.dart';
import 'package:upark/campus.dart';
import 'settings_pages/notifications.dart';
import 'settings_pages/permits.dart';

class SettingsPage extends StatefulWidget {
  final Future<Campus> campus;
  const SettingsPage(this.campus, {super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  late Future<Campus> campus = widget.campus;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Settings',
          style: TextStyle(
            fontSize: 28, // Increased font size for the heading
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        border: Border(
            bottom: BorderSide(color: CupertinoColors.systemGroupedBackground)),
      ),
      backgroundColor: CupertinoColors.systemGroupedBackground,
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(
                height: 35), // Spacing at the top for the first section
            _buildCupertinoSettingItem(
              icon: CupertinoIcons.person_alt_circle,
              title: 'Account',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AccountPage(),
                  ),
                );
              },
            ),
            _buildCupertinoSettingItem(
              icon: CupertinoIcons.bell,
              title: 'Notifications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationSettingsScreen(),
                  ),
                );
              },
            ),
            _buildCupertinoSettingItem(
              icon: CupertinoIcons.doc_plaintext,
              title: 'Permits',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PermitsScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 35), // Spacing before the General section
            _buildGeneralSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralSection(BuildContext context) {
    return CupertinoFormSection(
      header: const Text(
        'General',
        style: TextStyle(
          fontSize: 22, // Adjusted font size for section header
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        CupertinoFormRow(
          prefix: const Text('ColorBlind Mode'),
          child: FutureBuilder<Campus>(
            future: campus,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var campusData = snapshot.data!;
                return CupertinoSwitch(
                    value: campusData.user.colorblind,
                    onChanged: (bool value) {
                      campusData.user.setColorblind(value);
                      setState(() {});
                    });
              } else {
                return const CupertinoActivityIndicator();
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildCupertinoSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CupertinoFormSection.insetGrouped(
      header: Container(), // Empty container for aesthetics
      children: [
        CupertinoFormRow(
          child: CupertinoButton(
            onPressed: onTap,
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(icon, size: 30),
                const SizedBox(width: 10), // Space added between icon and text
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20, // Adjusted font size for list items
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                const Icon(CupertinoIcons.forward,
                    color: CupertinoColors.systemGrey),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
