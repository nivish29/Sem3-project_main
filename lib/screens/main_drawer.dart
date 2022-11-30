import 'package:cloud_firestore/cloud_firestore.dart';
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
  // String? _Name;
  String? Name;
  final auth = FirebaseAuth.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final userCollection = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser?.uid);
  // void inputData() {
  //   // final User? user = auth.currentUser;
  //   final uid = FirebaseAuth.instance.currentUser?.uid;
  //   Utils().ToastMsg(uid.toString());
  //   // here you write the codes to input the data into firestore
  // }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color(0xff252525),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            // color: Color(0xffE4AD5F),

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
                  Text(
                    '$Name',
                    style: TextStyle(fontSize: 18, color: Colors.white),
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
            title: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
          SizedBox(
            height: 5,
          ),
          ListTile(
            onTap: () {
              Utils().ToastMsg(uid.toString());
            },
            leading: Icon(Icons.account_circle),
            title: Text(
              'UID',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // ListTile(
          //   onTap: () {
          //     Utils().ToastMsg(uid.toString());
          //   },
          //   leading: Icon(Icons.account_circle),
          //   title: Text('hello $Name'),
          // ),
        ],
      ),
    );
  }

  // Future getCurrentUserData() async {
  //   try {
  //     DocumentSnapshot ds = await userCollection.doc(uid).get();
  //     String name = ds.get('Name');
  //     return name;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }
  void getUserName() async {
    // FirebaseFirestore.instance
    //     .collection('Users')
    //     .doc((await FirebaseAuth.instance.currentUser?.uid))
    //     .get()
    //     .then((value) {
    //   setState(() {
    //     _Name = value.data()?['Name'].toString();
    //   });
    // });

    User? user = await FirebaseAuth.instance.currentUser;
    var vari = await FirebaseFirestore.instance
        .collection('User')
        .doc(user?.uid)
        .get();
    setState(() {
      Name = vari.data()!['Name'];
    });
  }
}
