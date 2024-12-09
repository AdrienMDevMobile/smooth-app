sealed class ProductRawDataSubCategory {}

class ProductRawDataElement extends ProductRawDataSubCategory {
  ProductRawDataElement(this.name);

  final String name;
}

class ProductRawDataSeeMoreButton extends ProductRawDataSubCategory {}
