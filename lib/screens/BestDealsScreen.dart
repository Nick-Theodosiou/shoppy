import 'package:flutter/material.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/models/Subcategory.dart';
import 'package:shoppy/screens/CategoriesScreen.dart';
import 'package:shoppy/screens/SubCategoryScreen.dart';

import '../DataController.dart';
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
              onPressed: () async {
                List<Category> listC = await getCategories();
                List<Subcategory> listS =
                    await getSubcategoriesByCategory(listC[0]);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SubCategoryScreen(
                            subcategory: listS[0],
                          )),
                );
              },
            ),
            // TextButton(
            //   child: Align(
            //     alignment: Alignment.topLeft,
            //     child: RichText(
            //       softWrap: true,
            //       text: TextSpan(
            //         children: [
            //           TextSpan(
            //             text: "Sub Categories-Banana",
            //             style:
            //                 TextStyle(fontSize: 25, color: ShoppyColors.blue),
            //           ),
            //           WidgetSpan(
            //             child: Icon(
            //               Icons.arrow_right_alt,
            //               size: 25,
            //               color: ShoppyColors.blue,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //           builder: (_) => const SubCategoryScreen(
            //                 Subname: 'Banana',
            //               )),
            //     );
            //   },
            // ),
          ]),
        ));
  }
}
