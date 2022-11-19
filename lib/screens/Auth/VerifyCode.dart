import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/screens/nav_pages/main_page.dart';
import 'package:pinput/pinput.dart';

import '../../Utils/utils.dart';
import '../../Widgets/Round_btn.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String Verificationid;
  const VerifyCodeScreen({Key? key, required this.Verificationid})
      : super(key: key);

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool Loading = false;
  final auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
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
                  'Verify!!',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Pinput(
                keyboardType: TextInputType.phone,
                length: 6,
                showCursor: true,
                controller: otpController,
                // decoration: const InputDecoration(
                //   border: OutlineInputBorder(),
                //   hintText: 'Enter OTP',
                //   prefixIcon: Icon(Icons.phone),
                // ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter OTP';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                  title: 'Verify',
                  onTap: () async {
                    setState(() {
                      Loading = true;
                    });
                    final credential = PhoneAuthProvider.credential(
                        verificationId: widget.Verificationid,
                        smsCode: otpController.text.toString());
                    try {
                      await auth.signInWithCredential(credential);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MainPage()));
                    } catch (e) {
                      Utils().ToastMsg(e.toString());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
