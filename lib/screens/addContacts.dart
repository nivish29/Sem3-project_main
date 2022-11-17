import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddContacts extends StatefulWidget {
  const AddContacts({Key? key}) : super(key: key);

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  List<String> items = [
    'Dynamic Programming',
    'Graph',
    'Divide and conquer',
    'Sorting',
    'Greedy Algorithm',
    'Hashing',
    'Others'
  ];
  String? selectedItem = 'Others';
  final addContactsController = TextEditingController();
  final addLinkController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('MyQuestions');
  //watch the tech brothers video
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contacts'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 4,
              controller: addContactsController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Whatever you like just dump it here'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              maxLines: 2,
              controller: addLinkController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Add Link'),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              // padding: EdgeInsets.all(10),
              // child: Padding(
              // padding: const EdgeInsets.all(16.0),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(6)),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 26,
                  isExpanded: true,
                  style: TextStyle(color: Colors.black, fontSize: 20),
                  items: items.map((itemsname) {
                    return DropdownMenuItem(
                        value: itemsname, child: Text(itemsname));
                  }).toList(),
                  onChanged: (newvalue) {
                    setState(() {
                      selectedItem = newvalue;
                    });
                  },
                  value: selectedItem,
                ),
              ),
              // ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                width: 250,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      loading = true;
                    });
                    databaseRef
                        .child(DateTime.now().millisecondsSinceEpoch.toString())
                        .set({
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                      'title': addContactsController.text.toString(),
                      'category': selectedItem.toString(),
                      'link': addLinkController.text.toString(),
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Added to Database"),
                      ));
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("an Error occured"),
                      ));
                      setState(() {
                        loading = false;
                      });
                    });
                  },
                  child: Text('Add Contact'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                )),
          ],
        ),
      ),
    );
  }
}
