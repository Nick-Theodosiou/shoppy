import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Store.dart';
import 'package:shoppy/models/Subcategory.dart';

import '../models/User.dart';
import '../styles/colors.dart';
import 'ProductScreen.dart';
import 'StoreSearch.dart';

class StoreScreen extends StatefulWidget {
  final Store store;
  // ignore: non_constant_identifier_names
  const StoreScreen({super.key, required this.store});

  @override
  State<StoreScreen> createState() => _StoreScreennState(store);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _StoreScreennState extends State<StoreScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Offer> storeOffers = <Offer>[];
  Store store;
  _StoreScreennState(Store this.store);
  void _onRefresh() async {
    var offers = await getOffersByStore(store);
    setState(() {
      storeOffers = offers;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var offers = await getOffersByStore(store);
    setState(() {
      storeOffers = offers;
    });
    _refreshController.loadComplete();
  }

  User user = localUser;
  @override
  Widget build(BuildContext context) {
    // Rember to check it
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        title: Text(
          this.store.storeName,
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
                const EdgeInsets.only(top: 17, left: 10, right: 10, bottom: 10),
            child: Column(
              children: [
                TextFormField(
                  onFieldSubmitted: (value) async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => StoreSearch(
                                string: value.toString(),
                                store: store,
                              )),
                    );
                    setState(() {
                      user = localUser;
                    });
                  },
                  style: TextStyle(color: ShoppyColors.blue),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: ShoppyColors.blue,
                    contentPadding:
                        const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                    fillColor: const Color.fromARGB(108, 225, 225, 225),
                    filled: true,
                    hintStyle:
                        TextStyle(color: ShoppyColors.blue, fontSize: 20),
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
                sortAndFilter(),
                ListView.builder(
                    padding: EdgeInsets.zero,
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: storeOffers.length,
                    //itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    ProductScreen(offer: storeOffers[index])),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 8, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 30,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: (user.likedProduct.any(
                                                  ((element) =>
                                                      element.productId ==
                                                      storeOffers[index]
                                                          .product
                                                          .productId))
                                              ? ShoppyColors.red
                                              : ShoppyColors.blue),
                                          //color: Color(0xFFE86969),
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            if ((user.likedProduct.any(
                                                ((element) =>
                                                    element.productId ==
                                                    storeOffers[index]
                                                        .product
                                                        .productId)))) {
                                              ShoppyColors.blue;
                                              removeFromLikedProducts(
                                                  storeOffers[index].product);
                                            } else {
                                              ShoppyColors.red;
                                              addToLikedProducts(
                                                  storeOffers[index].product);
                                            }
                                          });
                                          // Favorite Supermarket /Unfavorite Supermarket
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.01,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        storeOffers[index].product.productImage,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.16,
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0250,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                storeOffers[index]
                                                    .product
                                                    .productName,
                                                style: TextStyle(
                                                    color: ShoppyColors.blue,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold
                                                    //fontWeight: FontWeight.w400
                                                    ),
                                              ),
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.004,
                                              ),
                                              if (storeOffers[index]
                                                      .product
                                                      .brand !=
                                                  '')
                                                Text(
                                                  //textAlign:TextAlign.left,
                                                  storeOffers[index]
                                                      .product
                                                      .brand,
                                                  style: TextStyle(
                                                      color: ShoppyColors.blue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                )
                                              else
                                                (Text(
                                                  //textAlign:TextAlign.left,
                                                  'Unbranded',
                                                  style: TextStyle(
                                                      color: ShoppyColors.blue,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w300),
                                                ))
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
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0150,
                                          //left: MediaQuery.of(context).size.height * 0.01,
                                        ),
                                        child: Column(
                                          children: [
                                            Image.network(
                                              storeOffers[index]
                                                  .storePictureURL,
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
                                              "€${storeOffers[index].price.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
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
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Padding sortAndFilter() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
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
