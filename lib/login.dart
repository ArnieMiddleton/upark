import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:upark/components/custom_button.dart';
import 'package:upark/components/signUp_button.dart';
import 'package:upark/components/text_field.dart';
import 'package:upark/home.dart';
import 'package:upark/signup.dart';
import 'package:flutter/material.dart';
import 'main.dart';

// Sign In Page
class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: clientId),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('lib/images/UPark_Logo.png'),
                ),
              );
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
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
          );
        }

        return HomePage();
      },
    );
  }

/*
  // text controllers are defined here:
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // action that will happen once the Sign In is clicked
  void signInClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  // action that will happen once the Sign Up is clicked
  void signUpClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  // action that will happen once the Google button is clicked
  void googleClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              Image.asset(
                'lib/images/UPark_Logo.png',
                height: 100,
              ),

              const SizedBox(height: 50),

              // Sign In Text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      'Sign In: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Email Textfield
              text_field(
                controller: emailController,
                hintText: 'Enter Your Email',
                obscureText: false,
              ),

              const SizedBox(height: 30),

              // Password Textfield
              text_field(
                controller: passwordController,
                hintText: 'Enter Your Password',
                obscureText: true,
              ),

              const SizedBox(height: 20),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      'Forgot Your Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // sign in button
              custom_button(
                onClick: () => signInClicked(context),
              ),

              const SizedBox(height: 20),

              // or continue with
              const Text("or use one of your social profiles: ",
                  style: TextStyle(color: Colors.black87)),

              const SizedBox(height: 30),

              // google and U buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => googleClicked(context),
                    child: Center(
                        child: Image.asset(
                      'lib/images/google_logo.png',
                      height: 50,
                    )),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'Gmail',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // not a member? sign up button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    signUp_button(
                      onClick: () => signUpClicked(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/



}
