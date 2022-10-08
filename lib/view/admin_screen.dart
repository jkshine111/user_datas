import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_datas/models/show_all_users.dart';
import 'package:user_datas/view/random_users.dart';
import '../services/userApi.dart';
import '../utils/color_utils.dart';
import 'bio_screen.dart';
import 'project_screen.dart';

class AdminScreen extends StatefulWidget {
  @override
  State<AdminScreen> createState() => _HomeState();
}

class _HomeState extends State<AdminScreen> {
  String? gender; //radio button will be selected
  List<ShowAllUsers>? show_users;
  var isLoaded = false;

  @override
  void initState() {
    getRecord();
  }

  getRecord() async {
    show_users = await UserApi().getAllUsers();
    if (show_users != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  String action_msg = "Pleace choose above any one!";

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
    final style = TextStyle(fontSize: 30, color: Colors.white70);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Choose below any one",
          style: GoogleFonts.pacifico(textStyle: style),
        ),
        // backgroundColor: Colors.deepOrangeAccent,
      ),
      body: Container(
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
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(
              height: 60,
            ),
            Divider(),
            RadioListTile(
              title: Text(
                "My Bio",
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
              value: "bio",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "My Project",
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
              value: "project",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            RadioListTile(
              title: Text(
                "Random Users",
                style: TextStyle(color: Colors.white70, fontSize: 18.0),
              ),
              value: "random_users",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.all(2),
                  child: Column(
                    children: [
                      FlatButton(
                        child: Text(
                          '   Submit   ',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.white70),
                        ),
                        // color: Colors.orange,
                        textColor: Colors.white,
                        onPressed: () {
                          if (gender == '' || gender == null) {
                            _showToast(context, action_msg);
                          } else if (gender == 'bio') {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BioScreen()));
                            print("this is ${gender}");
                          } else if (gender == 'project') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProjectScreen(),
                              ),
                            );
                          } else if (gender == 'random_users') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RandomUsers(),
                              ),
                            );
                          } else {
                            print('no datas');
                          }
                          ;
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
