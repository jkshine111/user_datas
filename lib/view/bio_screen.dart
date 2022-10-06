import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/show_all_users.dart';
import '../services/userApi.dart';
import '../utils/color_utils.dart';
import 'bio_view_screen.dart';

class BioScreen extends StatefulWidget {
  const BioScreen({Key? key}) : super(key: key);

  @override
  State<BioScreen> createState() => _BioScreen();
}

class _BioScreen extends State<BioScreen> {
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

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(fontSize: 30, color: Colors.white70);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Bio Details',
          style: GoogleFonts.pacifico(textStyle: style),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(2.0),
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
          child: Visibility(
            visible: isLoaded,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
                itemCount: show_users?.length,
                // itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    // elevation: 50,
                    child: ListTile(
                      title: Text(
                        show_users![index].username,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          // height: double.infinity,
                        ),
                      ),
                      subtitle: Text(
                        show_users![index].email,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BioViewScreen(show_users![index])),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
