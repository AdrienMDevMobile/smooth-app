import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'models/product_raw_data_category.dart';
import 'package:flutter/widgets.dart';

import 'models/raw_data_element.dart';

class ProductRawDataCategoryView extends StatelessWidget {
  const ProductRawDataCategoryView(this.category, {this.controller});

  final ProductRawDataCategory category;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(category.name),
      ListView.separated(
          controller: controller,
          shrinkWrap: true,
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemCount: category.rawDatas.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductRawDataElementView(category.rawDatas[index]);
          })
    ]);
  }
}

class ProductRawDataElementView extends StatelessWidget {
  const ProductRawDataElementView(this.element, {this.controller});

  final ProductRawDataElement element;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Text("elem" + element.name);
  }
}
