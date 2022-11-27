import 'package:flutter/cupertino.dart';

class CategoryItems extends StatefulWidget {
  const CategoryItems({Key? key, required this.title}) : super(key: key);

  final String title;
  // final String Package;
  // final String img;

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.all(15),
      child: Text(widget.title),
      decoration: BoxDecoration(
          color: Color(0xFF2E3331), borderRadius: BorderRadius.circular(15)),
    );
  }
}
