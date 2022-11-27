import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/screens/Vertical_Details.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetailScreen extends StatefulWidget {
  const CompanyDetailScreen({
    Key? key,
    required this.img,
    required this.tag,
    required this.companyName,
    required this.desc,
    required this.A1,
    required this.A1Link,
    required this.A2,
    required this.A2Link,
    required this.id,
  }) : super(key: key);

  final String img, desc, A1, A1Link, A2, A2Link;
  final String tag, id;
  final String companyName;
  // Uri? uri;
  // String? stringUri;

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
  final fireStore = FirebaseFirestore.instance;

  Uri? uri;
  String? stringUri;
  // Uri? uri;
  // String? stringUri;
  @override
  Widget build(BuildContext context) {
    stringUri = widget.img;
    uri = Uri.parse(stringUri!);

    return Scaffold(
      backgroundColor: Color(0xff252525),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 230,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60)),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xffB3E4AD5F), Color(0xff0DDC9754)])),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Hero(
                    tag: widget.tag,
                    child: Container(
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white54, width: 3),
                        image: DecorationImage(
                          image: NetworkImage(widget.img),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.companyName.toUpperCase(),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white38),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(physics: BouncingScrollPhysics(), children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 30, bottom: 30),
                child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: double.infinity,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Color(0xFF7D7D7D)),
                  child: Padding(
                    padding: const EdgeInsets.all(17.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.all(16.0),
                        Text(
                          widget.desc,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              'Our Alumini: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 5),
                            child: GestureDetector(
                              onTap: () async {
                                final uri = widget.A1Link;
                                launch(uri);
                              },
                              child: Text(
                                widget.A1,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    color: Colors.lightBlueAccent),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 8),
                            child: GestureDetector(
                              onTap: () async {
                                final uri = widget.A2Link;
                                launch(uri);
                              },
                              child: Text(
                                widget.A2,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    decoration: TextDecoration.underline,
                                    color: Colors.lightBlueAccent),
                              ),
                            ),
                          ),
                        ),
                        // ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              'Package: 7LPA',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        StreamBuilder<QuerySnapshot>(
                            //to fetch sub collection data
                            stream: fireStore
                                .collection("Company")
                                .doc(widget.id)
                                .collection("Questions")
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                return Text('Some Error Occured');
                              }
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: ListView.builder(
                                    itemCount: snapshot.data!.docs.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          final uri = snapshot
                                              .data!.docs[index]['QLink']
                                              .toString();
                                          launch(uri);
                                        },
                                        child: VerticalDetailsList(
                                            QName: snapshot
                                                .data!.docs[index]['QName']
                                                .toString()),
                                      );
                                      // ListTile(
                                      //   title: Text(snapshot
                                      //       .data!.docs[index]['CompanyName']
                                      //       .toString()),
                                      //   // subtitle: Text(
                                      //   //   snapshot.data!.docs[index]['Package']
                                      //   //       .toString(),
                                      //   // ),
                                      // );
                                    }),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )
        ],
      )),
    );
  }

  // Future<QuerySnapshot> RetrieveSubCol() {
  //   fireStore.collection("Company").get().then((value) {
  //     value.docs.forEach((result) {
  //       fireStore
  //           .collection("Company")
  //           .doc(result.id)
  //           .collection("Questions")
  //           .snapshots();
  //     });
  //   });
  // }
}
