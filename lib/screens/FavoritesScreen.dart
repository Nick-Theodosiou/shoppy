import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shoppy/DataController.dart';
import '../models/Store.dart';
import '../styles/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/models/Product.dart';

import 'CategoriesScreen.dart';
import 'StoresScreen.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Product> _likedList = localUser.likedProduct;
  List<Store> favoriteSupermarkets = localUser.likedStores;

  void _onRefresh() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      favoriteSupermarkets = localUser.likedStores;
      _likedList = localUser.likedProduct;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      favoriteSupermarkets = localUser.likedStores;
      _likedList = localUser.likedProduct;
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            primary: false,
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 10, right: 10, bottom: 10),
              child: Column(
                children: [
                  supermarketsBTN(),
                  if (favoriteSupermarkets.isNotEmpty)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      height: MediaQuery.of(context).size.height * 0.085,
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: favoriteSupermarkets.map((s) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
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
                                child: CachedNetworkImage(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  imageUrl: s.storeImage,
                                  imageBuilder: ((context, imageProvider) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image:
                                                  NetworkImage(s.storeImage)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: -2,
                                              blurRadius: 7,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Align(
                                          alignment: const Alignment(1.4, -5.9),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                removeFromLikedStores(s);
                                              });
                                            },
                                            icon: Icon(
                                              Icons.favorite,
                                              color: ShoppyColors.red,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                            ),
                                          ),
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  if (favoriteSupermarkets.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: TextButton(
                        child: Align(
                          alignment: const Alignment(0, -2),
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Add some stores to your favorites! ",
                                  style: TextStyle(
                                      fontSize: 16, color: ShoppyColors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const StoresScreen()),
                          );
                        },
                      ),
                    ),
                  productsBTN(),
                  if (_likedList.isNotEmpty)
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: _likedList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              color: Colors.white,
                              elevation: 5.0,
                              child: Stack(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18.0, right: 18),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              _likedList[index].productImage,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,

                                              // fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.45,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        RichText(
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          //richtext maxlines 1
                                                          text: TextSpan(
                                                            text:
                                                                '${_likedList[index].productName}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        (_likedList[index]
                                                                    .brand !=
                                                                '')
                                                            ? RichText(
                                                                maxLines: 1,
                                                                text: TextSpan(
                                                                    text:
                                                                        '${_likedList[index].brand}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blueGrey
                                                                            .shade800,
                                                                        fontSize:
                                                                            MediaQuery.of(context).size.height *
                                                                                0.018)),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              )
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, left: 0),
                                            child: SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    removeFromLikedProducts(
                                                        _likedList[index]);
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: ShoppyColors.red,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.06,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  if (_likedList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                      child: TextButton(
                        child: Align(
                          alignment: const Alignment(0, -2),
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Add some products to your favorites! ",
                                  style: TextStyle(
                                      fontSize: 16, color: ShoppyColors.blue),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const CategoriesScreen()),
                          );
                        },
                      ),
                    ),
                ],
              ),
            )),
      ),
    );
  }
}

TextButton supermarketsBTN() {
  return TextButton(
    child: Align(
      alignment: Alignment.topLeft,
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Favourite Supermarkets",
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
    onPressed: () {},
  );
}

TextButton productsBTN() {
  return TextButton(
    child: Align(
      alignment: Alignment.topLeft,
      child: RichText(
        softWrap: true,
        text: TextSpan(
          children: [
            TextSpan(
              text: "Favourite Products",
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
    onPressed: () {},
  );
}
