import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/Widgets/Round_btn.dart';
import 'package:flutter_crud_fb/screens/Auth/Login.dart';
import 'package:flutter_crud_fb/screens/SplashScreen.dart';
// import 'package:flutter_crud_fb/screens/Start/Login.dart';
import 'package:flutter_crud_fb/screens/contacts.dart';
import 'package:flutter_crud_fb/screens/nav_pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'flutter crud',
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        // home: Contacts(),
        home: SplashScreen());
  }
}
