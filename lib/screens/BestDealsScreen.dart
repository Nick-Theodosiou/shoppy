import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Offer.dart';

import '../models/User.dart';
import '../styles/colors.dart';
import 'ProductScreen.dart';

class BestDealsScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const BestDealsScreen({super.key});

  @override
  State<BestDealsScreen> createState() => _BestDealsScreenState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _BestDealsScreenState extends State<BestDealsScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Offer> bestOffers = <Offer>[];

  void _onRefresh() async {
    List<Offer> temp = await getBestDeals(10);
    setState(() {
      bestOffers = temp;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    List<Offer> temp = await getBestDeals(10);
    setState(() {
      bestOffers = temp;
    });
    _refreshController.loadComplete();
  }

  List<Color> iconColors = <Color>[];
  User user = localUser;

  @override
  Widget build(BuildContext context) {
    //getLists(ProductImage, ProductName, subname);
    // this will be fixed after adding from the database the liked products
    // Rember to check it
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
            child: Padding(
          padding:
              const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
          child: Column(children: [
            searchBar(),
            sortAndFilter(),
            listOfOffers(),
          ]),
        )),
      ),
    );
  }

  Padding sortAndFilter() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
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

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 0),
      child: TextFormField(
        style: TextStyle(color: ShoppyColors.blue),
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          prefixIconColor: ShoppyColors.blue,
          contentPadding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
          fillColor: const Color.fromARGB(108, 225, 225, 225),
          filled: true,
          hintStyle: TextStyle(color: ShoppyColors.blue, fontSize: 20),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide: BorderSide(color: ShoppyColors.blue)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
              borderSide:
                  const BorderSide(color: Color.fromARGB(108, 225, 225, 225))),
          hintText: "Search...",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(35)),
        ),
      ),
    );
  }

  ListView listOfOffers() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: bestOffers.length,
        //itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProductScreen(offer: bestOffers[index])),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.01),
              child: Container(
                width: double.infinity,
                height: 110,
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
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 100,
                        width: 30,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: (user.likedProduct.any(((element) =>
                                      element.productId ==
                                      bestOffers[index].product.productId))
                                  ? ShoppyColors.red
                                  : ShoppyColors.blue),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if ((user.likedProduct.any(((element) =>
                                    element.productId ==
                                    bestOffers[index].product.productId)))) {
                                  ShoppyColors.blue;
                                  removeFromLikedProducts(
                                      bestOffers[index].product);
                                } else {
                                  ShoppyColors.red;
                                  addToLikedProducts(bestOffers[index].product);
                                }
                                // if (iconColors[index] == ShoppyColors.blue)
                                //   iconColors[index] = ShoppyColors.red;
                                // else
                                //   iconColors[index] = ShoppyColors.blue;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            bestOffers[index].product.productImage,
                            width: MediaQuery.of(context).size.width * 0.16,
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
                              top: MediaQuery.of(context).size.height * 0.0250,
                              left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bestOffers[index].product.productName,
                                    style: TextStyle(
                                        color: ShoppyColors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                        //fontWeight: FontWeight.w400
                                        ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.004,
                                  ),
                                  Text(
                                    //textAlign:TextAlign.left,
                                    bestOffers[index].storeName,
                                    style: TextStyle(
                                        color: ShoppyColors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w300),
                                  ),
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
                              top: MediaQuery.of(context).size.height * 0.0150,
                              //left: MediaQuery.of(context).size.height * 0.01,
                            ),
                            child: Column(
                              children: [
                                Image.network(
                                  bestOffers[index].storePictureURL,
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
                                  "€${bestOffers[index].oldprice.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                ),
                                Text(
                                  "€${bestOffers[index].price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.w500,
                                      color: ShoppyColors.red),
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
        });
  }
}
