import 'dart:js_util';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

List<Offer> bestOffers = [
  Offer(
      'Banana',
      'Farma tou Giorkou',
      'Alfamega',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg',
      '5.20',
      '3.12'),
  Offer(
      'Chocolate Chip Cookies',
      'Papadopoulou',
      'Lidl',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5snKWm8oDkZn9vvQ0fg10Yckm_3yO_DoM0A&usqp=CAU',
      '2.50',
      '1.99'),
  Offer(
      'Neroui Nicolas',
      'Nicolas',
      'Froutaria Nicolas',
      'https://nicolasvahe.com/wp-content/uploads/2021/01/161950100_03.jpg',
      '3.55',
      '0.50')
];

void main() {
  runApp(const HomeScreen());
}

class Offer {
  String name = '',
      brand = '',
      supermarket = '',
      imgUrl = '',
      oldPrice = '',
      newPrice = '';

  Offer(this.name, this.brand, this.supermarket, this.imgUrl, this.oldPrice,
      this.newPrice);
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 20,
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                disableCenter: true,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1,
              ),
              items: bestOffers
                  .map(
                    (item) => Column(
                      children: [
                        Row(
                          children: [
                            Flexible(child: Text(item.name)),
                            Flexible(child: Text(item.supermarket))
                          ],
                        ),
                        Row(
                          children: [
                            Image(
                              image: NetworkImage(item.imgUrl),
                              width: MediaQuery.of(context).size.width * 0.3,
                            ),
                            Column(
                              children: [
                                Text(item.oldPrice),
                                Text(item.newPrice)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                  .toList(),
            )
          ]),
        ),
      ),
    );
  }
}
