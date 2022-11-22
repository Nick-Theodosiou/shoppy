import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/models/User.dart';
import 'package:shoppy/styles/colors.dart';

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
              color: ShoppyColors.gray,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.network(
                        _shoppingList[indexS].store.storeImage,
                        height: 30,
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
                      return Card(
                        color: ShoppyColors.gray,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Row(
                            children: [
                              Checkbox(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                value: _shoppingList[indexS].isChecked ||
                                    _shoppingList[indexS]
                                        .itemOffers[index]
                                        .isChecked,
                                onChanged: (v) {
                                  setState(() {
                                    print(indexS);
                                    _shoppingList[indexS]
                                        .itemOffers[index]
                                        .isChecked = v!;
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
                                width: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          text:
                                              'Name: ${_shoppingList[indexS].itemOffers[index].offer.product.productName}\n',
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade800,
                                              fontSize: 16.0),
                                          children: const [
                                            TextSpan(
                                                text: 'ProductName\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                    RichText(
                                      maxLines: 10,
                                      text: TextSpan(
                                          text:
                                              'Unit: ${_shoppingList[indexS].itemOffers[index].quantity}\n',
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade800,
                                              fontSize: 16.0),
                                          children: [
                                            TextSpan(
                                                text:
                                                    'Brand: ${_shoppingList[indexS].itemOffers[index].offer.product.brand}\n',
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                    RichText(
                                      maxLines: 10,
                                      text: TextSpan(
                                          text:
                                              'Price: ${_shoppingList[indexS].itemOffers[index].offer.price}'
                                              r"€",
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade800,
                                              fontSize: 16.0),
                                          children: const [
                                            TextSpan(
                                                text: 'ProductPrice\n',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
