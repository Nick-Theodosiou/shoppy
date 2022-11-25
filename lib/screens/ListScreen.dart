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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0.0, right: 8, left: 8),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
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
                                                                  Radius
                                                                      .circular(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 18.0),
                                                  child: RichText(
                                                    maxLines: 10,
                                                    text: TextSpan(
                                                      text:
                                                          '${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                                      style: TextStyle(
                                                          color: Colors.blueGrey
                                                              .shade800,
                                                          fontSize: 16.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 12.0),
                                              child: IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    deleteOfferFromList(
                                                        indexS, index);

                                                    _shoppingList =
                                                        localUser.itemsInCart;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: ShoppyColors.blue,
                                                  size: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.08,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0),
                                              child: Image.network(
                                                _shoppingList[indexS]
                                                    .itemOffers[index]
                                                    .offer
                                                    .product
                                                    .productImage,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                fit: BoxFit.fitWidth,
                                              ),
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
                                                    Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: RichText(
                                                        maxLines: 10,
                                                        text:
                                                            TextSpan(children: [
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
                                                                          18.0))
                                                              : const TextSpan(),
                                                          TextSpan(
                                                            text:
                                                                'Qty: ${_shoppingList[indexS].itemOffers[index].quantity}\n',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 18.0),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                '€${_shoppingList[indexS].itemOffers[index].offer.price}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .blueGrey
                                                                    .shade800,
                                                                fontSize: 18.0),
                                                          )
                                                        ]),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              children: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
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
                                                            const EdgeInsets
                                                                    .only(
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
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      updateQtyList(
                                                          indexS, index, -1);

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
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 5.0,
                                                                top: 5.0),
                                                        child: Icon(
                                                          Icons.remove,
                                                          color: Colors.white,
                                                          size: 30,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
                  width: MediaQuery.of(context).size.width * 0.92,
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
                        Text('€' + getTotal().toString(),
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
