import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDMethod {
  Future addData(blogData) async {
    return FirebaseFirestore.instance
        .collection("posts")
        .add(blogData)
        .catchError((e) {
      print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("posts").snapshots();
  }
}
