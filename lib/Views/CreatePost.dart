import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late String title, desc, auther;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create"),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.upload))],
        ),
        body: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey[300],
                      ),
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      child: Icon(
                        Icons.image,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(hintText: "Name"),
                      onChanged: (val) {
                        setState(() {
                          auther = val;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(hintText: "Title"),
                      onChanged: (val) {
                        setState(() {
                          title = val;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    TextField(
                      maxLength: 258,
                      maxLines: 10,
                      decoration: InputDecoration(hintText: "Description"),
                      onChanged: (val) {
                        setState(() {
                          desc = val;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  inputTextField() {}
}
