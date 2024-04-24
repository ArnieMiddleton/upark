import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:flutter/cupertino.dart';
import 'package:upark/campus.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:upark/components/color_scheme.dart';
import 'package:upark/home.dart';
import 'package:flutter/material.dart';
import 'package:upark/settings_pages/settings.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final providers = [
      EmailAuthProvider(),
    ];
    return MaterialApp(
        theme: ThemeData(
          colorScheme: UtahColorScheme.colorScheme,
          useMaterial3: true,
        ),
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
                  return Column(children: [
                    const Divider(),
                    TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signInAnonymously();
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        child: Text("Sign in Anonymously",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary))),
                    Text(
                        "UPark Capstone Project${action == AuthAction.signIn ? '' : '\nYour email will not be share with anyone!'}",
                        textAlign: TextAlign.center)
                  ]);
                },
                actions: [
                  AuthStateChangeAction<AuthState>((context, state) {
                    if (state is AccountDeletedAction) {
                      Navigator.pushReplacementNamed(context, '/login');
                    }
                  }),
                  AuthStateChangeAction<SignedIn>((context, state) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }),
                ],
              ),
          '/profile': (context) => const ProfileScreen(),
          '/settings': (context) => SettingsPage(Campus.getFromApi()),
          '/home': (context) => HomePage(Campus.getFromApi()),
        });
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthenticationPage()),
            (Route<dynamic> route) => false,
          );
        }),
        AuthStateChangeAction((context, user) {
          // TODO: Complete this implementation
        }),
        AccountDeletedAction((context, user) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthenticationPage()),
            (Route<dynamic> route) => false,
          );
        })
      ],
    );
  }
}
