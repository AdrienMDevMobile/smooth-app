import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_element_view.dart';
import 'package:smooth_app/themes/color_schemes.dart';

import 'models/product_raw_data_category.dart';
import 'package:flutter/widgets.dart';

import 'models/raw_data_element.dart';

typedef Extended = bool;

class ProductRawDataCategoryView extends StatelessWidget {
  const ProductRawDataCategoryView(this.category, {this.controller});

  final ProductRawDataCategory category;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(category.name),
      _CategoryListView(elements: category.rawDatas),
    ]);
  }
}

class _CategoryListView extends StatefulWidget {
  _CategoryListView({required this.elements});

  final List<ProductRawDataSubCategory> elements;

  @override
  State<StatefulWidget> createState() => _CategoryListViewState();
}

class _CategoryListViewState<T extends _CategoryListView> extends State<T> {
  bool extended = false;

  void extendList() {
    setState(() {
      extended = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<ProductRawDataSubCategory> listToShow;
    if (extended) {
      listToShow = widget.elements;
    } else {
      listToShow = _takeElementsSublist(widget.elements);
    }
    return Container(
      margin: const EdgeInsets.only(left: 90.0),
      child: ListView.separated(
          //TODO controller: widget.controller,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: Colors.black),
          itemCount: listToShow.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductRawDataElementView(
                listToShow[index], () => extendList());
          }),
    );
  }

  final int _subListLength = 3;

  List<ProductRawDataSubCategory> _takeElementsSublist(
      List<ProductRawDataSubCategory> list) {
    if (list.length > _subListLength) {
      final sublist = <ProductRawDataSubCategory>[];
      sublist.addAll(widget.elements.sublist(0, _subListLength));
      sublist.add(ProductRawDataSeeMore());
      return sublist;
    } else {
      return list;
    }
  }
}
