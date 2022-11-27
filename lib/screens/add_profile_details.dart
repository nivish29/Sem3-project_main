import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';
import 'package:flutter_crud_fb/screens/nav_pages/main_page.dart';

import '../Widgets/Round_btn.dart';

class AddProfileDetails extends StatefulWidget {
  const AddProfileDetails({Key? key}) : super(key: key);

  @override
  State<AddProfileDetails> createState() => _AddProfileDetailsState();
}

class _AddProfileDetailsState extends State<AddProfileDetails> {
  final _formField = GlobalKey<FormState>();

  TextEditingController emailendController = TextEditingController();
  final NameController = TextEditingController();
  final IdController = TextEditingController();
  final passwordController = TextEditingController();
  final NumberController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final fireStore = FirebaseFirestore.instance.collection('User');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: Color(0xFFF2EFF5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.values,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 150,
              ),
              Container(
                // margin: EdgeInsets.only(left: 20),
                child: const Text(
                  'Register!!',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Form(
                  key: _formField,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: NameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Name',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.name,
                        maxLines: 1,
                        controller: NumberController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Phone Number',
                          prefixIcon: Icon(Icons.account_circle),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Phone Number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        controller: IdController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Institute Id',
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Institute Id';
                          }
                          return null;
                        },
                      ),
                    ],
                  )),
              SizedBox(
                height: 30,
              ),
              RoundButton(
                  title: 'Sign Up',
                  onTap: () {
                    fireStore.doc(uid).set({
                      'id': uid,
                      'Name': NameController.text.toString(),
                      'PhoneNumber': NumberController.text.toString(),
                      'Id': IdController.text.toString(),
                    }).then((value) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    }).onError((error, stackTrace) {
                      Utils().ToastMsg(error.toString());
                    });
                  }),
              const SizedBox(
                height: 70,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
