//import 'dart:js_util';
import 'dart:developer';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Product.dart';
import 'package:shoppy/models/Store.dart';
import 'package:shoppy/models/Category.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoppy/styles/colors.dart';
import 'CategoriesScreen.dart';
import 'StoresScreen.dart';

void main() {
  runApp(const HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Offer> _bestOffers = [];
  List<Store> _supermarkets = [];
  List<Category> _categories = [];

  var _currentIndex = 0;

  void _onRefresh() async {
    var bestDeals = await getBestDeals(10);
    var stores = await getStores();
    var categories = await getCategories();
    setState(() {
      _bestOffers = bestDeals;
      _supermarkets = stores;
      _categories = categories;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var bestDeals = await getBestDeals(10);
    var stores = await getStores();
    var categories = await getCategories();
    setState(() {
      _bestOffers = bestDeals;
      _supermarkets = stores;
      _categories = categories;
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                      hintStyle: TextStyle(color: ShoppyColors.blue),
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ShoppyColors.yellow,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: RichText(
                              softWrap: true,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Best Offers ",
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              height: MediaQuery.of(context).size.height * 0.17,
                              autoPlayInterval: const Duration(seconds: 3),
                              enlargeCenterPage: false,
                              disableCenter: true,
                              scrollDirection: Axis.horizontal,
                              viewportFraction: 0.65,
                              onPageChanged: (index, reason) {
                                _currentIndex = index;
                                setState(() {});
                              },
                            ),
                            items: _bestOffers
                                .map(
                                  (item) => Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  flex: 6,
                                                  child: Text(
                                                    item.product.productName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.045),
                                                  ),
                                                ),
                                                Image(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  image: NetworkImage(
                                                      item.storePictureURL),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.18,
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 6,
                                                  child: Image(
                                                    alignment: Alignment.center,
                                                    image: NetworkImage(item
                                                        .product.productImage),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.10,
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          top: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.04),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "€${item.oldprice.toStringAsFixed(2)}",
                                                            style: TextStyle(
                                                                decoration:
                                                                    TextDecoration
                                                                        .lineThrough,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.04),
                                                          ),
                                                          Text(
                                                            "€${item.price.toStringAsFixed(2)}",
                                                            style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.06,
                                                                color:
                                                                    ShoppyColors
                                                                        .red),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        _bestOffers.isNotEmpty
                            ? DotsIndicator(
                                dotsCount: _bestOffers.length,
                                position: _currentIndex.toDouble(),
                                decorator: DotsDecorator(
                                  color:
                                      const Color.fromARGB(101, 255, 255, 255),
                                  activeColor: ShoppyColors.gray,
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Column(
                    children: [
                      TextButton(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Supermarkets ",
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const StoresScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.085,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: _supermarkets.map((s) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      const StoresScreen()), //will normaly take you to the supermarket's page
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 5, right: 5),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(s.storeImage)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: -2,
                                      blurRadius: 7,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8.0)),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Column(
                    children: [
                      TextButton(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Categories ",
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CategoriesScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 20.0,
                    ),
                    itemCount: _categories.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap:
                                () {}, // Image tapped, takes you to category screen
                            child: Image.network(
                              _categories.elementAt(index).categoryImage,
                              fit: BoxFit.cover, // Fixes border issues
                              width: 110.0,
                              height: 110.0,
                            ),
                          ),
                          Text(
                            _categories.elementAt(index).categoryName,
                            style: const TextStyle(
                              fontSize: 20,
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
      ),
    );
  }
}
