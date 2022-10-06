import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

import '../models/show_all_users.dart';
import '../services/userApi.dart';
// import 'package:rest_api_flask/services/userApi.dart';

List<ShowAllUsers> showAllUsersFromJson(String str) => List<ShowAllUsers>.from(
    json.decode(str).map((x) => ShowAllUsers.fromJson(x)));

String showAllUsersToJson(List<ShowAllUsers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShowAllUsers {
  ShowAllUsers({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.website,
    required this.company,
  });

  int id;
  String name;
  String username;
  String email;
  Address address;
  String phone;
  String website;
  Company company;

  factory ShowAllUsers.fromJson(Map<String, dynamic> json) => ShowAllUsers(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        address: Address.fromJson(json["address"]),
        phone: json["phone"],
        website: json["website"],
        company: Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address.toJson(),
        "phone": phone,
        "website": website,
        "company": company.toJson(),
      };
}

class addUserForm extends StatefulWidget {
  const addUserForm({Key? key}) : super(key: key);

  @override
  State<addUserForm> createState() => _addUserFormState();
}

class _addUserFormState extends State<addUserForm> {
  List<ShowAllUsers> show_users = [];
  // var mapObj1 = new Map();
  // mapObj1['phone'];

  @override
  Widget build(BuildContext context) {
    // var val = mapObj1['phone'] = 'val';
    // var val = mapObj1['phone'];

    // print('value1' + show_users[index].name);
    // print('value1' + mapObj1['phone']);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Todos'),
//       ),
//       //passing in the ListView.builder
//       body: ListView.builder(
//         itemCount: show_users?.length,
//         itemBuilder: (context, index) {
//           print('show_users1:${show_users![index].name}');
//
//           return ListTile(
//             title: Text(show_users![index].name),
//           );
//         },
//       ),
//     );
//   }
// }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: show_users.length,
                  itemBuilder: (BuildContext context, int index) {
                    print("Number_is:" + "${show_users[index].phone}");

                    return TextField(
                        // controller: _contactController,
                        decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Enter Contact Number',
                      labelText: 'Contact No',
                      // errorText: _validateName
                      //     ? 'Contact Value Value Can\'t Be Empty'
                      //     : null,
                    ));
                  },
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  // controller: _contactController,
                  decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Enter Contact Number',
                labelText: 'Contact No',
                // errorText: _validateName
                //     ? 'Contact Value Value Can\'t Be Empty'
                //     : null,
              )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          // _userNameController.text.isEmpty
                          //     ? _validateName = true
                          //     : _validateName = false;
                          //
                          // _contactController.text.isEmpty
                          //     ? _validateContact = true
                          //     : _validateContact = false;
                        });
                        // if (_validateName == false &&
                        //     _validateContact == false) {
                        //   var result = await UserApi().addUser(
                        //       _userNameController.text,
                        //       _contactController.text);
                        //   Navigator.pop(context, result);
                        // }
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blue,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Save Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      onPressed: () {
                        // _userNameController.text = "";
                        // _contactController.text = "";
                      },
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      child: const Text('Clear Details')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
