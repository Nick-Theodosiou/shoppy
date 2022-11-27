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

  getTotal() {
    var total = 0.0;
    for (var i = 0; i < _shoppingList.length; i++)
      for (var j = 0; j < _shoppingList[i].itemOffers.length; j++)
        if (!_shoppingList[i].itemOffers[j].isChecked)
          total += _shoppingList[i].itemOffers[j].offer.price *
              _shoppingList[i].itemOffers[j].quantity;
    return total * 1.0;
  }

  double getPaddingCheckbox(int1, int2) {
    if (_shoppingList[int1].itemOffers[int2].offer.product.brand != '')
      return 12;
    return 12;
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
              child: ListView.builder(
                shrinkWrap: true,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 4.0),
                              child: Image.network(
                                _shoppingList[indexS].store.storeImage,
                                height:
                                    MediaQuery.of(context).size.width * 0.12,
                              ),
                            ),
                            //  image: AssetImage(products[index].image.toString()),

                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                children: [
                                  Checkbox(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0))),
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
                              vertical: 2.0, horizontal: 0.0),
                          shrinkWrap: true,
                          itemCount: _shoppingList[indexS].itemOffers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 1.0),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 4,
                                      color: Color(0x320E151B),
                                      offset: Offset(0, 1),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30)),
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Stack(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.04,
                                            // child: Checkbox(
                                            //   shape:
                                            //       const RoundedRectangleBorder(
                                            //           borderRadius:
                                            //               BorderRadius.all(
                                            //                   Radius.circular(
                                            //                       20.0))),
                                            //   value: _shoppingList[indexS]
                                            //       .itemOffers[index]
                                            //       .isChecked,
                                            //   onChanged: (v) {
                                            //     setState(() {
                                            //       //print(indexS);
                                            //       _shoppingList[indexS]
                                            //           .itemOffers[index]
                                            //           .isChecked = v!;
                                            //       if (v! == false) {
                                            //         _shoppingList[indexS]
                                            //             .isChecked = false;
                                            //       }
                                            //     });
                                            //   },
                                            // ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              _shoppingList[indexS]
                                                  .itemOffers[index]
                                                  .offer
                                                  .product
                                                  .productImage,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.16,

                                              // fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.30,
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
                                                              '${_shoppingList[indexS].itemOffers[index].offer.product.productName}',
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
                                                      (_shoppingList[indexS]
                                                                  .itemOffers[
                                                                      index]
                                                                  .offer
                                                                  .product
                                                                  .brand !=
                                                              '')
                                                          ? RichText(
                                                              maxLines: 1,
                                                              text: TextSpan(
                                                                  text:
                                                                      '${_shoppingList[indexS].itemOffers[index].offer.product.brand}',
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
                                                      RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                          text:
                                                              'Qty: ${_shoppingList[indexS].itemOffers[index].quantity}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade800,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          text:
                                                              '€${_shoppingList[indexS].itemOffers[index].offer.price}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade800,
                                                              fontSize: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.02),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // Column(
                                          //   children: [
                                          // RichText(
                                          //   maxLines: 10,
                                          // text: TextSpan(
                                          //   text:
                                          //       '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                          //   style: TextStyle(
                                          //       color: Colors.blueGrey
                                          //           .shade800,
                                          //       fontSize: 16.0,
                                          //       fontWeight:
                                          //           FontWeight.bold),
                                          // ),
                                          //   overflow:
                                          //       TextOverflow.ellipsis,
                                          // ),
                                          //   ],
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, left: 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.00,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        deleteOfferFromList(
                                                            indexS, index);

                                                        _shoppingList =
                                                            localUser
                                                                .itemsInCart;
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: ShoppyColors.blue,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.2,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: ShoppyColors
                                                                .red),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              updateQtyList(
                                                                  indexS,
                                                                  index,
                                                                  1);

                                                              _shoppingList =
                                                                  localUser
                                                                      .itemsInCart;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                        ),
                                                      ),
                                                      RichText(
                                                        maxLines: 1,
                                                        text: TextSpan(
                                                          text:
                                                              '${_shoppingList[indexS].itemOffers[index].quantity}',
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueGrey
                                                                .shade800,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                        ),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: ShoppyColors
                                                                .red),
                                                        child: InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              updateQtyList(
                                                                  indexS,
                                                                  index,
                                                                  -1);

                                                              _shoppingList =
                                                                  localUser
                                                                      .itemsInCart;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.white,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // IconButton(
                                                //   onPressed: () {
                                                //   setState(() {
                                                //     deleteOfferFromList(
                                                //         indexS, index);

                                                //     _shoppingList =
                                                //         localUser.itemsInCart;
                                                //   });
                                                // },
                                                //   icon: Icon(
                                                //     Icons.delete,
                                                //     color: ShoppyColors.blue,
                                                //     size: MediaQuery.of(context)
                                                //             .size
                                                //             .width *
                                                //         0.08,
                                                //   ),
                                                // ),
                                                // ElevatedButton(
                                                //   style: ElevatedButton.styleFrom(
                                                //     elevation: 0,
                                                //     backgroundColor:
                                                //         Colors.transparent,
                                                //   ),
                                                //   onPressed: () {
                                                // setState(() {
                                                //   updateQtyList(indexS, index, 1);

                                                //   _shoppingList =
                                                //       localUser.itemsInCart;
                                                // });
                                                //   },
                                                //   child: Stack(
                                                //     children: [
                                                //       Icon(
                                                //         Icons.circle,
                                                //         color: ShoppyColors.red,
                                                //         size: 40,
                                                //       ),
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets.only(
                                                //                 left: 5.0, top: 5.0),
                                                //         child: Icon(
                                                //           Icons.add,
                                                //           color: Colors.white,
                                                //           size: 30,
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                // ElevatedButton(
                                                //   style: ElevatedButton.styleFrom(
                                                //     elevation: 0,
                                                //     backgroundColor:
                                                //         Colors.transparent,
                                                //   ),
                                                //   onPressed: () {
                                                //     setState(() {
                                                //       updateQtyList(
                                                //           indexS, index, -1);

                                                //       _shoppingList =
                                                //           localUser.itemsInCart;
                                                //     });
                                                //   },
                                                //   child: Stack(
                                                //     children: [
                                                //       Icon(
                                                //         Icons.circle,
                                                //         color: ShoppyColors.red,
                                                //         size: 40,
                                                //       ),
                                                //       Padding(
                                                //         padding:
                                                //             const EdgeInsets.only(
                                                //                 left: 5.0, top: 5.0),
                                                //         child: Icon(
                                                //           Icons.remove,
                                                //           color: Colors.white,
                                                //           size: 30,
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      (_shoppingList[indexS]
                                                  .itemOffers[index]
                                                  .isChecked ||
                                              _shoppingList[indexS].isChecked)
                                          ? Material(
                                              elevation: 0,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.transparent,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  // backgroundBlendMode:
                                                  //     BlendMode.color,

                                                  color: Color.fromARGB(
                                                          255, 187, 187, 187)
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1075,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.93,
                                                // child: SizedBox(width: ,),
                                              ),
                                            )
                                          : Container(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: getPaddingCheckbox(
                                                indexS, index),
                                            left: 11),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.08,
                                          child: Checkbox(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0))),
                                            value: _shoppingList[indexS]
                                                .itemOffers[index]
                                                .isChecked,
                                            onChanged: (v) {
                                              setState(() {
                                                //print(indexS);
                                                _shoppingList[indexS]
                                                    .itemOffers[index]
                                                    .isChecked = v!;
                                                if (v == false) {
                                                  _shoppingList[indexS]
                                                      .isChecked = false;
                                                }
                                              });
                                            },
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
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.93,
                  decoration: BoxDecoration(
                    color: ShoppyColors.blue,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x320E151B),
                        offset: Offset(5, 5),
                      )
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                        Text('€' + getTotal().toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 25, color: Colors.white))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
