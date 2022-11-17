import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_fb/Widgets/Round_btn.dart';
import 'package:flutter_crud_fb/screens/Auth/SignUp_Screen.dart';
import 'package:flutter_crud_fb/screens/nav_pages/main_page.dart';

import '../../Utils/utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Logged In"),
      ));
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      Utils().ToastMsg(value.user!.email.toString());
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().ToastMsg(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      //used to exit the app when back is pressed
      //see tech brother video on firebase part six
      //6:15
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // appBar: AppBar(
        //   // automaticallyImplyLeading: false,
        // ),
        // backgroundColor: Color(0xFFF2EFF5),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 120,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 20),
                  child: const Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  // margin: EdgeInsets.only(left: 20),
                  child: const Text(
                    'Welcome!!',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
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
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: true,
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: 'Enter Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock),
                          ),
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Enter Password';
                            }
                            return null;
                          },
                        ),
                      ],
                    )),
                Row(
                  children: [
                    Container(
                        child: TextButton(
                            onPressed: () {}, child: Text('Forgot password?'))),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                RoundButton(
                    title: 'Login',
                    onTap: () {
                      if (_formField.currentState!.validate()) {
                        login();
                      }
                    }),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    lineImg(),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Or Continue with',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    lineImg(),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  child: Center(
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset('images/googlebg.png'),
                      iconSize: 35,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign Up')),
                  ],
                ),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class lineImg extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('images/line.png');
    Image image = Image(image: assetImage);
    return Container(
      child: image,
    );
  }
}
