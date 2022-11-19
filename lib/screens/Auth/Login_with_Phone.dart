import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';
import 'package:flutter_crud_fb/screens/Auth/VerifyCode.dart';

import '../../Widgets/Round_btn.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key? key}) : super(key: key);

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool Loading = false;
  final auth = FirebaseAuth.instance;
  final PhoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
              ),
              Container(
                // margin: EdgeInsets.only(left: 20),
                child: const Text(
                  'Login!!',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                maxLines: 1,
                controller: PhoneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Phone Number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: 'Login',
                  onTap: () {
                    setState(() {
                      Loading = true;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: PhoneController.text,
                        verificationCompleted: (_) {
                          Utils().ToastMsg(PhoneController.text);
                          setState(() {
                            Loading = false;
                          });
                        },
                        verificationFailed: (e) {
                          Utils().ToastMsg(e.toString());
                        },
                        codeSent: (String verificationId, int? token) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyCodeScreen(
                                        Verificationid: verificationId,
                                      )));
                          setState(() {
                            Loading = false;
                          });
                        },
                        codeAutoRetrievalTimeout: (e) {
                          Utils().ToastMsg(e.toString());
                          setState(() {
                            Loading = false;
                          });
                        });
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
