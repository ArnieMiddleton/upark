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
    print('UserID: ${FirebaseAuth.instance.currentUser?.uid}\n'
        'User Email: ${FirebaseAuth.instance.currentUser?.email}\n'
        'User Name: ${FirebaseAuth.instance.currentUser?.displayName}');
  } else {
    print('No user signed in');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: UtahColorScheme.colorScheme,
        useMaterial3: true,
      ),
      // home: const LogInPage(),
      home: const AuthenticationPage(),
    );
  }
}
