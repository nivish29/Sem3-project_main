import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalDetailsList extends StatefulWidget {
  const VerticalDetailsList({Key? key, required this.QName}) : super(key: key);

  final String QName;
  // final String tag;

  @override
  State<VerticalDetailsList> createState() => _VerticalDetailsListState();
}

class _VerticalDetailsListState extends State<VerticalDetailsList> {
  final fireStore = FirebaseFirestore.instance
      .collection('Company')
      .doc('Questions')
      .snapshots();
  Uri? uri;
  String? stringUri;

  // uri = Uri.parse(stringUri);
  @override
  Widget build(BuildContext context) {
    stringUri = widget.QName;
    uri = Uri.parse(stringUri!);
    return Padding(
      padding: EdgeInsets.only(
        bottom: 0,
      ),
      child: SizedBox(
          height: 130,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 92,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff3c413f),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.30),
                        spreadRadius: 0,
                        blurRadius: 13,
                        offset: Offset(0, 9),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 17),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20, bottom: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            widget.QName.toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              'Click to see',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 10,
                                  color: Color(0xFF8C8C8C)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 20, bottom: 20, left: 50),
                    //   child: Icon(
                    //     Icons.arrow_forward_ios,
                    //     color: Colors.white24,
                    //     size: 20,
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
