import 'Product.dart';

class Offer {
  int offerID;
  Product product;
  double price;
  double oldprice;
  int storeID;
  String storeName;
  String storePictureURL;

  Offer(this.offerID, this.product, this.price, this.oldprice, this.storeID, this.storeName, this.storePictureURL);
}
