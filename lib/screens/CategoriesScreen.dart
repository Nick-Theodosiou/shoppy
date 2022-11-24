import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/styles/colors.dart';

import '../DataController.dart';
import '../NavigationBarScreen.dart';
import 'HomeScreen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoriesScreenDemo(),
    );
  }
}

class CategoriesScreenDemo extends StatefulWidget {
  const CategoriesScreenDemo({super.key});
  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreenDemo> {
  @override
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Category> Categories = [];

  void _onRefresh() async {
    var categories = await getCategories();
    setState(() {
      Categories = categories;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var categories = await getCategories();
    setState(() {
      Categories = categories;
    });
    _refreshController.loadComplete();
  }

  static List<Color> iconColors = <Color>[];
  //set to static to show when the DB ready we will request the liked Categories
  //static  List<Color> LastState =<Color>[];

  Widget build(BuildContext context) {
    if (iconColors.isEmpty) {
      createIconColorList();
    }
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context, true);
            //SaveChanges(iconColors);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NavigationBarScreen()),
            );
          },
        ),
        title: Text(
          "Categories",
          style: TextStyle(
            color: ShoppyColors.gray,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: ShoppyColors.blue,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: 10,
                right: 10,
                bottom: 10),
            child: Column(
              children: [
                TextFormField(
                  style: TextStyle(color: ShoppyColors.blue),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: ShoppyColors.blue,
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    fillColor: const Color.fromARGB(108, 225, 225, 225),
                    filled: true,
                    hintStyle:
                        TextStyle(color: ShoppyColors.blue, fontSize: 20),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide(color: ShoppyColors.blue)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(108, 225, 225, 225))),
                    hintText: "Search...",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35)),
                  ),
                ),
                Row(children: [
                  Align(
                    alignment: const Alignment(-0.95, -0.9),
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.sort_rounded,
                              size: 22,
                              color: ShoppyColors.blue,
                            ),
                          ),
                          TextSpan(
                            text: "Sort",
                            style: TextStyle(
                                fontSize: 20, color: ShoppyColors.blue),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Align(
                    alignment: const Alignment(0.95, -0.95),
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Filter",
                            style: TextStyle(
                                fontSize: 20, color: ShoppyColors.blue),
                          ),
                          WidgetSpan(
                            child: Icon(
                              Icons.filter_alt,
                              size: 22,
                              color: ShoppyColors.blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 20.0,
                    childAspectRatio: (500 / 650),
                  ),
                  itemCount: Categories.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CategoriesScreen()),
                            );
                          }, // Image tapped, takes you to category screen
                          child: Image.network(
                            Categories.elementAt(index).categoryImage,
                          ),
                        ),
                        Text(
                          Categories.elementAt(index).categoryName,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void createIconColorList() {
    int length = Categories.length;
    for (var i = 0; i < length; i++) {
      iconColors.add(ShoppyColors.blue);
    }
  }
//   SaveChanges(List StateC )
// {
// for(int i=0 ;i<StateC.length;i++) {
//   LastState[i]=StateC[i];
// }
// }
// List GetState(List LastState){
//   if(LastState.length>0) {
//     return LastState;
//   } else
//   return new List<Color>;
// }
}


// ignore: avoid_types_as_parameter_names, non_constant_identifier_names