import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';

class DatabaseManager {
  final CollectionReference userList =
      FirebaseFirestore.instance.collection('User');

  Future getUserList() async {
    List itemList = [];
    try {
      await userList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemList.add(element.data);
        });
      });
      return itemList;
    } catch (e) {
      Utils().ToastMsg(e.toString());
      return null;
    }
  }

  // _fetch(String myName) async {
  //   final firebaseUser = await FirebaseAuth.instance.currentUser;
  //   if (firebaseUser != null) {
  //     await FirebaseFirestore.instance
  //         .collection('User')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then((ds) {
  //           myName = ds.data()
  //     })
  //         .onError((error, stackTrace) {});
  //   }
  // }
}
