//import 'dart:js_util';
import 'dart:developer';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoppy/styles/colors.dart';

import 'StoresScreen.dart';

void main() {
  runApp(const HomeScreen());
}

List<Offer> bestOffers = [
  Offer(
      'Banana',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMwuMOpraAIZU_0VSGvKavi6tWOpKFP3AmEQ&usqp=CAU',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg',
      '5.20',
      '3.12'),
  Offer(
      'Chocolate Chip Cookies',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMwuMOpraAIZU_0VSGvKavi6tWOpKFP3AmEQ&usqp=CAU',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg',
      '2.50',
      '1.99'),
  Offer(
      'Neroui Nicolas',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMwuMOpraAIZU_0VSGvKavi6tWOpKFP3AmEQ&usqp=CAU',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg',
      '3.55',
      '0.50')
];

List<Supermarket> supermarkets = [
  Supermarket('Kkolias', 'asset/images/kkolias.png'),
  Supermarket('Lidl',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMwuMOpraAIZU_0VSGvKavi6tWOpKFP3AmEQ&usqp=CAU'),
  Supermarket('Kkolias', 'asset/images/kkolias.png'),
  Supermarket('Lidl',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMwuMOpraAIZU_0VSGvKavi6tWOpKFP3AmEQ&usqp=CAU'),
  Supermarket('Kkolias', 'asset/images/kkolias.png'),
];

class Offer {
  String name = '', supermarket = '', imgUrl = '', oldPrice = '', newPrice = '';
  Offer(this.name, this.supermarket, this.imgUrl, this.oldPrice, this.newPrice);
}

class Supermarket {
  String supermarket = '', imgUrl = '';
  Supermarket(this.supermarket, this.imgUrl);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  var _currentIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                style: TextStyle(color: ShoppyColors.blue),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: ShoppyColors.blue,
                  contentPadding:
                      const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  fillColor: const Color.fromARGB(108, 225, 225, 225),
                  filled: true,
                  hintStyle: TextStyle(color: ShoppyColors.blue),
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  color: ShoppyColors.yellow,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Best Offers ",
                                style: TextStyle(
                                    fontSize: 25, color: ShoppyColors.blue),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: CarouselSlider(
                        options: CarouselOptions(
                          autoPlay: true,
                          height: MediaQuery.of(context).size.height * 0.2,
                          autoPlayInterval: const Duration(seconds: 3),
                          enlargeCenterPage: false,
                          disableCenter: true,
                          scrollDirection: Axis.horizontal,
                          viewportFraction: 0.7,
                          onPageChanged: (index, reason) {
                            _currentIndex = index;
                            setState(() {});
                          },
                        ),
                        items: bestOffers
                            .map(
                              (item) => Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Text(
                                                item.name,
                                                style: TextStyle(
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.05),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Image(
                                                alignment: Alignment.topRight,
                                                image: NetworkImage(
                                                    item.supermarket),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 6,
                                              child: Image(
                                                alignment: Alignment.centerLeft,
                                                image:
                                                    NetworkImage(item.imgUrl),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.10,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "€${item.oldPrice}",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04),
                                                      ),
                                                      Text(
                                                        "€${item.newPrice}",
                                                        style: TextStyle(
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.06,
                                                            color: ShoppyColors
                                                                .red),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: bestOffers.length,
                      position: _currentIndex.toDouble(),
                      decorator: DotsDecorator(
                        color: Colors.grey,
                        activeColor: ShoppyColors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Column(
                children: [
                  TextButton(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: RichText(
                        softWrap: true,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Supermarkets ",
                              style: TextStyle(
                                  fontSize: 25, color: ShoppyColors.blue),
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
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const StoresScreen()),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: supermarkets.map((s) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const StoresScreen()), //will normaly take you to the supermarket's page
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(s.imgUrl)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
