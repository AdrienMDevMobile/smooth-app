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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(category.name),
      Container(
        margin: const EdgeInsets.only(left: 90.0),
        child: ListView.separated(
            controller: controller,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            separatorBuilder: (context, index) => Divider(color: Colors.black),
            itemCount: category.rawDatas.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductRawDataElementView(category.rawDatas[index]);
            }),
      )
    ]);
  }
}

class ProductRawDataElementView extends StatelessWidget {
  const ProductRawDataElementView(this.element, {this.controller});

  final ProductRawDataElement element;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Text(element.name);
  }
}
