import 'package:flutter/material.dart';
import 'package:shoppy/DataController.dart';
import '../styles/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/models/Product.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Product> _likedList = localUser.likedProduct;

  void _onRefresh() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      _likedList = localUser.likedProduct;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      _likedList = localUser.likedProduct;
    });

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, right: 6, left: 6),
        child: Stack(
          children: <Widget>[
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: const WaterDropHeader(),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Favourite Products',
                        style: TextStyle(
                            color: ShoppyColors.blue,
                            fontSize:
                                MediaQuery.of(context).size.height * 0.03),
                      )),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: _likedList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.10,
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
                                                  width: MediaQuery.of(context)
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
                                                                      fontSize: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.02)),
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
                                                    .width *
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
