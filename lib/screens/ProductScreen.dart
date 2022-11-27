import 'package:flutter/material.dart';
import 'package:shoppy/models/Offer.dart';

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
  final Offer product;
  const ProductScreen({super.key, required this.product});

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  Offer product;
  _ProductScreenState(this.product);
  int _amount = 1;

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
                        image: NetworkImage(product.product.productImage),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Image(
                        height: MediaQuery.of(context).size.height * 0.05,
                        image: NetworkImage(product.storePictureURL),
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
                      product.product.productName,
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
                                    if (_amount > 1) _amount--;
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
                                "€${product.oldprice.toStringAsFixed(2)}",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.06,
                                    color: Colors.grey[500]),
                              ),
                              Text(
                                "€${product.price.toStringAsFixed(2)}",
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ShoppyColors.red,
                        minimumSize: const Size.fromHeight(47),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Add to Cart',
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
                              WidgetSpan(
                                child: Icon(
                                  Icons.arrow_right_alt,
                                  size: 25,
                                  color: ShoppyColors.blue,
                                ),
                              ),
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
                      itemCount: placeholder.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap:
                                  () {}, // Image tapped, takes you to similar product screen
                              child: Image.asset('asset/images/shoppyIcon.png'),
                            ),
                            Text(
                              placeholder.elementAt(index).name,
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
