import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/show_all_users.dart';
import '../screens/signin_screen.dart';
import '../services/userApi.dart';
import '../utils/color_utils.dart';
import 'admin_screen.dart';

class ProjectScreenView extends StatefulWidget {
  final ShowAllUsers show_users;
  // String userName;

  // updateUserForm(this.userName);

  const ProjectScreenView(this.show_users, {Key? key}) : super(key: key);

  @override
  State<ProjectScreenView> createState() => _ProjectScreenView();
}

class _ProjectScreenView extends State<ProjectScreenView> {
  var _userNameController = TextEditingController();
  var _contactController = TextEditingController();
  var _website = TextEditingController();
  var _street = TextEditingController();
  var _company_details = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateWebsite = false;
  bool _validateStreet = false;
  bool _validateCompany = false;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  void signOut() {
    _googleSignIn.disconnect();
  }

  @override
  void initState() {
    _userNameController.text = widget.show_users.name;
    _contactController.text = widget.show_users.phone;
    _website.text = widget.show_users.website;
    _street.text = widget.show_users.address.city;
    _company_details.text = widget.show_users.company.name +
        ', ' +
        widget.show_users.company.catchPhrase;
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
            'Project Details',
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
              const SizedBox(
                height: 20.0,
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
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
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
                  controller: _company_details,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.business_center_outlined,
                      color: Colors.greenAccent,
                    ),
                    labelStyle:
                        TextStyle(color: Colors.white70.withOpacity(0.9)),
                    filled: true,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: 'Company Details',
                    labelText: 'Company Details(name, catchPhrase',
                    errorText: _validateCompany
                        ? 'Company detail Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  controller: _website,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.web,
                      color: Colors.greenAccent,
                    ),
                    labelStyle:
                        TextStyle(color: Colors.white70.withOpacity(0.9)),
                    filled: true,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: 'Website',
                    labelText: 'Website',
                    errorText: _validateWebsite
                        ? 'Website Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                  controller: _street,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.streetview_outlined,
                      color: Colors.greenAccent,
                    ),
                    labelStyle:
                        TextStyle(color: Colors.white70.withOpacity(0.9)),
                    filled: true,
                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide:
                          const BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    hintText: 'Street',
                    labelText: 'Street',
                    errorText: _validateStreet
                        ? 'Website Value Can\'t Be Empty'
                        : null,
                  )),
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
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.white70),
                    ),
                  ),
                  // side: BorderSide(color: Colors.white70),
                ),
                child: const Text(
                  '    Submit    ',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
