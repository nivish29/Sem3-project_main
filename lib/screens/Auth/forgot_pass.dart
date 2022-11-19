import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';

import '../../Widgets/Round_btn.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 200),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Email';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            RoundButton(
                title: 'Login',
                onTap: () {
                  auth
                      .sendPasswordResetEmail(
                          email: emailController.text.toString())
                      .then((value) {
                    Utils().ToastMsg('Check your mail box');
                  }).onError((error, stackTrace) {
                    Utils().ToastMsg(error.toString());
                  });
                }),
          ],
        ),
      ),
    );
  }
}
