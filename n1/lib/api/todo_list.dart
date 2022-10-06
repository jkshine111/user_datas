import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_signin/api/updateUserForm.dart';
// import 'package:firebase_signin/api/update_todo_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../screens/signin_screen.dart';
import '../utils/color_utils.dart';
import '../view/updateUserForm.dart';

class MyHomePage extends StatefulWidget {
  // const MyHomePage(
  //     {Key? key,
  //     required this.title,
  //     required this.description,
  //     required this.date})
  //     : super(key: key);

  // final String title;
  // final String description;
  // final String date;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

// updateList(String title, String description, String date) {}
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "";
  String description = "";
  // String date = "";

  // TextEditingController _title = TextEditingController();
  // TextEditingController _description = TextEditingController();
  TextEditingController _date = TextEditingController();

  // ------------------------------
  // Add Record
  // CollectionReference todoList =
  //     FirebaseFirestore.instance.collection('TodoList');
  //
  // Future<void> addRecord() {
  //   return todoList
  //       .add({
  //         'todoTitle': title,
  //         'todoDesc': description,
  //         'todoDate': _date.text
  //       })
  //       .then((value) => print('New Record Added'))
  //       .catchError((error) => print('Failed to Add Record: $error'));
  // }

  // ----------------------------------------
  createToDo() {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("TodoList").doc(title);
    // FirebaseFirestore.instance.collection("MyTodos").doc(title);

    Map<String, String> todoList = {
      "todoTitle": title,
      "todoDesc": description,
      "todoDate": _date.text,
    };

    documentReference
        .set(todoList)
        .whenComplete(() => print("Data stored successfully $todoList"));

    print('Title_is:');
    print(todoList["todoTitle"]);
    print(todoList["todoDesc"]);
    print(todoList["todoDate"]);
  }

  //-------------------------------------
  // final reference_id = FirebaseFirestore.instance.collection("TodoList").id;

  deleteTodo(item) {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("TodoList").doc(item);

    documentReference
        .delete()
        .whenComplete(() => print("deleted successfully"));

    print('deleted_values_is:${item}');
    // print(item);
  }

  // final CollectionReference _update_val =
  //     FirebaseFirestore.instance.collection('TodoList');

  @override
  Widget build(BuildContext context) {
    // var barColor2 = Color(0xff753a88);

    final style = TextStyle(fontSize: 25);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // My Todo List
        // title: Text(widget.title),
        title: Center(
          child: Text(
            'My Todo List',
            textAlign: TextAlign.center,
            style: GoogleFonts.pacifico(textStyle: style),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              print('Go to signin screen');
              print('Signed Out');

              FirebaseAuth.instance.signOut().then((value) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SignInScreen()));
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
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
          )),
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection("TodoList").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              } else if (snapshot.hasData || snapshot.data != null) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      QueryDocumentSnapshot<Object?>? documentSnapshot =
                          snapshot.data?.docs[index];
                      return Dismissible(
                          key: Key(index.toString()),
                          child: Card(
                            margin: EdgeInsets.all(5),
                            elevation: 5,
                            child: Container(
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Center(
                                      child: Text((documentSnapshot != null)
                                          ? (documentSnapshot["todoTitle"])
                                          : ""),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Text((documentSnapshot != null)
                                            ? ((documentSnapshot["todoDesc"] !=
                                                    null)
                                                ? documentSnapshot["todoDesc"]
                                                : "")
                                            : ""),
                                        Text((documentSnapshot != null)
                                            ? ((documentSnapshot["todoDate"] !=
                                                    null)
                                                ? documentSnapshot["todoDate"]
                                                : "")
                                            : ""),
                                      ],
                                    ),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          color: Colors.blue,
                                          onPressed: () {
                                            print(
                                                'Send_the_Title_is:${documentSnapshot!["todoTitle"]}');
                                            print(
                                                'Send_the_Description_is:${documentSnapshot["todoDesc"]}');
                                            print(
                                                'Send_the_Date_is:${documentSnapshot["todoDate"]}');
                                            // UpdateTodoPage
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             UpdateTodoPage(
                                            //               id: FirebaseFirestore
                                            //                   .instance
                                            //                   .collection(
                                            //                       "TodoList")
                                            //                   .id,
                                            //             )));
                                            // final reference_id = FirebaseFirestore.instance.collection("TodoList").id;
                                            // },
                                            // Navigator.of(context).push(
                                            // MaterialPageRoute(
                                            // builder: (context) =>
                                            // updateUserForm(
                                            //     // titleText: title,
                                            //     titleText:
                                            //         documentSnapshot[
                                            //             "todoTitle"],
                                            //     descriptionText:
                                            //         documentSnapshot[
                                            //             "todoDesc"],
                                            //     dateValue:
                                            //         documentSnapshot[
                                            //             "todoDate"])));
                                          },
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () {
                                            setState(() {
                                              deleteTodo(
                                                  (documentSnapshot != null)
                                                      ? (documentSnapshot[
                                                          "todoTitle"])
                                                      : "");
                                              print('delete datas:');
                                              print(documentSnapshot![
                                                  "todoTitle"]);
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    });
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.red,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add Floading Button');
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  title: Center(
                    child: const Text("Add Todo"),
                  ),
                  content: Container(
                    width: 500,
                    height: 200,
                    child: SingleChildScrollView(
                      // scroll option disable
                      // physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          TextField(
                            onChanged: (String value) {
                              title = value;
                              print('add_the_value:${value}');
                            },
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                          TextField(
                            onChanged: (String value) {
                              description = value;
                            },
                            decoration: InputDecoration(
                              labelText: 'Description',
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextField(
                              controller: _date,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.calendar_today_rounded),
                                // hintText: 'Enter Name',
                                labelText: 'Date',
                              ),
                              onTap: () async {
                                print('date_is:$_date');
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2025),
                                );
                                if (pickedDate != null) {
                                  setState(() {
                                    // _date.text = DateFormat('yyy-MM-dd')
                                    _date.text = DateFormat('dd-MM-yyy')
                                        .format(pickedDate);
                                    print('date_is1:');
                                    print(_date.text);

                                    // _date.text = DateF'yyy-MM-dd').format(pickedDate);
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          print('new record added');
                          setState(() {
                            //todos.add(title);
                            // addRecord();
                            createToDo();
                          });
                          _date.clear();
                          Navigator.of(context).pop();
                        },
                        child: const Text("Add"))
                  ],
                );
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
