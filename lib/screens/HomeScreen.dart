import 'package:flutter/material.dart';
import 'package:shoppy/screens/StoresScreen.dart';

import '../styles/colors.dart';
import 'CategoriesScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: Scaffold(
          //touto to button en gia na pernei sto sign up page gia testing
          body: Column(
        children: [
          TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Supermarkets",
                      style: TextStyle(fontSize: 25, color: ShoppyColors.blue),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 25,
                        color: ShoppyColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const StoresScreen()),
              );
            },
          ),
          TextButton(
            child: Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Categories",
                      style: TextStyle(fontSize: 25, color: ShoppyColors.blue),
                    ),
                    WidgetSpan(
                      child: Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 25,
                        color: ShoppyColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const CategoriesScreen()),
              );
            },
          ),
        ],
      )),
    );
  }
}
