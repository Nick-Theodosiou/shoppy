import 'ItemOffer.dart';
import 'Store.dart';

class ItemStore {
  Store store;
  bool isChecked;
  List<ItemOffer> itemOffers;

  ItemStore(this.store, this.isChecked, this.itemOffers);
}
