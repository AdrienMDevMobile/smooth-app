import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_category_item.dart';

import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_ext.dart';

class ProductRawDataPage extends StatefulWidget {
  const ProductRawDataPage(this.product);

  final Product product;

  @override
  State<StatefulWidget> createState() => _ProductRawDataPageState();
}

class _ProductRawDataPageState extends State<ProductRawDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("AdrienMICHEL")),
        body: _ProductRawDataList(widget.product),
        backgroundColor: Color.fromARGB(255, 201, 135, 135)); //TODO background
  }
}

class _ProductRawDataList extends StatelessWidget {
  const _ProductRawDataList(this.product, {this.controller});

  final Product product; //???
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final List<ProductRawDataCategory> productRawDatas = product.toRawDatas();
    return ListView.separated(
      itemCount: productRawDatas.length,
      separatorBuilder: (BuildContext context, _) =>
          Divider(color: Colors.black), //Blanc sur dark mode
      itemBuilder: (_, int index) {
        return ProductRawDataCategoryItem(productRawDatas[index]);
      },
    );
  }
}
