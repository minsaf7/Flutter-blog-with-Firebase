import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memoir/Service/crud.dart';
import 'package:memoir/Views/CreatePost.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Stream stream = Stream.empty();
  bool isHomeLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("home called");

    CRUDMethod().getData().then((results) {
      setState(() {
        isHomeLoaded = true;
        stream = results;
      });
    });
  }

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
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          isHomeLoaded
              ? blogList()
              : Container(
                  child: CircularProgressIndicator(),
                )
        ],
      ),
      // body: Container(),
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

  blogList() {
    return Container(
      child: stream != (null)
          ? Column(
              children: [
                StreamBuilder(
                    stream: stream,
                    builder: (builder, AsyncSnapshot snapshot) {
                      return ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (itemBuilder, index) {
                            return ImageTile(
                                image: snapshot.data.docs[index]["imageUrl"],
                                auther: snapshot.data.docs[index]["authur"],
                                description: snapshot.data.docs[index]
                                    ["description"],
                                title: snapshot.data.docs[index]["title"]);
                          });
                    })
              ],
            )
          : CircularProgressIndicator(),
    );
  }
}

class ImageTile extends StatelessWidget {
  final String image, auther, description, title;
  const ImageTile(
      {Key? key,
      required this.image,
      required this.auther,
      required this.description,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      height: 150,
      child: Stack(
        children: [
          // CachedNetworkImage(
          //   imageUrl: image,
          //   placeholder: (context, url) => CircularProgressIndicator(),
          //   errorWidget: (context, url, error) => Icon(Icons.error),
          // ),
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              )),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black45.withOpacity(0.3),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.ubuntu(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  auther,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
