import 'package:shoppy/models/Offer.dart';

import 'Offer.dart';

class Store {
  int storeID;
  String storeName;
  String storeImage;
  List<String> storeLocations;

  Store(this.storeID, this.storeName, this.storeImage, this.storeLocations);
}
