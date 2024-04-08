import 'package:upark/components/signIn_button.dart';
import 'package:upark/components/text_field.dart';
import 'package:upark/login.dart';
import 'package:upark/settings.dart';
import 'package:flutter/material.dart';

// Sign Up Page
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  // text controllers are defined here:
  final newEmailController = TextEditingController();
  final newPasswordController = TextEditingController();

  // action that will happen once the Continue is clicked
  void continueClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
  }

  // action that will happen once the Continue is clicked
  void signInClicked(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LogInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Column(
      children: [
        const SizedBox(height: 50),

        // Sign Up Text:
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
            children: [
              Text(
                'Sign Up: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 30,
        ),

        // Email Textfield
        text_field(
          controller: newEmailController,
          hintText: 'Enter Your Email',
          obscureText: false,
        ),

        const SizedBox(height: 30),

        // Password Textfield
        text_field(
          controller: newPasswordController,
          hintText: 'Enter Your Password',
          obscureText: true,
        ),

        const SizedBox(height: 20),

        // Agreement for Privacy Policy and Terms of Services
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: checkBox(),
            ),
            const Text(
              "I agree to the ",
              style: TextStyle(color: Colors.black87, fontSize: 13),
              textAlign: TextAlign.start,
            ),
            Text("Terms of Services ",
                style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
            const Text("and ",
                style: TextStyle(color: Colors.black87, fontSize: 13)),
            Text("Privacy Policy ",
                style: TextStyle(
                    color: Colors.red[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ],
        ),

        const SizedBox(height: 25),

        // Continue Button
        GestureDetector(
            onTap: () => continueClicked(context),
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(color: Colors.red[700]),
              child: const Center(
                child: Text(
                  'Continue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )),

        const SizedBox(height: 30),

        // Have an Account? Sign in
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Have an Account?',
              style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 100),
            const SizedBox(width: 20),
            signIn_button(onClick: () => signInClicked(context)),
          ],
        ),
      ],
    ))));
  }
}

// Checkbox for Terms of Services and Privacy Policy
class checkBox extends StatefulWidget {
  const checkBox({super.key});

  @override
  State<checkBox> createState() => _checkBoxState();
}

class _checkBoxState extends State<checkBox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Checkbox(
        value: isChecked,
        activeColor: Colors.red[700],
        onChanged: (newBool) {
          setState(() {
            isChecked = newBool;
          });
        },
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
