import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/styles/colors.dart';

import 'ProductScreen.dart';

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

  getTotalS(int indexS) {
    var total = 0.0;
    for (var j = 0; j < _shoppingList[indexS].itemOffers.length; j++)
      if (!_shoppingList[indexS].itemOffers[j].isChecked)
        total += _shoppingList[indexS].itemOffers[j].offer.price *
            _shoppingList[indexS].itemOffers[j].quantity;
    return total * 1.0;
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
              enablePullUp: false,
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
                                    MediaQuery.of(context).size.width * 0.11,
                              ),
                            ),
                            //  image: AssetImage(products[index].image.toString()),

                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Row(
                                children: [
                                  Checkbox(
                                    activeColor:
                                        Color.fromARGB(255, 93, 184, 97),
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
                              padding: const EdgeInsets.only(bottom: 0.0),
                              child: Container(
                                // height:
                                //     MediaQuery.of(context).size.height * 0.12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    const BoxShadow(
                                      blurRadius: 4,
                                      color: Color.fromARGB(47, 139, 139, 139),
                                      offset: Offset(0, 0),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Stack(
                                    children: <Widget>[
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
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        ProductScreen(
                                                            offer:
                                                                _shoppingList[
                                                                        indexS]
                                                                    .itemOffers[
                                                                        index]
                                                                    .offer)),
                                              );
                                              setState(() {
                                                _shoppingList =
                                                    localUser.itemsInCart;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 0),
                                              child: ClipRRect(
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
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => ProductScreen(
                                                                      offer: _shoppingList[
                                                                              indexS]
                                                                          .itemOffers[
                                                                              index]
                                                                          .offer)),
                                                            );
                                                            setState(() {
                                                              _shoppingList =
                                                                  localUser
                                                                      .itemsInCart;
                                                            });
                                                          },
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.50,
                                                            child: RichText(
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              maxLines: 1,
                                                              //richtext maxlines 1
                                                              text: TextSpan(
                                                                text: _shoppingList[
                                                                        indexS]
                                                                    .itemOffers[
                                                                        index]
                                                                    .offer
                                                                    .product
                                                                    .productName,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .blueGrey
                                                                        .shade800,
                                                                    fontSize:
                                                                        17.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.09,
                                                          // child: IconButton(
                                                          //   onPressed: () {
                                                          //     setState(() {
                                                          //       deleteOfferFromList(
                                                          //           indexS,
                                                          //           index);

                                                          //       _shoppingList =
                                                          //           localUser
                                                          //               .itemsInCart;
                                                          //     });
                                                          //   },
                                                          //   icon: Icon(
                                                          //     Icons.delete,
                                                          //     color:
                                                          //         ShoppyColors
                                                          //             .blue,
                                                          //     size: MediaQuery.of(
                                                          //                 context)
                                                          //             .size
                                                          //             .width *
                                                          //         0.06,
                                                          //   ),
                                                          // ),
                                                        ),
                                                      ]),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.58,
                                                  child: SizedBox(
                                                    height: 55,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => ProductScreen(
                                                                      offer: _shoppingList[
                                                                              indexS]
                                                                          .itemOffers[
                                                                              index]
                                                                          .offer)),
                                                            );
                                                            setState(() {
                                                              _shoppingList =
                                                                  localUser
                                                                      .itemsInCart;
                                                            });
                                                          },
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              (_shoppingList[indexS]
                                                                          .itemOffers[
                                                                              index]
                                                                          .offer
                                                                          .product
                                                                          .brand !=
                                                                      '')
                                                                  ? SizedBox(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.3,
                                                                      child:
                                                                          RichText(
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        text:
                                                                            TextSpan(
                                                                          text: _shoppingList[indexS]
                                                                              .itemOffers[index]
                                                                              .offer
                                                                              .product
                                                                              .brand,
                                                                          style: TextStyle(
                                                                              color: Colors.blueGrey.shade800,
                                                                              fontSize: 16.0),
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      child:
                                                                          Text(
                                                                        "Unbranded",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.blueGrey.shade800,
                                                                            fontSize: 16.0),
                                                                      ),
                                                                    ),
                                                              Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child:
                                                                    Container(
                                                                  child: Text(
                                                                    '€${_shoppingList[indexS].itemOffers[index].offer.price.toStringAsFixed(2)}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .blueGrey
                                                                            .shade800,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 0.0,
                                                                  left: 0),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.25,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              ShoppyColors.red),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            updateQtyList(
                                                                                indexS,
                                                                                index,
                                                                                -1);

                                                                            _shoppingList =
                                                                                localUser.itemsInCart;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove,
                                                                          color:
                                                                              Colors.white,
                                                                          size: MediaQuery.of(context).size.width *
                                                                              0.06,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              3.0,
                                                                          right:
                                                                              3),
                                                                      child:
                                                                          RichText(
                                                                        maxLines:
                                                                            1,
                                                                        text:
                                                                            TextSpan(
                                                                          text: _shoppingList[indexS]
                                                                              .itemOffers[index]
                                                                              .quantity
                                                                              .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.blueGrey.shade800,
                                                                            fontSize:
                                                                                MediaQuery.of(context).size.width * 0.055,
                                                                          ),
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              ShoppyColors.red),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            updateQtyList(
                                                                                indexS,
                                                                                index,
                                                                                1);

                                                                            _shoppingList =
                                                                                localUser.itemsInCart;
                                                                          });
                                                                        },
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.white,
                                                                          size: MediaQuery.of(context).size.width *
                                                                              0.06,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Positioned.fill(
                                        child: (_shoppingList[indexS]
                                                    .itemOffers[index]
                                                    .isChecked ||
                                                _shoppingList[indexS].isChecked)
                                            ? Material(
                                                elevation: 0,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                color: Colors.transparent,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                            166, 187, 187, 187)
                                                        .withOpacity(0.5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0),
                                            child: Checkbox(
                                              activeColor: Color.fromARGB(
                                                  255, 93, 184, 97),
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20.0))),
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
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.09,
                                            child: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  deleteOfferFromList(
                                                      indexS, index);

                                                  _shoppingList =
                                                      localUser.itemsInCart;
                                                });
                                              },
                                              icon: (!_shoppingList[indexS]
                                                      .itemOffers[index]
                                                      .isChecked)
                                                  ? Icon(
                                                      Icons.delete,
                                                      color: ShoppyColors.blue,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.06,
                                                    )
                                                  : Icon(
                                                      Icons
                                                          .highlight_remove_rounded,
                                                      color: Colors.grey[700],
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.07,
                                                    ),
                                            ),
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
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, bottom: 10, top: 4),
                            child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                text: 'Subtotal: €' +
                                    getTotalS(indexS).toStringAsFixed(2),
                                style: TextStyle(
                                  color: ShoppyColors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
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
