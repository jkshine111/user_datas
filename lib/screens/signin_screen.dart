import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:user_datas/screens/signup_screen.dart';
import '../models/show_all_users.dart';
import '../reusable_widget/reusable_widget.dart';
import '../utils/color_utils.dart';
import '../view/admin_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emilTextController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;

  List<ShowAllUsers>? show_users;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  String action_msg = "Pleace enter email & password";

  void _showToast(BuildContext context, String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 50, color: Colors.white70);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("CB2B93"),
          hexStringToColor("9546C4"),
          hexStringToColor("5E61F4")
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 55,
                ),
                Text(
                  'User Bio',
                  style: GoogleFonts.pacifico(textStyle: style),
                ),

                // Icon(
                //   Icons.web,
                //   color: Colors.black26,
                //   size: 100,
                // ),
                SizedBox(
                  height: 30,
                ),
                reusableTextField(
                    "Email", Icons.email_outlined, false, _emilTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField("Password", Icons.lock_outline, true,
                    _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, true, () {
                  print('Open Todo Page');
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emilTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    // homescreen
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                  }).onError((error, stackTrace) {
                    print("Error: ${error.toString()}");
                  });
                }),
                SizedBox(
                  height: 30,
                ),
                SignInButton(
                  // Buttons.Google,
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    print('Google Button');
                    Navigator.push(
                        context,
                        // google sign in
                        MaterialPageRoute(builder: (context) => _HomeState()));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account?",
          style: TextStyle(color: Colors.white70, fontSize: 17),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
        )
      ],
    );
  }
}

class _HomeState extends StatefulWidget {
  @override
  State<_HomeState> createState() => _HomeStateState();
}

class _HomeStateState extends State<_HomeState> {
  @override
  _HomeState createState() => _HomeState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 25);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Google Signin',
              style: GoogleFonts.pacifico(textStyle: style),
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: _buildWidget(),
      ),
    );
  }

  Widget _buildWidget() {
    GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              hexStringToColor("5E61F4"),
              hexStringToColor("9546C4"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
              hexStringToColor("9546C4"),
              // hexStringToColor("CB2B93"),
              // hexStringToColor("9546C4"),
              // hexStringToColor("5E61F4")
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              ListTile(
                leading: GoogleUserCircleAvatar(identity: user),
                title: Text(
                  user.displayName ?? '',
                  style: TextStyle(color: Colors.white70),
                ),
                subtitle: Text(
                  user.email,
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Signed in successfully',
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        // Todo Page
                        MaterialPageRoute(builder: (context) => AdminScreen()));
                    // MaterialPageRoute(builder: (context) => MyHomePage()));
                    // MaterialPageRoute(
                    //     builder: (context) => CurrentLocationScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(
                    ' Signin ',
                    style: TextStyle(fontSize: 18, color: Colors.white70),
                  )),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              hexStringToColor("5E61F4"),
              hexStringToColor("9546C4"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
              hexStringToColor("9546C4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                'You are not signed in',
                style: TextStyle(fontSize: 20, color: Colors.white70),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: signIn,
                  style: ElevatedButton.styleFrom(
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Text(' Signin ')),
            ],
          ),
        ),
      );
    }
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (e) {
      print('Error signing in $e');
    }
  }
}
