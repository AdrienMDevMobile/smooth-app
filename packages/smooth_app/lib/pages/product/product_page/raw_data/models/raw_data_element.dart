sealed class ProductRawDataSubCategory {}

class ProductRawDataElement extends ProductRawDataSubCategory {
  ProductRawDataElement(this.name);

  final String name;
}

class ProductRawDataSeeMore extends ProductRawDataSubCategory {}
