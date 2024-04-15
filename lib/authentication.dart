import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:upark/campus.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:upark/client.dart';
import 'package:upark/home.dart';
import 'package:flutter/material.dart';

// TODO: Update Database and Web API to match User Model
class AppUser {
  String userId;
  String email;
  Permit permit;
  bool colorblind;

  AppUser({
    required this.userId,
    this.email = '',
    this.permit = Permit.Visitor,
    this.colorblind = false,
  });

  Future<AppUser> fromEmailAndPassword(String email, String password) async {
    // FirebaseAuth.instance.signInAnonymously();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    this.userId = FirebaseAuth.instance.currentUser!.uid;
    this.email = FirebaseAuth.instance.currentUser!.email!;
    var tempUser = await fetchUserFromId(this.userId);
    this.permit = tempUser.permit;
    this.colorblind = tempUser.colorblind;
    return this;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      userId: json['user_id'],
      permit: Permit.values[json['permit']],
      colorblind: json['colorblind'],
    );
  }
}

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [EmailAuthProvider()];
    /*
    var streamBuilderAuthWidget = StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // Error occurred
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                      'Something went wrong. Please close the app and try again.'),
                  ElevatedButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text('Sign Out'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            // User is not signed in
            return SignInScreen(
                providers: providers,
                showAuthActionSwitch: true,
                showPasswordVisibilityToggle: true,
                headerBuilder: (context, constraints, shrinkOffset) {
                  return Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Image.asset('lib/images/UPark_Logo.png'),
                      ));
                },
                subtitleBuilder: (context, action) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: action == AuthAction.signIn
                        ? const Text('Welcome to UPark, please sign in!')
                        : const Text('Welcome to UPark, please sign up!'),
                  );
                },
                footerBuilder: (context, action) {
                  return Text(
                      "UPark Capstone Project WIP${action == AuthAction.signIn ? '' : '\nYour email will not be share with anyone!'}",
                      textAlign: TextAlign.center);
                },
                actions: [
                  AuthStateChangeAction<SignedIn>((context, state) {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  }),
                ]);
          } else {
            // User is signed in
            return HomePage();
          }
        });
    */

    var routeAuthWidget = MaterialApp(
        initialRoute:
            FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
        routes: {
          '/login': (context) => SignInScreen(
                providers: providers,
                showAuthActionSwitch: true,
                showPasswordVisibilityToggle: true,
                headerBuilder: (context, constraints, shrinkOffset) {
                  return Padding(
                      padding: const EdgeInsets.all(20),
                      child: AspectRatio(
                        aspectRatio: 2,
                        child: Image.asset('lib/images/UPark_Logo.png'),
                      ));
                },
                subtitleBuilder: (context, action) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: action == AuthAction.signIn
                        ? const Text('Welcome to UPark, please sign in!')
                        : const Text('Welcome to UPark, please sign up!'),
                  );
                },
                footerBuilder: (context, action) {
                  return Text(
                      "UPark Capstone Project WIP${action == AuthAction.signIn ? '' : '\nYour email will not be share with anyone!'}",
                      textAlign: TextAlign.center);
                },
                actions: [
                  AuthStateChangeAction<SignedIn>((context, state) {
                    var user =
                        fetchUserFromId(FirebaseAuth.instance.currentUser!.uid);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(user)));
                  }),
                ],
              ),
          '/profile': (context) => const ProfileScreen(),
          '/home': (context) => HomePage(
                fetchUserFromId(FirebaseAuth.instance.currentUser!.uid),
              ),
        });

    return routeAuthWidget;
    // return streamBuilderAuthWidget;
  }
}
