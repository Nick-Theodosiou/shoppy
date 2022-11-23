import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:shoppy/models/ItemOffer.dart';
import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/models/Offer.dart';
import 'package:shoppy/models/Product.dart';
import 'package:shoppy/models/Store.dart';
import 'package:shoppy/models/Category.dart';
import 'package:shoppy/models/Subcategory.dart';

import 'models/User.dart';

User localUser = User(-1, "name", "surname", "email", [], [], []);
List<Offer> DCbestOffers = [];
List<Store> DCsupermarkets = [];
List<Category> DCcategories = [];

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

  await conn.close();

  if (results.first[0] == 0) return false;
  return true;
}

Future<User> getAccountDataDB(String email) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL getUserDetailsByEmail(?);', [email]);

  List<ItemStore> shoppingList = [];

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

  var results1 =
      await conn.query('CALL getShoppingList(?);', [results.first["UserID"]]);

  for (var row in results1) {
    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"] ?? "",
        row["SubcategoryID"],
        row["CategoryID"], []);

    Offer o = Offer(
        row["OfferID"],
        p,
        row["Price"],
        row["OldPrice"],
        row["SupermarketID"],
        row["Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" +
            row["StorePictureURL"]);
    ItemOffer ioff = ItemOffer(o, false, row["Quantity"]);

    for (var ist in shoppingList) {
      if (ist.store.storeID == ioff.offer.storeID) {
        ist.itemOffers.add(ioff);
      }
    }
  }

  List<Product> likedProducts = [];

  var results3 =
      await conn.query('CALL getLikedProducts(?);', [results.first["UserID"]]);

  for (var row in results3) {
    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"],
        row["SubcategoryID"],
        row["CategoryID"], []);
    likedProducts.add(p);
  }

  List<Store> likedStores = [];

  var results4 =
      await conn.query('CALL getLikedStores(?);', [results.first["UserID"]]);

  await conn.close();

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

Future<List<Offer>> getBestDeals(int size) async {
  var conn = await MySqlConnection.connect(settings);

  List<Offer> list = [];

  var results = await conn.query('CALL getBestDeals();');

  await conn.close();

  for (var row in results) {
    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"] ?? "",
        row["SubcategoryID"],
        row["CategoryID"], []);

    Offer o = Offer(
        row["OfferID"],
        p,
        row["Price"],
        row["OldPrice"],
        row["SupermarketID"],
        row["Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" +
            row["StorePictureURL"]);

    list.add(o);
  }

  return list;
}

Future<void> deleteAccount() async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL deleteAccount(?);', [localUser.userID]);

  await conn.close();
}

Future<void> deleteFavoriteProduct(int productID) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn
      .query('CALL deleteFavoriteProduct(?,?);', [localUser.userID, productID]);

  await conn.close();
}

Future<void> deleteFavoriteStore(int storeID) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn
      .query('CALL deleteFavoriteStore(?,?);', [localUser.userID, storeID]);

  await conn.close();
}

Future<void> deleteShoppingList(int offerID) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn
      .query('CALL deleteShoppingList(?);', [localUser.userID, offerID]);

  await conn.close();
}

Future<List<Category>> getCategories() async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL getCategories();');

  await conn.close();
  List<Category> list = [];
  List<Subcategory> p = [];
  List<Offer> p2 = [];

  for (var row in results) {
    Category C = Category(
        row['CategoryID'],
        row['Name'],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row['PictureURL'],
        p,
        p2);
    list.add(C);
  }
  return list;
}

Future<List<Subcategory>> getSubcategoriesByCategory(Category C) async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL getSubcategories(?);', [C.categoryID]);

  await conn.close();
  List<Subcategory> list = [];

  for (var row in results) {
    Subcategory S = Subcategory(
        row['SubcategoryID'],
        row['Name'],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row['PictureURL'],
        []);
    list.add(S);
  }
  return list;
}

Future<List<Offer>> getOffersBySubcategory(Subcategory C) async {
  var conn = await MySqlConnection.connect(settings);

  var results =
      await conn.query('CALL getSubcategoryOffers(?);', [C.subcategoryID]);

  await conn.close();
  List<Offer> list = [];

  for (var row in results) {
    Product p = Product(
        row["ProductID"],
        row["Product_Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row["PictureURL"],
        row["Brand"] ?? "",
        row["SubcategoryID"],
        row["CategoryID"], []);

    Offer o = Offer(
        row["OfferID"],
        p,
        row["Price"],
        row["OldPrice"],
        row["SupermarketID"],
        row["Name"],
        "https://ldiony011873.files.wordpress.com/2022/11/" +
            row["StorePictureURL"]);

    list.add(o);
  }
  return list;
}

// Subcategory(this.subcategoryID, this.subcategoryName, this.subcategoryImage,
//     this.subcategoryOffers);

void deleteOfferFromList(int indexS, int index) async {
  int offerID = localUser.itemsInCart[indexS].itemOffers[index].offer.offerID;

  localUser.itemsInCart[indexS].itemOffers.removeAt(index);
  if (localUser.itemsInCart[indexS].itemOffers.isEmpty) {
    localUser.itemsInCart.removeAt(indexS);
  }

  var conn = await MySqlConnection.connect(settings);

  var results =
      conn.query('CALL deleteShoppingList(?,?);', [localUser.userID, offerID]);
}

void updateQtyList(int indexS, int index, int change) async {
  int offerID = localUser.itemsInCart[indexS].itemOffers[index].offer.offerID;
  int qty = localUser.itemsInCart[indexS].itemOffers[index].quantity + change;

  localUser.itemsInCart[indexS].itemOffers[index].quantity = qty;
  if (localUser.itemsInCart[indexS].itemOffers[index].quantity == 0) {
    localUser.itemsInCart[indexS].itemOffers.removeAt(index);
    if (localUser.itemsInCart[indexS].itemOffers.isEmpty) {
      localUser.itemsInCart.removeAt(indexS);
    }
  }

  var conn = await MySqlConnection.connect(settings);
  if (qty > 0) {
    conn.query('CALL updateQty(?,?,?);', [localUser.userID, offerID, qty]);
  } else {
    conn.query('CALL deleteShoppingList(?,?);', [localUser.userID, offerID]);
  }
}

Future<List<Store>> getStores() async {
  var conn = await MySqlConnection.connect(settings);

  var results = await conn.query('CALL getStores();');

  await conn.close();
  List<Store> list = [];
  List<String> test = [];

  for (var row in results) {
    Store S = Store(
        row['SupermarketID'],
        row['Name'],
        "https://ldiony011873.files.wordpress.com/2022/11/" + row['PictureURL'],
        test);
    list.add(S);
  }

  return list;
}
