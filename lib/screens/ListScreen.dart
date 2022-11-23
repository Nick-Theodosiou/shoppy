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
      body: Padding(
        padding: const EdgeInsets.only(bottom: 18.0, right: 10, left: 10),
        child: Stack(
          children: <Widget>[
            SmartRefresher(
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
                              height: MediaQuery.of(context).size.width * 0.12,
                            ),
                            //  image: AssetImage(products[index].image.toString()),

                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Row(
                                children: [
                                  Checkbox(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
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
                              vertical: 10.0, horizontal: 0.0),
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
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0))),
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
                                                      _shoppingList[indexS]
                                                          .isChecked = false;
                                                    }
                                                  });
                                                },
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 18.0),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text:
                                                        '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .blueGrey.shade800,
                                                        fontSize: 16.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.transparent,
                                                elevation: 0),
                                            onPressed: () {
                                              setState(() {
                                                deleteOfferFromList(
                                                    indexS, index);

                                                _shoppingList =
                                                    localUser.itemsInCart;
                                              });
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: ShoppyColors.blue,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            _shoppingList[indexS]
                                                .itemOffers[index]
                                                .offer
                                                .product
                                                .productImage,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.25,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.35,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 5.0,
                                                  ),
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
                                                          // TextSpan(
                                                          //   text:
                                                          //       '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                                          //   style: TextStyle(
                                                          //       color: Colors
                                                          //           .blueGrey
                                                          //           .shade800,
                                                          //       fontSize: 16.0,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .bold),
                                                          // ),
                                                          (_shoppingList[indexS]
                                                                      .itemOffers[
                                                                          index]
                                                                      .offer
                                                                      .product
                                                                      .brand !=
                                                                  '')
                                                              ? TextSpan(
                                                                  text:
                                                                      '${_shoppingList[indexS].itemOffers[index].offer.product.brand}\n',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .blueGrey
                                                                          .shade800,
                                                                      fontSize:
                                                                          16.0))
                                                              : const TextSpan(),
                                                          TextSpan(
                                                            text:
                                                                'Qty: ${_shoppingList[indexS].itemOffers[index].quantity}\n',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '€${_shoppingList[indexS].itemOffers[index].offer.price}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 16.0),
                                                          )
                                                        ]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    updateQtyList(
                                                        indexS, index, 1);

                                                    _shoppingList =
                                                        localUser.itemsInCart;
                                                  });
                                                },
                                                child: Stack(
                                                  children: [
                                                    Icon(
                                                      Icons.circle,
                                                      color: ShoppyColors.red,
                                                      size: 40,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5.0,
                                                              top: 5.0),
                                                      child: Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 30,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      updateQtyList(
                                                          indexS, index, -1);

                                                      _shoppingList =
                                                          localUser.itemsInCart;
                                                    });
                                                  },
                                                  child: const Icon(
                                                      Icons.arrow_downward))
                                            ],
                                          )
                                        ],
                                      ),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Row(
                  // mainAxisAlignment: ,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Total',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: ShoppyColors.blue,
                    border: Border.all(color: ShoppyColors.blue, width: 1),
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
