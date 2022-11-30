import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_fb/Database_manager/Database_Manager.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';
import 'package:flutter_crud_fb/Widgets/Round_btn.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/screens/addContacts.dart';

import 'Vertical_Details.dart';

class Contacts extends StatefulWidget {
  const Contacts({Key? key}) : super(key: key);

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  final auth = FirebaseAuth.instance;
  //for fetch
  final ref = FirebaseDatabase.instance.ref('MyQuestions');
  final searchFilter = TextEditingController();
  final userCollection = FirebaseFirestore.instance.collection('User');
  final uid = FirebaseAuth.instance.currentUser?.uid;
  // final fireStore = FirebaseFirestore.instance.collection('User').snapshots();
  final fireStore = FirebaseFirestore.instance;
  // List userProfileList = [];
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchDatabaseList();
  // }
  //
  // fetchDatabaseList() async {
  //   dynamic resultant = await DatabaseManager().getUserList();
  //
  //   if (resultant == null) {
  //     Utils().ToastMsg('Unable to retrieve');
  //   } else {
  //     setState(() {
  //       userProfileList = resultant;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff252525),
      // backgroundColor: Colors.green,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 70, left: 20),
            child: Text(
              'My Questions',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 12),
            child: TextFormField(
                controller: searchFilter,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.0)),
                ),
                onChanged: (String value) {
                  setState(() {});
                }),
          ),

          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                StreamBuilder<QuerySnapshot>(
                    stream: fireStore
                        .collection("User")
                        .doc(uid)
                        .collection("question")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // return CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        return Text('Some Error Occured');
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  final uri = snapshot.data!.docs[index]['link']
                                      .toString();
                                  launch(uri);
                                },
                                // onTap: () {
                                //
                                //   deleteQuestion(snapshot
                                //       .data!.docs[index]['id']
                                //       .toString());
                                // },
                                child: Dismissible(
                                  direction: DismissDirection.startToEnd,
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    deleteQuestion(snapshot
                                        .data!.docs[index]['id']
                                        .toString());
                                  },
                                  child: VerticalDetailsList(
                                      QName: snapshot.data!.docs[index]['title']
                                          .toString()),
                                ),
                              );
                            }),
                      );
                    }),
              ],
            ),
          ),
          // Expanded(
          //     child: FirebaseAnimatedList(
          //   defaultChild: const Center(
          //     //     child: Text(
          //     //   'Loading...',
          //     //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          //     // )
          //     child: CircularProgressIndicator(
          //       color: Colors.black87,
          //     ),
          //   ),
          //   query: ref,
          //   itemBuilder: (context, snapshot, animation, index) {
          //     // final title = snapshot.child('title').value.toString();
          //     final category = snapshot.child('category').value.toString();
          //     if (searchFilter.text.isEmpty) {
          //       return Container(
          //         color: Color(0xff252525),
          //         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          //         child: Card(
          //           elevation: 3,
          //           color: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(18),
          //           ),
          //           child: ListTile(
          //             leading: const Icon(
          //               Icons.arrow_forward_ios,
          //               color: Colors.black87,
          //               size: 18,
          //             ),
          //             textColor: Colors.black87,
          //             onTap: () {
          //               Uri uri;
          //               String stringUri =
          //                   snapshot.child('link').value.toString();
          //               uri = Uri.parse(stringUri);
          //               launchUrl(uri);
          //             },
          //             title: Text(
          //               snapshot.child('title').value.toString(),
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 15),
          //             ),
          //             subtitle: Text(
          //               snapshot.child('category').value.toString(),
          //               style: TextStyle(fontSize: 10),
          //             ),
          //           ),
          //         ),
          //       );
          //     } else if (category
          //         .toLowerCase()
          //         .contains(searchFilter.text.toLowerCase())) {
          //       return Container(
          //         color: Colors.white,
          //         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          //         child: Card(
          //           elevation: 3,
          //           color: Colors.white,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(18),
          //           ),
          //           // child: ListTile(
          //           //   leading: const Icon(
          //           //     Icons.arrow_forward_ios,
          //           //     color: Colors.black87,
          //           //     size: 18,
          //           //   ),
          //           //   textColor: Colors.black87,
          //           //   onTap: () {
          //           //     Uri uri;
          //           //     String stringUri =
          //           //         snapshot.child('link').value.toString();
          //           //     uri = Uri.parse(stringUri);
          //           //     launchUrl(uri);
          //           //   },
          //           //   title: Text(
          //           //     snapshot.child('title').value.toString(),
          //           //     style: const TextStyle(
          //           //         fontWeight: FontWeight.bold, fontSize: 15),
          //           //   ),
          //           //   subtitle:
          //           //       Text(snapshot.child('category').value.toString()),
          //           // ),
          //           child: ListTile(
          //             leading: const Icon(
          //               Icons.arrow_forward_ios,
          //               color: Colors.black87,
          //               size: 18,
          //             ),
          //             textColor: Colors.black87,
          //             onTap: () {
          //               Uri uri;
          //               String stringUri =
          //                   snapshot.child('link').value.toString();
          //               uri = Uri.parse(stringUri);
          //               launchUrl(uri);
          //             },
          //             title: Text(
          //               snapshot.child('title').value.toString(),
          //               style: const TextStyle(
          //                   fontWeight: FontWeight.bold, fontSize: 15),
          //             ),
          //             subtitle:
          //                 Text(snapshot.child('category').value.toString()),
          //           ),
          //         ),
          //       );
          //     } else {
          //       return Container();
          //     }
          //   },
          // )),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddContacts()));
          },
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Future getCurrentUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String name = ds.get('Name');
      return name;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  deleteQuestion(id) {
    FirebaseFirestore.instance
        .collection("User")
        .doc(uid)
        .collection("question")
        .doc(id)
        .delete();
  }
}
// Expanded(
// child: StreamBuilder(
// stream: ref.onValue,
// builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
// if (!snapshot.hasData) {
// return CircularProgressIndicator();
// } else {
// Map<dynamic, dynamic> map =
// snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list = [];
// list.clear();
// list = map.values.toList();
// return ListView.builder(
// itemCount: snapshot.data!.snapshot.children.length,
// itemBuilder: (context, index) {
// return ListTile(
// title: Text(list[index]['title']),
// );
// });
// }
// },
// ),
// ),
