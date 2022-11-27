import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/models/Store.dart';
import 'package:shoppy/styles/colors.dart';

import '../NavigationBarScreen.dart';
import 'HomeScreen.dart';


class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});
  @override
  _StoresScreenState createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  @override
  final RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  List<Store> Stores = [];

  void _onRefresh() async {
    var stores = await getStores();
    setState(() {
      Stores = stores;
    });
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    var stores = await getStores();
    setState(() {
      Stores = stores;
    });
    _refreshController.loadComplete();
  }

  static List<Color> iconColors = <Color>[];
  //set to static to show when the DB ready we will request the liked Supermarkets
  //static  List<Color> LastState =<Color>[];

  Widget build(BuildContext context) {
    if (iconColors.isEmpty) {
      createIconColorList();
    }
    return Scaffold(
      backgroundColor: ShoppyColors.gray,
      appBar: AppBar(
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
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: SingleChildScrollView(
          child: ListView.builder(

              padding: EdgeInsets.only(
                top: 10
              ),
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: Stores.length,
              //itemCount: cartItems.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                   left: 10,
                  right: 10,
                  bottom: 10,
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
                            Stores[index].storeImage,
                            //cartItems[index].image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.fitWidth,
                          ),
                          Text(
                            Stores[index].storeName,
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
      ),
    );
  }

  void createIconColorList() {
    int length = Stores.length;
    for (var i = 0; i < length; i++) {
      iconColors.add(ShoppyColors.blue);
    }
  }
//   SaveChanges(List StateC )
// {
// for(int i=0 ;i<StateC.length;i++) {
//   LastState[i]=StateC[i];
// }
// }
// List GetState(List LastState){
//   if(LastState.length>0) {
//     return LastState;
//   } else
//   return new List<Color>;
// }
}


// ignore: avoid_types_as_parameter_names, non_constant_identifier_names