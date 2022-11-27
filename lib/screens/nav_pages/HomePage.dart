import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_crud_fb/Widgets/My_Vertical_List.dart';
import 'package:flutter_crud_fb/screens/Company_Details.dart';
import 'package:flutter_crud_fb/screens/category_screen.dart';
import 'package:flutter_crud_fb/screens/main_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  final fireStore =
      FirebaseFirestore.instance.collection('Company').snapshots();
  final searchFilter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xff252525), //this should be argb and not hex therfore convert it using websites
      drawer: MainDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 10),
            child: Row(
              children: [
                Builder(builder: (context) {
                  return IconButton(
                    color: Colors.white30,
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      size: 30,
                    ),
                  );
                })
              ],
            ),
          ),

          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: const Text(
                    'Discover',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white30),
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),

                StreamBuilder<QuerySnapshot>(
                    stream: fireStore,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
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
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration:
                                            const Duration(milliseconds: 900),
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            CompanyDetailScreen(
                                          img: snapshot.data!.docs[index]['Img']
                                              .toString(),
                                          tag: snapshot
                                              .data!.docs[index]['CompanyName']
                                              .toString(),
                                          companyName: snapshot
                                              .data!.docs[index]['CompanyName']
                                              .toString(),
                                          desc: snapshot
                                              .data!.docs[index]['Desc']
                                              .toString(),
                                          A1: snapshot
                                              .data!.docs[index]['Alumini1Name']
                                              .toString(),
                                          A1Link: snapshot
                                              .data!.docs[index]['Al1Link']
                                              .toString(),
                                          A2: snapshot
                                              .data!.docs[index]['Alumini2Name']
                                              .toString(),
                                          A2Link: snapshot
                                              .data!.docs[index]['Al2Link']
                                              .toString(),
                                          id: snapshot.data!.docs[index]['id']
                                              .toString(),
                                        ),
                                      ));
                                },
                                child: MyVerticalList(
                                  CompanyName: snapshot
                                      .data!.docs[index]['CompanyName']
                                      .toString(),
                                  PackageOffers: snapshot
                                      .data!.docs[index]['Package']
                                      .toString(),
                                  CompanyImg: snapshot.data!.docs[index]['Img']
                                      .toString(),
                                  tag: snapshot.data!.docs[index]['CompanyName']
                                      .toString(),
                                ),
                              );
                            }),
                      );
                    }),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25),
                //   child: ListView.builder(
                //       itemCount: 7,
                //       shrinkWrap: true,
                //       physics: NeverScrollableScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return const MyVerticalList(
                //           CompanyName: 'Google',
                //           PackageOffers: '44lpa',
                //           CompanyImg: 'images/googlebg.png',
                //         );
                //       }),
                // ),
              ],
            ),
          ),

          // StreamBuilder<QuerySnapshot>(
          //     stream: fireStore,
          //     builder: (BuildContext context,
          //         AsyncSnapshot<QuerySnapshot> snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return CircularProgressIndicator();
          //       }
          //       if (snapshot.hasError) {
          //         return Text('Some Error Occured');
          //       }
          //       return Expanded(
          //         child: ListView.builder(
          //             itemCount: snapshot.data!.docs.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 title: Text(snapshot.data!.docs[index]['CompanyName']
          //                     .toString()),
          //                 subtitle: Text(
          //                   snapshot.data!.docs[index]['package'].toString(),
          //                 ),
          //               );
          //             }),
          //       );
          //     }),

          // alignment: Alignment.center,
        ],
      ),
    );
  }
}

Widget CardUI(
  String imgUrl,
  String name,
) {
  return Card(
    margin: EdgeInsets.all(30),
    color: Colors.white,
    child: Container(
      color: Colors.white,
      margin: EdgeInsets.all(1.5),
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
            height: 200,
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
}
