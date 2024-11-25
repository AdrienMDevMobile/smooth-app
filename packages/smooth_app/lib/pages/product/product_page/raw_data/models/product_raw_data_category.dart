import 'raw_data_element.dart';

class ProductRawDataCategory {
  const ProductRawDataCategory(this.name, this.rawDatas);

  final String name;
  final List<ProductRawDataElement> rawDatas;
}
