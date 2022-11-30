import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/models/Offer.dart';

import '../models/User.dart';
import '../styles/colors.dart';
import 'ProductScreen.dart';

class CategorySearch extends StatefulWidget {
  final Category category;
  final String string;
  // ignore: non_constant_identifier_names
  const CategorySearch(
      {super.key, required this.category, required this.string});

  @override
  State<CategorySearch> createState() => _CategorySearchState(category, string);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _CategorySearchState extends State<CategorySearch> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  Category category;
  String string;
  List<Offer> offers = [];
  _CategorySearchState(this.category, this.string);

  void _onRefresh() async {
    List<Offer> tempoffers = await searchOffersInCategory(string, category);
    setState(() {
      offers = tempoffers;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    List<Offer> tempoffers = await searchOffersInCategory(string, category);
    setState(() {
      offers = tempoffers;
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
      appBar: AppBar(
        title: Text(
          "Searched for: $string",
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
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.01,
            bottom: MediaQuery.of(context).size.height * 0.003,
          ),
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
        padding: const EdgeInsets.fromLTRB(7, 5, 5, 5),
        child: Row(children: [
          TextButton.icon(
            // <-- TextButton
            onPressed: () {},
            icon: Icon(
              Icons.sort,
              size: 24.0,
              color: ShoppyColors.blue,
            ),
            label: const Text('Sort'),
            style: TextButton.styleFrom(
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
              size: 24.0,
              color: ShoppyColors.blue,
            ),
            style: TextButton.styleFrom(
              foregroundColor: ShoppyColors.blue, // Text Color
            ),
          ),
        ]));
  }

  TextFormField searchBar() {
    return TextFormField(
      onFieldSubmitted: (value) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => CategorySearch(
                    string: value.toString(),
                    category: category,
                  )),
        );
      },
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
    );
  }

  ListView listOfOffers() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: offers.length,
        //itemCount: cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ProductScreen(offer: offers[index])),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height * 0.00,
                  left: MediaQuery.of(context).size.width * 0.03,
                  right: MediaQuery.of(context).size.width * 0.03,
                  bottom: MediaQuery.of(context).size.height * 0.01),
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
                                      offers[index].product.productId))
                                  ? ShoppyColors.red
                                  : ShoppyColors.blue),
                              size: 20,
                            ),
                            onPressed: () {
                              setState(() {
                                if ((user.likedProduct.any(((element) =>
                                    element.productId ==
                                    offers[index].product.productId)))) {
                                  ShoppyColors.blue;
                                  removeFromLikedProducts(
                                      offers[index].product);
                                } else {
                                  ShoppyColors.red;
                                  addToLikedProducts(offers[index].product);
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
                            offers[index].product.productImage,
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
                                    offers[index].product.productName,
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
                                    offers[index].product.brand,
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
                                  category
                                      .categoryOffers[index].storePictureURL,
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
                                  "€${offers[index].price.toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
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
        });
  }
}
