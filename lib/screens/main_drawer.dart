import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_fb/Utils/utils.dart';
import 'package:flutter_crud_fb/screens/Auth/Login.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final auth = FirebaseAuth.instance;
  // void inputData() {
  //   // final User? user = auth.currentUser;
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   Utils().ToastMsg(uid.toString());
  //   // here you write the codes to input the data into firestore
  // }
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 150,
                    height: 120,
                    margin: EdgeInsets.only(top: 40, bottom: 10),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://phantom-marca.unidadeditorial.es/73ef2a1fc3f92d724861d276f6ba23ce/crop/19x0/1747x1154/resize/1320/f/jpg/assets/multimedia/imagenes/2022/10/10/16654312679454.png'),
                            fit: BoxFit.fill)),
                  ),
                  const Text(
                    'Name',
                    style: TextStyle(fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            onTap: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              }).onError((error, stackTrace) {
                Utils().ToastMsg(error.toString());
              });
            },
            leading: Icon(Icons.logout),
            title: Text('Logout'),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Utils().ToastMsg(uid.toString());
            },
            leading: Icon(Icons.account_circle),
            title: Text('UID'),
          ),
        ],
      ),
    );
  }
}
