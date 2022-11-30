import 'dart:math';

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
import 'package:shoppy/screens/CategorySearch.dart';

import '../models/User.dart';
import '../NavigationBarScreen.dart';
import '../styles/colors.dart';
import 'ProductScreen.dart';
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
  _CategoryScreenState(
    this.category,
  );

  void _onRefresh() async {
    var subs = await getSubcategoriesByCategory(category);
    List<Offer> offers = await getCategoryOffers(subs);
    setState(() {
      CategorySubcategories = subs;
      category.categoryOffers = offers;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var subs = await getSubcategoriesByCategory(category);
    List<Offer> offers = await getCategoryOffers(subs);
    setState(() {
      CategorySubcategories = subs;
      category.categoryOffers = offers;
    });
    _refreshController.loadComplete();
  }

  List<Color> iconColors = <Color>[];
  User user = localUser;

  @override
  Widget build(BuildContext context) {
    //getLists(ProductImage, ProductName, subname);
    // this will be fixed after adding from the database the liked products
    // Rember to check it
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        title: Text(
          category.categoryName,
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
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Column(children: [
            searchBar(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Align(
                alignment: const Alignment(-0.95, -1),
                child: TextButton(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Subcategories ",
                            style: TextStyle(
                                fontSize: 25,
                                color: ShoppyColors.blue,
                                fontWeight: FontWeight.w500),
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
                  onPressed: () {}, //will take you to subcategories screen
                ),
              ),
            ),
            showSubcategories(),
            sortAndFilter(),
            listOfOffers(),
          ]),
        )),
      ),
    );
  }

  Future<List<Offer>> getCategoryOffers(List<Subcategory> subs) async {
    List<Offer> offers = [];
    for (Subcategory element in subs) {
      element.subcategoryOffers = await getOffersBySubcategory(element);
      for (Offer el in element.subcategoryOffers) {
        offers.add(el);
      }
    }
    return offers;
  }

  Padding sortAndFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(children: [
        TextButton.icon(
          //contentPadding:const EdgeInsets.only(bottom: 0),
          // <-- TextButton
          onPressed: () {},
          icon: Icon(
            Icons.sort,
            size: 15.0,
            color: ShoppyColors.blue,
          ),
          label: const Text('Sort'),
          style: TextButton.styleFrom(
            //padding: EdgeInsets.all(0),
            foregroundColor: ShoppyColors.blue, // Text Color
          ),
        ),
        const Spacer(),
        TextButton.icon(
          // <-- TextButton
          onPressed: () {},
          label: const Text('Filter'),
          icon: Icon(
            Icons.filter_alt_rounded,
            size: 15.0,
            color: ShoppyColors.blue,
          ),
          style: TextButton.styleFrom(
            // padding: EdgeInsets.all(0),
            foregroundColor: ShoppyColors.blue, // Text Color
          ),
        ),
      ]),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
      child: TextFormField(
        onFieldSubmitted: (value) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CategorySearch(
                      string: value.toString(),
                      category: category,
                    )),
          );
        },
        style: TextStyle(color: ShoppyColors.blue),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: ShoppyColors.blue,
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
          fillColor: const Color.fromARGB(108, 225, 225, 225),
          filled: true,
          hintStyle: TextStyle(color: ShoppyColors.blue, fontSize: 20),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(color: ShoppyColors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide:
                  const BorderSide(color: Color.fromARGB(108, 225, 225, 225))),
          hintText: "Search...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
        ),
      ),
    );
  }

  ListView listOfOffers() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: category.categoryOffers.length,
        //itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        ProductScreen(offer: category.categoryOffers[index])),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
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
                              color: (user.likedProduct.any(((element) =>
                                      element.productId ==
                                      category.categoryOffers[index].product
                                          .productId))
                                  ? ShoppyColors.red
                                  : ShoppyColors.blue),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if ((user.likedProduct.any(((element) =>
                                    element.productId ==
                                    category.categoryOffers[index].product
                                        .productId)))) {
                                  ShoppyColors.blue;
                                  removeFromLikedProducts(
                                      category.categoryOffers[index].product);
                                } else {
                                  ShoppyColors.red;
                                  addToLikedProducts(
                                      category.categoryOffers[index].product);
                                }
                                // if (iconColors[index] == ShoppyColors.blue)
                                //   iconColors[index] = ShoppyColors.red;
                                // else
                                //   iconColors[index] = ShoppyColors.blue;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            category.categoryOffers[index].product.productImage,
                            width: MediaQuery.of(context).size.width * 0.16,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.0250,
                              left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
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
                                    height: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  Text(
                                    //textAlign:TextAlign.left,
                                    category.categoryOffers[index].storeName,
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
                              top: MediaQuery.of(context).size.height * 0.0150,
                              //left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  category
                                      .categoryOffers[index].storePictureURL,
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
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
            ),
          );
        });
  }

  SizedBox showSubcategories() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: CategorySubcategories.map((s) {
          return InkWell(
            onTap: () {
              setState(() {
                navigateToSubcategory(s);
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 1, right: 5, bottom: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                      blurRadius: 2,
                      color: Color(0x320E151B),
                      offset: Offset(2, 2),
                    )
                  ],
                  borderRadius: BorderRadius.circular(500),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(500),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CachedNetworkImage(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                imageUrl: s.subcategoryImage,
                                imageBuilder: ((context, imageProvider) =>
                                    Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                s.subcategoryImage)),
                                      ),
                                    )),
                              ),
                              SizedBox(
                                width: 50,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    s.subcategoryName,
                                    style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 14,
                                        color: ShoppyColors.blue),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              )
                            ]),
                      ),
                      const SizedBox(
                        width: 5,
                      )
                    ]),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void navigateToSubcategory(Subcategory s) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SubCategoryScreen(subcategory: s)),
    );
    setState(() {
      user = localUser;
    });
  }

  SizedBox showSubcategories2() {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 1,
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: CategorySubcategories.map((s) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => SubCategoryScreen(subcategory: s)),
              );
            },
            child: Column(children: [
              Padding(
                padding:
                    const EdgeInsets.only(top: 5, bottom: 0, left: 5, right: 5),
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
    );
  }
}
