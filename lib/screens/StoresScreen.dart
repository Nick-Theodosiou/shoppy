import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoppy/styles/colors.dart';

import '../NavigationBarScreen.dart';
import 'HomeScreen.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoresScreenDemo(),
    );
  }
}

class StoresScreenDemo extends StatefulWidget {
  const StoresScreenDemo({super.key});
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreenDemo> {
  @override
  List<String> Supermarkets = [
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Carrefour_logo.svg/1200px-Carrefour_logo.svg.png',
    'https://1000logos.net/wp-content/uploads/2020/03/Lidl-logo.png',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSmommM2orX-K1sWvFJXkg8WsmeYjumQpbA4g&usqp=CAU',
    'https://www.carierista.com/storage/companies/3124/c4cb76fa9c1911456440efba2f6e1c2a.jpg',
    'https://nicolastheodosiou.pages.dev/images/prof.png',
  ];
  List<String> NamesofSM = ['Carrefour', 'Lidl', 'Coles', 'Ioannides', 'TOP G'];
  List<Color> iconColors = <Color>[];
  Widget build(BuildContext context) {
    createIconColorList();
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context, true);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NavigationBarScreen()),
            );
          },
        ),
        title: Text(
          "Supermarkets",
          style: TextStyle(
            color: ShoppyColors.gray,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: ShoppyColors.blue,
      ),
      body: SingleChildScrollView(
        child: ListView.builder(
            padding: EdgeInsets.zero,
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: Supermarkets.length,
            //itemCount: cartItems.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  left: MediaQuery.of(context).size.width * 0.01,
                  right: MediaQuery.of(context).size.width * 0.01,
                  //bottom:MediaQuery.of(context).size.height * 0.05
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
                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          Supermarkets[index],
                          //cartItems[index].image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          NamesofSM[index],
                          style: TextStyle(
                              color: ShoppyColors.blue,
                              fontSize: 20,
                              fontWeight: FontWeight.w400),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: iconColors[index],
                            //color: Color(0xFFE86969),
                            size: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              if (iconColors[index] == ShoppyColors.blue)
                                iconColors[index] = ShoppyColors.red;
                              else
                                iconColors[index] = ShoppyColors.blue;
                            });
                            // Favorite Supermarket /Unfavorite Supermarket
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  void createIconColorList() {
    int length = Supermarkets.length;
    for (var i = 0; i < length; i++) {
      iconColors.add(ShoppyColors.blue);
    }
  }
}
