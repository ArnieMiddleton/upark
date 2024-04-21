import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:upark/firebase_options.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (FirebaseAuth.instance.currentUser != null) {
    log("user ${FirebaseAuth.instance.currentUser?.uid} is signed in.", name: 'main');
  } else {
    log('No user signed in', name: 'main');
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: UtahColorScheme.colorScheme,
        useMaterial3: true,
      ),
      home: const AuthenticationPage(),
    );
  }
}
