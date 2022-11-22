import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shoppy/models/ItemOffer.dart';
import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Product.dart';
import 'package:shoppy/models/Store.dart';

import 'models/User.dart';

User localUser = User(-1, "name", "surname", "email", [], [], []);

var settings = ConnectionSettings(
    host: '45.84.205.255',
    port: 3306,
    user: 'u274018054_admin',
    password: 'Test123@!',
    db: 'u274018054_testDB');

Future<bool> checkCredentials(String email, String password) async {
  var conn = await MySqlConnection.connect(settings);

  var results =
      await conn.query('SELECT CheckLogInDetails(?, ?)', [email, password]);

  if (results.first[0] == 0) return false;
  return true;
}

Future<User> getAccountDataDB(String email) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL getUserDetailsByEmail(?);', [email]);

  conn.close();

  List<ItemStore> shoppingList = [];

  conn = await MySqlConnection.connect(settings);

  var results0 =
      await conn.query('CALL getStoresInList(?);', [results.first["UserID"]]);

  for (var row in results0) {
    ItemStore ist = ItemStore(
        Store(
            row["SupermarketID"],
            row["Name"],
            "https://ldiony011873.files.wordpress.com/2022/11/" +
                row["PictureURL"],
            []),
        false,
        []);
    shoppingList.add(ist);
  }

  conn.close();

  conn = await MySqlConnection.connect(settings);

  var results1 =
      await conn.query('CALL getShoppingList(?);', [results.first["UserID"]]);

  conn.close();

  for (var row in results1) {
    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"] ?? "",
        row["SubcategoryID"],
        row["CategoryID"], []);

    Offer o = Offer(
        row["OfferID"], p, row["Price"], row["OldPrice"], row["SupermarketID"]);
    ItemOffer ioff = ItemOffer(o, false, row["Quantity"]);

    for (var ist in shoppingList) {
      if (ist.store.storeID == ioff.offer.storeID) {
        ist.itemOffers.add(ioff);
      }
    }
  }

  List<Product> likedProducts = [];

  conn = await MySqlConnection.connect(settings);

  var results3 =
      await conn.query('CALL getLikedProducts(?);', [results.first["UserID"]]);

  conn.close();

  for (var row in results3) {
    conn = await MySqlConnection.connect(settings);

    var results2 = await conn.query('CALL getTags(?);', [row["ProductID"]]);

    conn.close();

    List<String> tags = [];

    for (var row1 in results2) {
      tags.add(row1["Tags"]);
    }

    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"],
        row["SubcategoryID"],
        row["CategoryID"],
        tags);
    likedProducts.add(p);
  }

  List<Store> likedStores = [];

  conn = await MySqlConnection.connect(settings);

  var results4 =
      await conn.query('CALL getLikedStores(?);', [results.first["UserID"]]);

  conn.close();

  for (var row in results4) {
    Store s = Store(
        row["SupermarketID"],
        row["Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        []);
    likedStores.add(s);
  }

  var user = User(
      results.first["UserID"],
      results.first["Name"],
      results.first["Surname"],
      email,
      shoppingList,
      likedProducts,
      likedStores);
  localUser = user;
  return user;
}
