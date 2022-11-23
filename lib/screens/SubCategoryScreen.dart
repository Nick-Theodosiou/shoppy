import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Subcategory.dart';
import 'package:shoppy/screens/BestDealsScreen.dart';
import 'package:shoppy/screens/CategoriesScreen.dart';

import '../NavigationBarScreen.dart';
import '../styles/colors.dart';

class SubCategoryScreen extends StatefulWidget {
  final Subcategory subcategory;
  // ignore: non_constant_identifier_names
  const SubCategoryScreen({super.key, required this.subcategory});

  @override
  State<SubCategoryScreen> createState() => _SubCategoryScreennState(subcategory);
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class _SubCategoryScreennState extends State<SubCategoryScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Offer> subcategoryOffers = [];
  //List<String> ProductImage = <String>[];
  //List<String> ProductName = <String>[];
  Subcategory subcategory;
  _SubCategoryScreennState(Subcategory this.subcategory);
  void _onRefresh() async {
    var offers = await getOffersBySubcategory(subcategory);
    setState(() {
      subcategoryOffers = offers;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var offers = await getOffersBySubcategory(subcategory);
    setState(() {
      subcategoryOffers = offers;
    });
    _refreshController.loadComplete();
  }
  //getLists(ProductImage, ProductName, subname);
  //// User user = localUser;
  //bool _notificationsEnabled = true;

  // void _updateNotifications(bool notifications) {
  //   _notificationsEnabled = notifications;
  // }
  //List<String> product = <String>[];
  @override
  Widget build(BuildContext context) {
    //getLists(ProductImage, ProductName, subname);
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context, true);
            //SaveChanges(iconColors);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const NavigationBarScreen()));
          },
        ),
        title: Text(
          this.subcategory.subcategoryName,
          style: TextStyle(
            color: ShoppyColors.gray,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
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
          child: ListView.builder(
              padding: EdgeInsets.zero,
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: subcategoryOffers.length,
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
                            subcategoryOffers[index].product.productImage,
                            //cartItems[index].image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            // NamesofSM[index],
                           subcategoryOffers[index].product.productName,
                            style: TextStyle(
                                color: ShoppyColors.blue,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Image.network(
                            subcategoryOffers[index].storePictureURL,
                            //cartItems[index].image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitWidth,
                          ),
                          // IconButton(
                          //   icon: Icon(
                          //     Icons.favorite,
                          //     color: iconColors[index],
                          //     //color: Color(0xFFE86969),
                          //     size: 20,
                          //   ),
                          //   onPressed: () {
                          //     setState(() {
                          //       if (iconColors[index] == ShoppyColors.blue)
                          //         iconColors[index] = ShoppyColors.red;
                          //       else
                          //         iconColors[index] = ShoppyColors.blue;
                          //     });
                          //     // Favorite Supermarket /Unfavorite Supermarket
                          //   },
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

// void getLists(List<String> image, List<String> Name, String Subname) {
//   if (Subname == 'Nicolas') {
//     for (int i = 0; i < 3; i++) {
//       image.add('https://nicolastheodosiou.pages.dev/images/prof.png');
//       Name.add('Nicolas');
//     }
//   } else if (Subname == 'Banana') {
//     for (int i = 0; i < 3; i++) {
//       image.add(
//           'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Banana-Single.jpg/800px-Banana-Single.jpg');
//       Name.add('Banana');
//     }
//   }
// }
