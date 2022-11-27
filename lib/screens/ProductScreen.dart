import 'package:flutter/material.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/ItemOffer.dart';
import 'package:shoppy/models/ItemStore.dart';

import '../models/User.dart';
import '../styles/colors.dart';
import 'HomeScreen.dart';

List<p> placeholder = [
  p("Cookies"),
  p("Milk"),
  p("Oranges"),
  p("Chips"),
  p("Pasta"),
  p("Crandberry Juice"),
  p("Toilet Paper"),
  p("Chocolate"),
  p("CHicken"),
];

class p {
  String name;
  p(this.name);
}

class ProductScreen extends StatefulWidget {
  final Offer offer;
  const ProductScreen({super.key, required this.offer});

  @override
  State<ProductScreen> createState() => _ProductScreenState(offer);
}

class _ProductScreenState extends State<ProductScreen> {
  Offer offer;
  _ProductScreenState(this.offer);
  int _amount = 1;
  bool existsInCart = false;
  List<Offer> similarOffers = [];

  @override
  void initState() {
    setState(() {
      existsInCart = localUser.itemsInCart.any((element) => element.itemOffers
          .any((element1) => element1.offer.offerID == offer.offerID));
      if (existsInCart) {
        _amount = localUser.itemsInCart
            .firstWhere((element) => element.store.storeID == offer.storeID)
            .itemOffers
            .firstWhere((element) => element.offer.offerID == offer.offerID)
            .quantity;
      }
    });
    getSimOffers();
    super.initState();
  }

  void getSimOffers() async {
    List<Offer> la = await getSimilarProducts(offer);
    setState(() {
      similarOffers = la;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, top: 30),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                        iconSize: 40,
                        color: ShoppyColors.blue,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 55, top: 55),
                    child: Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: NetworkImage(offer.product.productImage),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.05,
                        image: NetworkImage(offer.storePictureURL),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height * 0.6,
                minWidth: double.infinity,
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25, left: 30, right: 30, bottom: 20),
                child: Column(
                  children: [
                    Text(
                      offer.product.productName,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.085,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.06),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ShoppyColors.red),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_amount > 1 ||
                                        (existsInCart && _amount > 0))
                                      _amount--;
                                  });
                                },
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    vertical:
                                        MediaQuery.of(context).size.height *
                                            0.01),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: Colors.white),
                                child: Text(
                                  _amount.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _amount++;
                                  });
                                },
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).size.width * 0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "€${offer.oldprice.toStringAsFixed(2)}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    color: Colors.grey[500]),
                              ),
                              Text(
                                "€${offer.price.toStringAsFixed(2)}",
                                style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.09,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          addOfferToList(offer, _amount);
                          if (existsInCart && _amount > 0) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "Quantity of ${offer.product.productName} was updated.")));
                          } else if (_amount > 0) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${offer.product.productName} was added to your list.")));
                            existsInCart = true;
                          } else if (existsInCart) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    "${offer.product.productName} was removed from your list.")));
                            existsInCart = false;
                            _amount = 1;
                          }
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ShoppyColors.red,
                        minimumSize: const Size.fromHeight(47),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        existsInCart ? 'Update List' : 'Add to List',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextButton(
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Similar Products ",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: ShoppyColors.blue,
                                    fontWeight: FontWeight.w500),
                              ),
                              // WidgetSpan(
                              //   child: Icon(
                              //     Icons.arrow_right_alt,
                              //     size: 25,
                              //     color: ShoppyColors.blue,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      onPressed:
                          () {}, //will take you to the similar products screen
                    ),
                    GridView.builder(
                      padding: const EdgeInsets.only(top: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: (500 / 650),
                      ),
                      itemCount: similarOffers.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProductScreen(
                                            offer: similarOffers[index])));
                              }, // Image tapped, takes you to similar product screen
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(similarOffers[index]
                                          .product
                                          .productImage),
                                    ),
                                  ),
                                  Image.network(
                                    similarOffers[index].storePictureURL,
                                    width: MediaQuery.of(context).size.width *
                                        0.15,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              similarOffers[index].product.productName,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
