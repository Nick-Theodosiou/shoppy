import 'package:flutter/material.dart';
import 'package:shoppy/screens/CategoriesScreen.dart';
import 'package:shoppy/screens/SubCategoryScreen.dart';

import '../styles/colors.dart';

class BestDealsScreen extends StatefulWidget {
  @override
  _BestDealsScreenState createState() => _BestDealsScreenState();
}

class _BestDealsScreenState extends State<BestDealsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.pink,
        child: Scaffold(
          body: Column(children: [
            Text('Best Deals Page'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            TextButton(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Sub Categories-Nicolas",
                        style:
                            TextStyle(fontSize: 25, color: ShoppyColors.blue),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_right_alt,
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
                  MaterialPageRoute(
                      builder: (_) => const SubCategoryScreen(
                            Subname: 'Nicolas',
                          )),
                );
              },
            ),
            TextButton(
              child: Align(
                alignment: Alignment.topLeft,
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Sub Categories-Banana",
                        style:
                            TextStyle(fontSize: 25, color: ShoppyColors.blue),
                      ),
                      WidgetSpan(
                        child: Icon(
                          Icons.arrow_right_alt,
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
                  MaterialPageRoute(
                      builder: (_) => const SubCategoryScreen(
                            Subname: 'Banana',
                          )),
                );
              },
            ),
          ]),
        ));
  }
}
