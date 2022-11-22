import 'Subcategory.dart';
import 'Offer.dart';

class Category {
  int categoryID;
  String categoryName;
  String categoryImage;
  List<Subcategory> categorySubcategories;
  List<Offer> categoryOffers;

  Category(this.categoryID, this.categoryName, this.categoryImage,
      this.categorySubcategories, this.categoryOffers);
}
