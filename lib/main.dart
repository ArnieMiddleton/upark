import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upark/firebase_options.dart';
import 'package:upark/login.dart';
import 'package:upark/components/color_scheme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

const clientId = 'YOUR_CLIENT_ID';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  MaterialApp(
//       title: 'Settings Screen',
//       home: LogInPage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: UtahColorScheme.colorScheme,
        useMaterial3: true,
      ),
      home: LogInPage(),
    );
  }
}
