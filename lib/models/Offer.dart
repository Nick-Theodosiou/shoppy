import 'dart:ffi';

import 'Product.dart';

class Offer {
  int offerID;
  Product product;
  double price;
  double oldprice;
  int storeID;

  Offer(this.offerID, this.product, this.price, this.oldprice, this.storeID);
}
