import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../screens/signin_screen.dart';
import '../utils/color_utils.dart';
import 'admin_screen.dart';

class RandomUsers extends StatefulWidget {
  @override
  _RandomUsers createState() => _RandomUsers();
}

class _RandomUsers extends State<RandomUsers> {
  List data = [];
  bool isLoading = false;

  Future RandomUsersData() async {
    var client = http.Client();
    var uri = Uri.parse("https://randomuser.me/api/");
    var response = await client.get(uri);
    List ConvertDataToJson = jsonDecode(response.body)['results'];
    setState(() {
      data = ConvertDataToJson;
      // print('data_is:$data');
    });
  }

  @override
  void initState() {
    super.initState();
    this.RandomUsersData();
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
        fontSize: 18, color: Colors.white70, fontWeight: FontWeight.normal);
    final nameStyle = TextStyle(
        fontSize: 25, color: Colors.white70, fontWeight: FontWeight.bold);

    var upper_cash = data[0]['gender'];

    print(upper_cash[0].toString().toUpperCase() +
        upper_cash.toString().substring(1));

    print('latitude: ' + data[0]['location']['coordinates']['latitude']);
    print('longitude: ' + data[0]['location']['coordinates']['longitude']);

    print('data_is1:$data');
    print('gender_name: ' + data[0]['gender']);

    var hexColor = hexStringToColor("5E61F4");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: hexColor,
        // backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              print('Refresh API');
              RandomUsersData();
            },
          ),
          IconButton(
            icon: Icon(Icons.logout_outlined),
            onPressed: () {
              print('Signed Out');

              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInScreen()));
              // signOut();
            },
          ),
        ],
        title: Center(
          child: Text(
            upper_cash[0].toString().toUpperCase() +
                upper_cash.toString().substring(1),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : RefreshIndicator(
                  onRefresh: RandomUsersData,
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return Card(
                        child: Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,
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
                            children: <Widget>[
                              const SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                child: Image(
                                  image:
                                      NetworkImage(data[0]['picture']['large']),
                                  width: 100.0,
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.person,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  data[0]['name']['first'].toString() +
                                      " " +
                                      data[0]['name']['last'].toString(),
                                  style:
                                      GoogleFonts.roboto(textStyle: nameStyle),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.phone_iphone,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  data[0]['phone'],
                                  style: GoogleFonts.roboto(textStyle: style),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.mail,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  data[0]['email'].toString(),
                                  style: GoogleFonts.roboto(textStyle: style),
                                ),
                              ),
                              ListTile(
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.greenAccent,
                                ),
                                title: Text(
                                  (data[0]['location']['street']['name']
                                          .toString() +
                                      ', ' +
                                      'latitude' +
                                      ':' +
                                      data[0]['location']['coordinates']
                                              ['latitude']
                                          .toString() +
                                      ', ' +
                                      'longitude' +
                                      ':' +
                                      data[0]['location']['coordinates']
                                              ['longitude']
                                          .toString()),
                                  style: GoogleFonts.roboto(textStyle: style),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextButton(
                                onPressed: () {
                                  print('Random Submit');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminScreen()));
                                  // Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(color: Colors.white70),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  '    Submit    ',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 90.0,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
