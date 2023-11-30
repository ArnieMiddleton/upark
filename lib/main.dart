import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:upark/components/signIn_button.dart';
import 'package:upark/components/signUp_button.dart';
import 'package:upark/components/text_field.dart';
import 'package:upark/components/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Settings Screen',
      home: LogInPage(),
    );
  }
}

// Sign In Page
class LogInPage extends StatelessWidget {
  LogInPage({super.key});

  // text controllers are defined here:
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // action that will happen once the Sign In is clicked
  void signInClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  // action that will happen once the Sign Up is clicked
  void signUpClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  // action that will happen once the Google button is clicked
  void googleClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    resizeToAvoidBottomInset: false,
    body: SafeArea(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 50),

        // logo
        Image.asset('lib/images/UPark_Logo.png', height: 100,),
    
        const SizedBox(height: 50),

        // Sign In Text
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:25.0),
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
            obscureText: false,),
        
          const SizedBox(height: 30),

          // Password Textfield
          text_field(
            controller: passwordController,
            hintText: 'Enter Your Password', 
            obscureText: true,),
        

          const SizedBox(height: 20),

          // forgot password?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
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
          custom_button(onClick: ()=> signInClicked(context),),

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
                child: Image.asset('lib/images/google_logo.png', height: 50,)
               ),
              ),

              const SizedBox(width: 20),
              const Text('Gmail', style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            ],
          ),
        
          const SizedBox(height: 40),
        
          // not a member? sign up button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                signUp_button(onClick: () => signUpClicked(context),),
              ],
            ),
          ),
          ],
        ),
      ),
    ),
    );
  }
}

// Sign Up Page
class SignUpPage extends StatelessWidget{
  SignUpPage({super.key});

  // text controllers are defined here:
  final newEmailController = TextEditingController();
  final newPasswordController = TextEditingController();

  // action that will happen once the Continue is clicked
  void continueClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
  }

  // action that will happen once the Continue is clicked
  void signInClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LogInPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Center(
        child: Column(children: [
          const SizedBox(height: 50),

        // Sign Up Text:
        const Padding(
          padding: EdgeInsets.symmetric(horizontal:25.0),
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

        const SizedBox(height: 30,),

           // Email Textfield
          text_field(
            controller: newEmailController,
            hintText: 'Enter Your Email', 
            obscureText: false,),
        
          const SizedBox(height: 30),

          // Password Textfield
          text_field(
            controller: newPasswordController,
            hintText: 'Enter Your Password', 
            obscureText: true,),
        

          const SizedBox(height: 20),

          // Agreement for Privacy Policy and Terms of Services
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal:25.0),
                child: checkBox(),
              ),

              const Text("I agree to the ",
                        style: TextStyle(color: Colors.black87, fontSize: 13),
                        textAlign: TextAlign.start,),

              Text("Terms of Services ",
                        style: TextStyle(color: Colors.red[700], fontSize: 12,fontWeight: FontWeight.bold)),

              const Text("and ",
                        style: TextStyle(color: Colors.black87, fontSize: 13)),

              Text("Privacy Policy ",
                        style: TextStyle(color: Colors.red[700], fontSize: 12, fontWeight: FontWeight.bold)),
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
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
           ),
           ),
    )
    ),


    const SizedBox(height: 30),

    // Have an Account? Sign in
    Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Have an Account?', style:  TextStyle(color: Colors.grey[600], fontSize: 15, fontWeight: FontWeight.bold),),
          const SizedBox(width: 100),

          const SizedBox(width: 20),
          signIn_button(onClick: () => signInClicked(context)),
        ],
      ),

      


        ],)
      ))
    );

  }
}

// Checkbox for Terms of Services and Privacy Policy
class checkBox extends StatefulWidget{
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
