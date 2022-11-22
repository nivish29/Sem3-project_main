import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyVerticalList extends StatelessWidget {
  const MyVerticalList(
      {Key? key,
      required this.CompanyName,
      required this.PackageOffers,
      required this.CompanyImg})
      : super(key: key);

  final String CompanyName, PackageOffers, CompanyImg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 5,
      ),
      child: SizedBox(
          height: 130,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 92,
                width: MediaQuery.of(context).size.width -
                    (MediaQuery.of(context).size.width * 0.13),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFF3E3A6D),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 13,
                        offset: Offset(0, 7),
                      ),
                    ]),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          image:
                              DecorationImage(image: AssetImage(CompanyImg))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 40, bottom: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            CompanyName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              PackageOffers,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xFF8C8C8C)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 20, bottom: 20, left: 80, right: 10),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white24,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
