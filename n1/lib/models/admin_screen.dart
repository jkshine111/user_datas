import 'package:flutter/material.dart';
import 'package:user_datas/models/show_all_users.dart';
import 'package:user_datas/view/addUserForm.dart';
import 'package:user_datas/view/project_view_screen.dart';
import 'package:user_datas/view/updateUserForm.dart';

// import '../api/updateUserForm.dart';
import '../services/userApi.dart';
import '../utils/color_utils.dart';
import '../view/bio_screen.dart';

class AdminScreen extends StatefulWidget {
  // final ShowAllUsers show_users;
  // final ShowAllUsers show_users;

  // const AdminScreen(this.show_users, {Key? key}) : super(key: key);
  // const AdminScreen(this.show_users, {Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _HomeState();
}

class _HomeState extends State<AdminScreen> {
  String? gender; //no radio button will be selected
  //String gender = "male"; //if you want to set default value

  // List<ShowAllUsers>? show_users;
  var isLoaded = false;

  // @override
  // void initState() {
  //   getRecord();
  // }
  //
  // getRecord() async {
  //   show_users = await UserApi().getAllUsers();
  //   if (show_users != null) {
  //     setState(() {
  //       isLoaded = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Choose below any one"),
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
            // Text(
            //   "Choose below any one",
            //   style: TextStyle(fontSize: 18, color: Colors.white70),
            // ),
            Divider(),
            RadioListTile(
              title: Text(
                "My Bio",
                style: TextStyle(color: Colors.white70),
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
                style: TextStyle(color: Colors.white70),
              ),
              value: "project",
              groupValue: gender,
              onChanged: (value) {
                setState(() {
                  gender = value.toString();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // MainAxisAlignment = MainAxisAlignment.spaceBetween,
                TextButton(
                  onPressed: () {
                    // print('Update Text Button');
                  },
                  child: OutlinedButton(
                    // onPressed: updateToDo,
                    onPressed: () {
                      // _titleController.text = titleText;
                      // _titleController.text = titleText;
                      //todos.add(title);

                      // updateToDo();
                      // Navigator.pop(context);

                      // _titleController.text = '';
                      // _titleController.clear();
                      // updateToDo();

                      print('gender: ' + gender!);
                      print('Gender Details: ' + gender!);

                      if (gender == 'bio') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage(
                                      titleText: 'admin@kssmart.co',
                                      dateValue: 'date value',
                                      descriptionText: '123456',
                                    )));
                        // MaterialPageRoute(builder: (context) => AdminScreen()));
                        print("this is ${gender}");
                      } else if (gender == 'project') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            // builder: (context) => updateUserForm(),
                            builder: (context) => addUserForm(),
                            // builder: (context) => ProjectScreen(
                            //   titleText: 'Hi',
                            //   descriptionText: '',
                            //   dateValue: '',
                            // ),
                          ),
                        );
                        // addUserForm
                        print("this is ${gender}");
                      } else {
                        print("${gender} is neither nor");
                      }

                      // Navigator.of(context).pop();
                      // updateToDo();
                      // print('Update Details');
                    },
                    // _titleController.clear();

                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0))),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ),
                ),
                // TextButton(
                //     onPressed: () {
                //       print('Clear Button');
                //     },
                //     child: OutlinedButton(
                //       onPressed: () {
                //         print('Clear Details');
                //       },
                //       style: ButtonStyle(
                //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(25.0))),
                //       ),
                //       child: const Text(
                //         "  Clear  ",
                //         style:
                //             TextStyle(fontSize: 18, color: Colors.deepPurple),
                //       ),
                //     ),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
