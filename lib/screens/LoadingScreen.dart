import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoppy/DataController.dart';
import 'package:shoppy/NavigationBarScreen.dart';

import '../LoginScreen.dart';
import '../models/User.dart';

class LoadingScreen extends StatefulWidget {
  final String email;

  const LoadingScreen(this.email);

  @override
  _LoadingScreenState createState() => _LoadingScreenState(email);
}

class _LoadingScreenState extends State<LoadingScreen> {
  final String email;

  _LoadingScreenState(this.email);

  bool _loading = true;

  getData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    User u = await getAccountDataDB(email);
    DCbestOffers = await getBestDeals(10);
    DCcategories = await getCategories();
    DCsupermarkets = await getStores();
    return u.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationBarScreen();
          } else if (snapshot.hasError) {
            return Container(
              child: Text("Error"),
            ); //Error getting data
          } else {
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("asset/images/background_1.png"),
                    fit: BoxFit.cover),
              ),
              child: const Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ); //show Loading
          }
        },
      ),
    );
  }
}
