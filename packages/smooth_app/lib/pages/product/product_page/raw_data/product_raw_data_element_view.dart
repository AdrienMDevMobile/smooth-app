import 'package:flutter/widgets.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';

class ProductRawDataElementView extends StatelessWidget {
  const ProductRawDataElementView(this.element, this.onTap, {this.controller});

  final ProductRawDataSubCategory element;
  final ScrollController? controller;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    if (element is ProductRawDataElement) {
      return Text((element as ProductRawDataElement).name);
    } else {
      return GestureDetector(onTap: (() => onTap()), child: Text("VoIr PlUs"));
    }
  }
}
