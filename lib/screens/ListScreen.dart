import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/models/User.dart';
import 'package:shoppy/styles/colors.dart';
import 'dart:ffi';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<ItemStore> _shoppingList = localUser.itemsInCart;

  void _onRefresh() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      _shoppingList = localUser.itemsInCart;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await getAccountDataDB(localUser.email);
    setState(() {
      _shoppingList = localUser.itemsInCart;
    });

    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemCount: _shoppingList.length,
          itemBuilder: (BuildContext context, int indexS) {
            return Card(
              elevation: 0,
              color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        _shoppingList[indexS].store.storeImage,
                        height: 50,
                        width: 80,
                      ),
                      //  image: AssetImage(products[index].image.toString()),

                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Row(
                          children: [
                            Checkbox(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              value: _shoppingList[indexS].isChecked,
                              onChanged: (v) {
                                setState(() {
                                  for (var i = 0;
                                      i <
                                          _shoppingList[indexS]
                                              .itemOffers
                                              .length;
                                      i++) {
                                    _shoppingList[indexS]
                                        .itemOffers[i]
                                        .isChecked = v!;
                                  }

                                  _shoppingList[indexS].isChecked = v!;
                                });
                              },
                            ),
                            const Text("Check All")
                          ],
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 8.0),
                    shrinkWrap: true,
                    //itemCount: products.length,
                    itemCount: _shoppingList[indexS].itemOffers.length,
                    itemBuilder: (BuildContext context, int index) {
                      //List<bool> offers = List.filled(2, false);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 2.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 5.0,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Row(
                              children: [
                                Checkbox(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  value: _shoppingList[indexS]
                                      .itemOffers[index]
                                      .isChecked,
                                  onChanged: (v) {
                                    setState(() {
                                      print(indexS);
                                      _shoppingList[indexS]
                                          .itemOffers[index]
                                          .isChecked = v!;
                                      if (v! == false) {
                                        _shoppingList[indexS].isChecked = false;
                                      }
                                    });
                                  },
                                ),
                                Image.network(
                                  _shoppingList[indexS]
                                      .itemOffers[index]
                                      .offer
                                      .product
                                      .productImage,
                                  height: 30,
                                  width: 80,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 5.0,
                                      ),
                                      // RichText(
                                      //   //overflow: TextOverflow.ellipsis,
                                      //   //maxLines: 1,
                                      //   text: TextSpan(
                                      //       text:
                                      //           '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                      //       style: TextStyle(
                                      //           color: Colors.blueGrey.shade800,
                                      //           fontSize: 16.0),
                                      //       children: const [
                                      //         TextSpan(
                                      //             text: 'ProductName\n',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold)),
                                      //       ]),
                                      // ),
                                      RichText(
                                        maxLines: 10,
                                        text: TextSpan(
                                            // text:
                                            //     'Qty: ${_shoppingList[indexS].itemOffers[index].quantity}\n',
                                            // style: TextStyle(
                                            //     color:
                                            //         Colors.blueGrey.shade800,
                                            //     fontSize: 16.0),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              (_shoppingList[indexS]
                                                          .itemOffers[index]
                                                          .offer
                                                          .product
                                                          .brand !=
                                                      '')
                                                  ? TextSpan(
                                                      text:
                                                          '${_shoppingList[indexS].itemOffers[index].offer.product.brand}\n',
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade800,
                                                          fontSize: 16.0))
                                                  : const TextSpan(),
                                              TextSpan(
                                                text:
                                                    'Qty: ${_shoppingList[indexS].itemOffers[index].quantity}\n',
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 16.0),
                                              ),
                                              TextSpan(
                                                text:
                                                    '€${_shoppingList[indexS].itemOffers[index].offer.price}',
                                                style: TextStyle(
                                                    color: Colors
                                                        .blueGrey.shade800,
                                                    fontSize: 16.0),
                                              )
                                            ]),
                                      ),
                                      // RichText(
                                      //   maxLines: 10,
                                      //   text: TextSpan(
                                      //       text:
                                      //           'Price: ${_shoppingList[indexS].itemOffers[index].offer.price}'
                                      //           r"€",
                                      //       style: TextStyle(
                                      //           color:
                                      //               Colors.blueGrey.shade800,
                                      //           fontSize: 16.0),
                                      //       children: const [

                                      //         TextSpan(
                                      //             text: 'ProductPrice\n',
                                      //             style: TextStyle(
                                      //                 fontWeight:
                                      //                     FontWeight.bold)),
                                      //       ]),
                                      // ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          deleteOfferFromList(indexS, index);

                                          _shoppingList = localUser.itemsInCart;
                                        });
                                      },
                                      child: const Icon(Icons.delete),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          updateQtyList(indexS, index, 1);

                                          _shoppingList = localUser.itemsInCart;
                                        });
                                      },
                                      child: const Icon(Icons.arrow_upward),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            updateQtyList(indexS, index, -1);

                                            _shoppingList =
                                                localUser.itemsInCart;
                                          });
                                        },
                                        child: const Icon(Icons.arrow_downward))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    // children: [
                    //   Padding(
                    //     padding: const EdgeInsets.only(top: 40),
                    //     child: Row(
                    //       children: [
                    //         Image.network(
                    //           imgURL,
                    //           height: 30,
                    //           alignment: Alignment.topLeft,
                    //         ),
                    //         Padding(
                    //           padding: const EdgeInsets.only(left: 40),
                    //           child: Checkbox(
                    //             shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    //             value: isChecked,
                    //             onChanged: (v) {
                    //               setState(() {
                    //                 isChecked = v!;
                    //               });
                    //             },
                    //           ),
                    //         ),
                    //         const Text("Check All")
                    //       ],
                    //     ),
                    //   )
                    // ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
