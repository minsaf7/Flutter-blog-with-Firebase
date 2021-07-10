import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoir/Views/CreatePost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Travel",
              style: GoogleFonts.ubuntuMono(fontSize: 20),
            ),
            Text(
              "Blog",
              style: GoogleFonts.ubuntuMono(fontSize: 20, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (builder) => CreatePost()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
