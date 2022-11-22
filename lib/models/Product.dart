class Product {
  int productId;
  String productName;
  String productImage;
  String brand;
  int subcategoryID;
  int categoryID;
  List<String> tags;

  Product(this.productId, this.productName, this.productImage, this.brand,
      this.subcategoryID, this.categoryID, this.tags);
}
