import 'package:flutter/widgets.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';

class ProductRawDataElementItem extends StatelessWidget {
  const ProductRawDataElementItem(this.element, this.onSeeMoreTap,
      {this.controller});

  final ProductRawDataSubCategory element;
  final ScrollController? controller;
  final Function() onSeeMoreTap;

  @override
  Widget build(BuildContext context) {
    if (element is ProductRawDataElement) {
      return Text((element as ProductRawDataElement).name);
    } else {
      return GestureDetector(
          onTap: () => onSeeMoreTap(),
          child: const Text("VoIr PlUs")); //TODO Internationalisation
    }
  }
}
