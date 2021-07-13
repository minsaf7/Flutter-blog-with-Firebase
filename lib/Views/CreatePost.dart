import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memoir/Service/crud.dart';
import 'package:memoir/Views/Home.dart';
import 'package:random_string/random_string.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key? key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  late String title, desc, auther;

  CRUDMethod crudMethod = new CRUDMethod();

  late PickedFile? selectedImage;
  late File imageFile;
  bool isSelected = false;
  bool isUploading = false;
  late String imageUrl;

  Future getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
      isSelected = true;
      imageFile = File(selectedImage!.path);
    });
  }

  uploadPost() async {
    if (isSelected) {
      setState(() {
        isUploading = true;
      });
      // Map<String, String> postData;

      // postData = {"name": auther, "title": title, "description": desc};
      // print(postData);

      //importing to firebase storage
      Reference reference = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = reference.putFile(File(selectedImage!.path));
      var imageURL = await task.whenComplete(() => reference.getDownloadURL());
      // var imageURL = await task.then(() => reference.getDownloadURL());
      //print(imageURL);
      imageUrl = await imageURL.ref.getDownloadURL();

      setState(() {
        isUploading = false;
      });
      print("IMAGE IS: " + imageUrl);

      Map<String, String> blogMap = {
        "imageUrl": imageUrl,
        "authur": auther,
        "description": desc,
        "title": title
      };
      crudMethod.addData(blogMap);
      // Navigator.pop(context);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (builder) => Home()));
    } else {
      print("Image not selected");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create"),
          actions: [
            IconButton(
                onPressed: () {
                  uploadPost();
                },
                icon: Icon(Icons.upload))
          ],
        ),
        body: ListView(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    isSelected
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: isUploading
                                ? Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : Image.file(File(selectedImage!.path)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300],
                            ),
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            child: IconButton(
                                onPressed: () {
                                  print("object");
                                  getImage();

                                  // crudMethod.addData(postData);
                                },
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.black,
                                )),
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
