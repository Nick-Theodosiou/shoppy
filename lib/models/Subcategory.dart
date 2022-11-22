import 'Offer.dart';

class Subcategory {
  int subcategoryID;
  String subcategoryName;
  String subcategoryImage;
  List<Offer> subcategoryOffers;

  Subcategory(this.subcategoryID, this.subcategoryName, this.subcategoryImage,
      this.subcategoryOffers);
}
