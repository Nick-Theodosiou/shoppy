import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/screens/BestDealsScreen.dart';
import 'package:shoppy/screens/CategoriesScreen.dart';

import '../NavigationBarScreen.dart';
import '../styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  final String Subname;
  // ignore: non_constant_identifier_names
  const SubCategoryScreen({super.key, required this.Subname});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreennState(Subname);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _SubCategoryScreennState extends State<SubCategoryScreen> {
  List<String> ProductImage = <String>[];
  List<String> ProductName = <String>[];
  String subname;
  _SubCategoryScreennState(String this.subname);
  //getLists(ProductImage, ProductName, subname);
  //// User user = localUser;
  //bool _notificationsEnabled = true;

  // void _updateNotifications(bool notifications) {
  //   _notificationsEnabled = notifications;
  // }
  List<String> product = <String>[];
  @override
  Widget build(BuildContext context) {
    getLists(ProductImage, ProductName, subname);
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back, color: Colors.white),
      //     onPressed: () {
      //       // Navigator.pop(context, true);
      //       //SaveChanges(iconColors);
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (_) => const NavigationBarScreen()));
      //     },
      //   ),
      //   title: Text(
      //     this.subname,
      //     style: TextStyle(
      //       color: ShoppyColors.gray,
      //       fontSize: 25,
      //     ),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: ShoppyColors.blue,
      // ),
      body: SingleChildScrollView(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: 3,
            //itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01,
                  //bottom:MediaQuery.of(context).size.height * 0.05
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320E151B),
                        offset: Offset(0, 1),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          ProductImage[index],
                          //cartItems[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          // NamesofSM[index],
                          ProductName[index],
                          style: TextStyle(
                              color: ShoppyColors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        // IconButton(
                        //   icon: Icon(
                        //     Icons.favorite,
                        //     color: iconColors[index],
                        //     //color: Color(0xFFE86969),
                        //     size: 20,
                        //   ),
                        //   onPressed: () {
                        //     setState(() {
                        //       if (iconColors[index] == ShoppyColors.blue)
                        //         iconColors[index] = ShoppyColors.red;
                        //       else
                        //         iconColors[index] = ShoppyColors.blue;
                        //     });
                        //     // Favorite Supermarket /Unfavorite Supermarket
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

void getLists(List<String> image, List<String> Name, String Subname) {
  if (Subname == 'Nicolas') {
    for (int i = 0; i < 3; i++) {
      image.add('https://nicolastheodosiou.pages.dev/images/prof.png');
      Name.add('Nicolas');
    }
  } else if (Subname == 'Banana') {
    for (int i = 0; i < 3; i++) {
      image.add(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg');
      Name.add('Banana');
    }
  }
}
