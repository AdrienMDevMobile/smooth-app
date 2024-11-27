import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';
import 'package:smooth_app/resources/app_icons.dart';

class ProductRawDataCategory {
  const ProductRawDataCategory(this.label, this.icon, this.rawDatas);

  final ProductRawDataCategoryLabel label;
  final AppIcon icon;
  final List<ProductRawDataElement> rawDatas;
}

enum ProductRawDataCategoryLabel { labels, category, countries }
