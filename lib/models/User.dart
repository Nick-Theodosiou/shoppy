import 'package:shoppy/models/ItemStore.dart';
import 'package:shoppy/models/Product.dart';
import 'package:shoppy/models/Store.dart';

class User {
  int userID;
  String name;
  String surname;
  String email;
  List<ItemStore> itemsInCart;
  List<Store> likedStores;
  List<Product> likedProduct;

  User(this.userID, this.name, this.surname, this.email, this.itemsInCart,
      this.likedProduct, this.likedStores);
}
