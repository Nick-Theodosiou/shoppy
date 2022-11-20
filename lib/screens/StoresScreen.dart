import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shoppy/styles/colors.dart';

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
    'https:encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYByPO5YKv2ls4DlQOWvEtpRVLHpLAKrUoVH8keqJX&s',
    'data:image/png;base64,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',
    'data:image/png;base64,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',
    'data:image/png;base64,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',
    'data:image/png;base64,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',
  ];

  List<Color> iconColors = <Color>[];
  Widget build(BuildContext context) {
    createIconColorList();
    return Scaffold(
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
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  //bottom:MediaQuery.of(context).size.height * 0.05
                ),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: ShoppyColors.gray,
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
