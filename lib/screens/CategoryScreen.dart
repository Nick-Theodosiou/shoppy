import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/models/Subcategory.dart';
import 'package:shoppy/screens/BestDealsScreen.dart';
import 'package:shoppy/screens/CategoriesScreen.dart';

import '../NavigationBarScreen.dart';
import '../styles/colors.dart';
import 'SubCategoryScreen.dart';

class CategoryScreen extends StatefulWidget {
  final Category category;
  // ignore: non_constant_identifier_names
  const CategoryScreen({super.key, required this.category});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState(category);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _CategoryScreenState extends State<CategoryScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  Category category;
  List<Subcategory> CategorySubcategories = <Subcategory>[];
  _CategoryScreenState(Category this.category);

  void _onRefresh() async {
    var subs = await getSubcategoriesByCategory(category);
    setState(() {
      CategorySubcategories = subs;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var subs = await getSubcategoriesByCategory(category);
    setState(() {
      CategorySubcategories = subs;
    });
    _refreshController.loadComplete();
  }

  List<Color> iconColors = <Color>[];
  @override
  Widget build(BuildContext context) {
    //getLists(ProductImage, ProductName, subname);
    if (iconColors.isEmpty) {
      createIconColorList();
    }
    // this will be fixed after adding from the database the liked products
    // Rember to check it
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const NavigationBarScreen()));
          },
        ),
        title: Text(
          this.category.categoryName,
          style: TextStyle(
            color: ShoppyColors.gray,
            fontSize: 25,
          ),
          textAlign: TextAlign.left,
        ),

        //centerTitle: true,
        backgroundColor: ShoppyColors.blue,
      ),
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.003,
          ),
          child: Column(children: [
            Align(
              alignment: const Alignment(-0.95, -1),
              child: RichText(
                softWrap: true,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Subcategories",
                      style: TextStyle(
                          fontSize: 25,
                          color: ShoppyColors.blue,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.15,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: CategorySubcategories.map((s) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => SubCategoryScreen(
                                subcategory:
                                    s)), //will normaly take you to the supermarket's page
                      );
                    },
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 0, left: 5, right: 5),
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          imageUrl: s.subcategoryImage,
                          imageBuilder: ((context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(s.subcategoryImage)),
                                ),
                              )),
                        ),
                      ),
                      Text(s.subcategoryName,
                          style: TextStyle(color: ShoppyColors.blue)),
                    ]),
                  );
                }).toList(),
              ),
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: category.categoryOffers.length,
                //itemCount: cartItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        // top: MediaQuery.of(context).size.height * 0.00,
                        left: MediaQuery.of(context).size.width * 0.03,
                        right: MediaQuery.of(context).size.width * 0.03,
                        bottom: MediaQuery.of(context).size.height * 0.01),
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0, 8, 8, 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 100,
                              width: 30,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: iconColors[index],
                                    //color: Color(0xFFE86969),
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (iconColors[index] ==
                                          ShoppyColors.blue)
                                        iconColors[index] = ShoppyColors.red;
                                      else
                                        iconColors[index] = ShoppyColors.blue;
                                    });
                                    // Favorite Supermarket /Unfavorite Supermarket
                                  },
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                category
                                    .categoryOffers[index].product.productImage,
                                width: MediaQuery.of(context).size.width * 0.16,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.01,
                                    left: MediaQuery.of(context).size.height *
                                        0.01,
                                  ),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          // NamesofSM[index]
                                          //textAlign:TextAlign.left,
                                          category.categoryOffers[index].product
                                              .productName,
                                          style: TextStyle(
                                              color: ShoppyColors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold
                                              //fontWeight: FontWeight.w400
                                              ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.004,
                                        ),
                                        Text(
                                          //textAlign:TextAlign.left,
                                          category
                                              .categoryOffers[index].storeName,
                                          style: TextStyle(
                                              color: ShoppyColors.blue,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w300),
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            Expanded(
                              //flex: 1,
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.001,
                                    //left: MediaQuery.of(context).size.height * 0.01,
                                  ),
                                  child: Column(
                                    children: [
                                      Image.network(
                                        category.categoryOffers[index]
                                            .storePictureURL,
                                        width: 80,
                                        height: 50,
                                        fit: BoxFit.fitWidth,
                                      ),
                                      // SizedBox(
                                      //   height:
                                      //       MediaQuery.of(context).size.height *
                                      //           0.000,
                                      // ),
                                      Text(
                                        "€${category.categoryOffers[index].price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            fontWeight: FontWeight.w500,
                                            color: ShoppyColors.blue),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ]),
        )),
      ),
    );
  }

  void createIconColorList() {
    int length = category.categoryOffers.length;
    for (var i = 0; i < length; i++) {
      iconColors.add(ShoppyColors.blue);
    }
  }
  // TextFormField textFormField(String textH, TextEditingController eController) {
  //   bool hide = false;
  //   if (textH == 'Password') {
  //     hide = true;
  //   }
  //   return TextFormField(
  //     controller: eController,
  //     obscureText: hide,
  //     style: TextStyle(color: ShoppyColors.blue),
  //     decoration: InputDecoration(
  //       contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
  //       fillColor: const Color.fromARGB(240, 225, 225, 225),
  //       filled: true,
  //       hintStyle: TextStyle(color: ShoppyColors.blue),
  //       focusedBorder: OutlineInputBorder(
  //           borderRadius: BorderRadius.circular(35),
  //           borderSide: BorderSide(color: ShoppyColors.red)),
  //       hintText: textH,
  //       border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
  //     ),
  //   );
  // }
}

// void getLists(List<String> image, List<String> Name, String Subname) {
//   if (Subname == 'Nicolas') {
//     for (int i = 0; i < 3; i++) {
//       image.add('https://nicolastheodosiou.pages.dev/images/prof.png');
//       Name.add('Nicolas');
//     }
//   } else if (Subname == 'Banana') {
//     for (int i = 0; i < 3; i++) {
//       image.add(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg');
//       Name.add('Banana');
//     }
//   }
// }
