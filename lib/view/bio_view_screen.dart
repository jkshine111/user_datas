import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/show_all_users.dart';
import '../screens/signin_screen.dart';
import '../utils/color_utils.dart';
import 'admin_screen.dart';

class BioViewScreen extends StatefulWidget {
  final ShowAllUsers show_users;

  const BioViewScreen(this.show_users, {Key? key}) : super(key: key);

  @override
  State<BioViewScreen> createState() => _BioViewScreen();
}

class _BioViewScreen extends State<BioViewScreen> {
  var _userNameController = TextEditingController();
  var _emailController = TextEditingController();

  bool _validateName = false;
  bool _validateEmail = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void signOut() {
    _googleSignIn.disconnect();
  }

  @override
  void initState() {
    _userNameController.text = widget.show_users.username;
    _emailController.text = widget.show_users.email;
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 30, color: Colors.white70);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'Bio Details',
            style: GoogleFonts.pacifico(textStyle: style),
          ),
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              print('Signed Out');

              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
              signOut();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                hexStringToColor("5E61F4"),
                hexStringToColor("9546C4"),
                hexStringToColor("9543C4"),
                hexStringToColor("5E61F4"),
                hexStringToColor("9546C4"),
                hexStringToColor("CB2B93"),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 90.0,
              ),
              TextField(
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  controller: _userNameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Colors.greenAccent,
                    ),
                    labelStyle:
                        TextStyle(color: Colors.white70.withOpacity(0.9)),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: 'Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                style: TextStyle(
                  color: Colors.black87,
                ),
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: Colors.greenAccent,
                  ),
                  labelStyle: TextStyle(color: Colors.white70.withOpacity(0.9)),
                  filled: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  fillColor: Colors.white.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.none),
                  ),
                  hintText: 'Email',
                  labelText: 'Email',
                  errorText: _validateEmail
                      ? 'Email address Value Can\'t Be Empty'
                      : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
                onPressed: () {
                  print('Bio Submit');
                  // Navigator.of()
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AdminScreen()));
                  // Navigator.pop(context);
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side: BorderSide(color: Colors.white70),
                  )),
                ),
                child: const Text(
                  '   Submit   ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
