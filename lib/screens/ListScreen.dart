import 'package:flutter/material.dart';
import 'package:shoppy/styles/colors.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  List<bool> stores = List.filled(2, false);
  List<List<bool>> offers = List.filled(2, List.filled(2, false));
  var imgURL =
      "data:image/png;base64,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";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (BuildContext context, int indexS) {
          return Card(
            color: ShoppyColors.gray,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                        height: 30,
                        width: 80,
                        image: AssetImage("asset/images/background_1.png")
                        //  image: AssetImage(products[index].image.toString()),
                        ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: Row(
                        children: [
                          Checkbox(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0))),
                            value: stores[indexS],
                            onChanged: (v) {
                              setState(() {
                                stores[indexS] = v!;
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
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                  shrinkWrap: true,
                  //itemCount: products.length,
                  itemCount: 2,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                              value: stores[indexS] ||
                                  offers[indexS].toList()[index],
                              onChanged: (v) {
                                setState(() {
                                  print(indexS);
                                  offers[indexS].toList()[index] = v!;
                                });
                              },
                            ),
                            const Image(
                                height: 80,
                                width: 80,
                                image:
                                    AssetImage("asset/images/background_1.png")
                                //  image: AssetImage(products[index].image.toString()),
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
                                        text: 'Name: ',
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade800,
                                            fontSize: 16.0),
                                        children: const [
                                          TextSpan(
                                              text: 'ProductName\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                        text: 'Unit: ',
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade800,
                                            fontSize: 16.0),
                                        children: const [
                                          TextSpan(
                                              text: 'Brand\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ]),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                        text: 'Price: ' r"$",
                                        style: TextStyle(
                                            color: Colors.blueGrey.shade800,
                                            fontSize: 16.0),
                                        children: const [
                                          TextSpan(
                                              text: 'ProductPrice\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
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
    );
  }
}
