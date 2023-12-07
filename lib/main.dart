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
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  HomePage()));
  }

  // action that will happen once the Sign Up is clicked
  void signUpClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUpPage()));
  }

  // action that will happen once the Google button is clicked
  void googleClicked(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
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

// Homepage
class HomePage extends StatelessWidget{
  HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    double _xPosition = 0.0;
    double _yPosition = 0.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[700],
        leading: Row(
          children: [
            IconButton(
              icon: Icon(Icons.settings),
              color: Colors.white, onPressed: () {Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen())); },
            ),
          ],
        ),
        title:  InkWell(
          onTap: () {
            showSearch(
              context: context, 
              delegate: CustomSearchDelegate());
          },
          child: Container(
              height: 35,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 255, 255, 255), 
                  width:1.4,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    children: [
                       Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal:10.0),
                            child: Icon(Icons.search, 
                            color:Colors.white,
                            ),
                          ),
                          Text(
                            'Search Buildings',
                             style: TextStyle(color:Color.fromARGB(255, 255, 255, 255)),
                             ),
                        ],
                        ),
                    ],
                  )
            ),
        ),
        ),
        body: HomePageImage(),
        // Stack(
        //   children: [
        //     Image.asset('lib/images/Parking-Lot-Occupancy.png',
        //     fit: BoxFit.cover,
        //     width:150,
        //     height:150,),
        //   ]
        // ),
      );
  }
}

class HomePageImage extends StatefulWidget{
  @override
  _HomePageImageState createState() => _HomePageImageState();

}

class _HomePageImageState extends State<HomePageImage> {
  Offset _position = const Offset(0.0,0.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const moqup1Screen()));
      },
      child: Stack(
        children: <Widget>[Positioned(
          left: _position.dx,
          top: _position.dy,
          child: Container(
            alignment: Alignment.center,
            
            child: Draggable(
              feedback: Image.asset('lib/images/Parking-Lot-Occupancy.png', fit:BoxFit.cover),
              childWhenDragging: Container(),
              onDraggableCanceled: (_, __) {
                
              },
              onDragEnd: (details) {
                setState(() {
                  _position = details.offset;
                });
              },
              child: Image.asset('lib/images/Parking-Lot-Occupancy.png',fit:BoxFit.cover),),
          )
        ),],
      ),
    );
  }
}


