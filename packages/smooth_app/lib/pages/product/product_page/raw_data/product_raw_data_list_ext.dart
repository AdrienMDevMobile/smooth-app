import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';

extension ProductRawDataListExt on List<ProductRawDataSubCategory> {
  static const int _SUB_LIST_LENGTH = 3;

  List<ProductRawDataSubCategory> shortenIfTooLong() {
    if (length > _SUB_LIST_LENGTH) {
      final List<ProductRawDataSubCategory> toReturn =
          <ProductRawDataSubCategory>[];
      toReturn.addAll(sublist(0, _SUB_LIST_LENGTH));
      toReturn.add(ProductRawDataSeeMore());
      return toReturn;
    } else {
      return this;
    }
  }
}
