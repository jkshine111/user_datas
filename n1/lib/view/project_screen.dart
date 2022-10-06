import 'package:flutter/material.dart';
import 'package:user_datas/view/updateUserForm.dart';
// import 'package:rest_api_flask/models/users.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/show_all_users.dart';
import '../utils/color_utils.dart';

class ProjectScreen extends StatefulWidget {
  // late String titleText, descriptionText, dateValue;
  // List<ShowAllUsers>? show_users = [];

  void val1() {
    // print('show_users_len:' + show_users);
  }

  ProjectScreen(
      {Key? key,
      required this.titleText,
      required this.descriptionText,
      required this.dateValue})
      : super(key: key);

  final String titleText;
  final String descriptionText;
  final String dateValue;

  @override
  State<ProjectScreen> createState() => _ProjectScreen(
      titleText: titleText,
      descriptionText: descriptionText,
      dateValue: dateValue);
}

class _ProjectScreen extends State<ProjectScreen> {
  // var titleText = 'Task';
  List<ShowAllUsers>? show_users;

  // String titleText, descriptionText, dateValue;/

  _ProjectScreen(
      {Key? key,
      required this.titleText,
      required this.descriptionText,
      required this.dateValue});
  // : super(key: key);

  late final String titleText;
  final String descriptionText;
  final String dateValue;

  TextEditingController _titleController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();
  TextEditingController _dateController = new TextEditingController();

  final bool _validateTitle = false;
  final bool _validateDescription = false;
  final bool _validateDate = false;

  @override
  Widget build(BuildContext context) {
    print('Received_Title_is:$titleText');
    print('Received_Description_is:$descriptionText');
    print('Received_Date_is:$dateValue');
    final style = TextStyle(fontSize: 25);

    _titleController.text = titleText;
    _descriptionController.text = descriptionText;
    _dateController.text = dateValue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
      ),
      //passing in the ListView.builder
      body: ListView.builder(
        itemCount: show_users?.length,
        itemBuilder: (context, index) {
          print('show_users1:' + show_users![index].name);

          return ListTile(
            title: Text(show_users![index].phone),
          );
        },
      ),
    );
  }
}

//#-------------------------
// return Scaffold(
//   extendBodyBehindAppBar: true,
//   appBar: AppBar(
//     backgroundColor: Colors.transparent,
//     elevation: 0,
//     // backgroundColor: barColor2,
//     title: Column(
//       children: [
//         Text(
//           'My Project',
//           // style: GoogleFonts.tangerine(textStyle: style),
//           style: GoogleFonts.pacifico(textStyle: style),
//         ),
//       ],
//     ),
//   ),
//   body: SingleChildScrollView(
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//         colors: [
//           hexStringToColor("5E61F4"),
//           hexStringToColor("9546C4"),
//           hexStringToColor("9546C4"),
//           hexStringToColor("5E61F4"),
//           hexStringToColor("9546C4"),
//         ],
//         begin: Alignment.topCenter,
//         end: Alignment.bottomCenter,
//       )),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 100.0,
//           ),
//           TextField(
//               // controller: _titleController,
//               controller: _titleController,
//               style: TextStyle(color: Colors.white.withOpacity(0.9)),
//               decoration: InputDecoration(
//                 // hintText: titleText,
//                 // label: Text(titleText.toString()),
//                 // labelText: titleText,
//                 // hintText: titleText,
//                 // hintText: titleText,
//                 prefixIcon: const Icon(
//                   Icons.person_outline,
//                   color: Colors.white70,
//                 ),
//
//                 // labelText: _titleController.toString(),
//                 // labelText: titleText,
//                 // labelText: 'Title',
//                 labelStyle:
//                     TextStyle(color: Colors.white70.withOpacity(0.9)),
//                 filled: true,
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//                 fillColor: Colors.white.withOpacity(0.3),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: const BorderSide(
//                         width: 0, style: BorderStyle.none)),
//                 errorText:
//                     _validateTitle ? 'Title Value Can\'t Be Empty' : null,
//               )),
//           // reusableTextField(
//           //     "Title", Icons.title_outlined, false, _titleController),
//           const SizedBox(
//             height: 20.0,
//           ),
//           TextField(
//               // controller: _descriptionController,
//               // onTap: () {
//               //   print('titleText_is:${titleText}');
//               // },
//               controller: _descriptionController,
//               style: TextStyle(color: Colors.white.withOpacity(0.9)),
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(
//                   Icons.password_outlined,
//                   color: Colors.white70,
//                 ),
//                 // labelText: descriptionText,
//                 labelStyle:
//                     TextStyle(color: Colors.white70.withOpacity(0.9)),
//                 filled: true,
//                 floatingLabelBehavior: FloatingLabelBehavior.never,
//                 fillColor: Colors.white.withOpacity(0.3),
//                 border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(30.0),
//                     borderSide: const BorderSide(
//                         width: 0, style: BorderStyle.none)),
//                 errorText: _validateDescription
//                     ? 'Description Value Can\'t Be Empty'
//                     : null,
//               )),
//           // reusableTextField("Description", Icons.description_outlined,
//           //     false, _descriptionController),
//           const SizedBox(
//             height: 20.0,
//           ),
//           //
//           // reusableTextField(
//           //     "Date", Icons.date_range_outlined, false, _dateController),
//           const SizedBox(
//             height: 20.0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // MainAxisAlignment = MainAxisAlignment.spaceBetween,
//               TextButton(
//                   onPressed: () {
//                     print('Update Text Button');
//                   },
//                   child: OutlinedButton(
//                     onPressed: () {
//                       // _titleController.text = titleText;
//                       // _titleController.text = titleText;
//                       //todos.add(title);
//
//                       Navigator.pop(context);
//                       // _titleController.text = '';
//                       // _titleController.clear();
//                       print('Update Details');
//                     },
//                     // _titleController.clear();
//
//                     style: ButtonStyle(
//                       shape: MaterialStateProperty.all(
//                           RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25.0))),
//                     ),
//                     child: const Text(
//                       "Submit",
//                       style: TextStyle(fontSize: 18, color: Colors.white70),
//                     ),
//                   )),
//             ],
//           )
//         ],
//       ),
//     ),
//   ),
// );
//   }
// }
