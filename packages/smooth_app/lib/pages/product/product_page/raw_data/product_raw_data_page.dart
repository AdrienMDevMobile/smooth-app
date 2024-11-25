import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_category_view.dart';

import 'get_product_raw_datas_ext.dart';

class ProductRawDataPage extends StatefulWidget {
  const ProductRawDataPage(this.product);

  final Product product;

  @override
  State<StatefulWidget> createState() => ProductRawDataPageState();
}

class ProductRawDataPageState extends State<ProductRawDataPage> {
  @override
  Widget build(BuildContext context) {
    print("micheldr aaaa");
    //return Scaffold(body: Text('micheldr text'));
    return Scaffold(
        appBar: AppBar(title: Text("AdrienMICHEL")),
        body: ProductRawDataList(widget.product),
        backgroundColor: Color.fromARGB(255, 101, 18, 18));
  }
}

class ProductRawDataList extends StatelessWidget {
  const ProductRawDataList(this.product, {this.controller});

  final Product product;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    final List<ProductRawDataCategory> productRawDatas =
        getProductRawDatas(product);
    return ListView.separated(
      itemCount: productRawDatas.length,
      separatorBuilder: (context, index) => Divider(color: Colors.black),
      itemBuilder: (_, int index) {
        //return Text("micheldr list ${index}");
        return ProductRawDataCategoryView(productRawDatas[index]);
      },
    );
  }
}