class CustomSearchDelegate extends SearchDelegate {
  String lastQuery = '';
  List<String> searchTerms = [
    'A. Ray Olpin Union',
    'Alfred C. Emery Building',
    'Alice Sheets Marriott Center for Dance',
    'Aline Wilmot Skaggs Biology Building',
    'Annette Poulson Cumming College of Nursing Building',
    'Architecture Building',
    'Art Building',
    'Beverley Taylor Sorenson Arts and Education Complex',
    'Business Classroom Building',
    'C. Roland Christensen Center',
    'Carolyn and Kem Gardner Commons',
    'Carolyn Tanner Irish Humanities Building',
    'Cauldron Legacy Plaza Visitors Ctr',
    'Chase N. Peterson Heritage Center',
    'Cleone Peterson Eccles Alumni House',
    'College of Social Work',
    'David P. Gardner Hall',
    'Dumke Gymnastics Center',
    'Film and Media Arts Building',
    'Fine Arts West',
    'Fort Douglas Bandstand',
    'Fort Douglas Chapel',
    'Fort Douglas Commander’s House',
    'Fort Douglas Officers Club',
    'Fort Douglas Theatre',
    'Frederick Albert Sutton Building',
    'George and Dolores Eccles Institute of Human Genetics',
    'George S Eccles Student Life Center',
    'George S. Eccles Tennis Center Indoor',
    'George S. Eccles Tennis Center Outdoor',
    'Henry Eyring Chemistry Building',
    'HPER East',
    'HPER North',
    'HPER West',
    'Huntsman Cancer Institute',
    'Huntsman Cancer Institute – Primary Children’s and Families’ Cancer Research Center',
    'Intermountain Network Scientific CC',
    'J. Willard Marriott Library',
    'James C. Fletcher Building',
    'James LeVoy Sorenson Molecular Biotechnology Building – A USTAR Innovation Center',
    'James Talmage Building',
    'John & Marcia Price Theatre Arts Building',
    'John A. Moran Eye Center',
    'John A. Widtsoe Building',
    'John and Marva Warnock Engineering Building',
    'John and Marva Warnock Engineering Building (L)',
    'John R. Park Building',
    'Jon M. and Karen Huntsman Basketball Facility',
    'Jon M. Huntsman Center',
    'Joseph F. Merrill Engineering Building',
    'Joseph T. Kingsbury Hall',
    'L.S. Skaggs Jr. Research Building',
    'Language & Communication Building',
    'Lassonde Studios',
    'LeRoy E. Cowles Building',
    'Life Science Building',
    'Marcia & John Price Museum Building',
    'Natural History Museum of Utah',
    'Open Space',
    'Performing Arts Building',
    'Pierre Lassonde Entrepreneur Center',
    'Red Butte Garden Amphitheatre',
    'Red Butte Garden Rose House',
    'Rice-Eccles Stadium',
    'Richard K. Hemingway Orangerie',
    'Rio Tinto Kennecott Mechanical Engineering Building',
    'Robert H. and Katharine B. Garff Executive Education Building',
    'Roy W. & Elizabeth E. Simmons Pioneer Memorial Theatre',
    'S.J.Quinney College of Law',
    'School of Medicine',
    'Social & Behavioral Sciences',
    'Social Beh. Science Lecture Hall',
    'Spence and Cleone Eccles Football Center',
    'Spence Eccles Field House',
    'Spencer F. and Cleone P. Eccles Health Sciences Education Building',
    'Spencer Fox Eccles Business Building',
    'Spencer S. Eccles Health Sciences Library',
    'Sterling Sill Center',
    'Student Services Building',
    'Thatcher Building for Biological and Biophysical Chemistry',
    'The Gary L. and Ann T. Crocker Science Center at the George Thomas Building',
    'Thomas S. Monson Center',
    'University Guest House',
    'William C. Browning Building',
    'William Stewart Building',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context,null);
          } else {
          query = '';
        }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
      );
  }

  @override
  Widget buildResults(BuildContext context) 
  {
    Future.delayed(Duration.zero, () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const moqup1Screen(),
        ),
      );
    });

    // Placeholder for the search result view
    return const Center(
      child: Text('Searching...'),
    );
  }
  
  
  
  // => const Center(
  //   child: Text(
  //     "WELCOME TO HOMEPAGE",)
  // );
  // {
  //   List<String> mathcQuery = [];
  //   for (var building in searchTerms) {
  //     if (building.toLowerCase().contains(query.toLowerCase())) {
  //       mathcQuery.add(building);
  //     }
  //   }
  //   return ListView.builder(
  //     itemCount: mathcQuery.length,
  //     itemBuilder: (context, index) {
  //       var result = mathcQuery[index];
  //       return ListTile(
  //         title: Text(result),
  //         onTap: () {
  //           query = result;
  //           close(context,query);
  //           showResults((context));
  //         },
  //       );
  //     },
  //   );
  // }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> mathcQuery = [];
    for (var building in searchTerms) {
      if (building.toLowerCase().contains(query.toLowerCase())) {
        mathcQuery.add(building);
      }
    }
    return ListView.builder(
      itemCount: mathcQuery.length,
      itemBuilder: (context, index) {
        var result = mathcQuery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            query = result;
            showResults((context));
          },
        );
      },
    );
  }
}

class moqup1Screen extends StatelessWidget {
   const moqup1Screen({super.key});

   @override
   Widget build(BuildContext context){
    return Scaffold(
      body:  GestureDetector(
        onTap:() {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsScreen()));  
          // CHANGE const SettingsScreen to next moqup image screen !!!
        },
        child: Container(
          alignment: Alignment.center ,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/moqup_1.jpg'), 
              fit: BoxFit.cover,
              ),
          ),
          ),
      )
      
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
