//TODO micheldr Utiliser clés
import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';
import 'package:smooth_app/query/product_query.dart';

List<ProductRawDataCategory> getProductRawDatas(final Product product) {
  final List<ProductRawDataCategory> toReturn = <ProductRawDataCategory>[];

  final language = getLanguage();

  addRawDataInList(
      toReturn, "LaBeLs", product.labelsTagsInLanguages?[language]);

  addRawDataInList(
      toReturn, "CaTeGoRy", product.categoriesTagsInLanguages?[language]);

  /*addRawDataInList(
      toReturn, "PaCkAgInGs", product.packagingTextInLanguages?[language]);*/

  addRawDataInList(
      toReturn, "CoUnTrIeS", product.countriesTagsInLanguages?[language]);

  return toReturn;
}

void addRawDataInList(List<ProductRawDataCategory> toBeFilled,
    String categoryName, List<String>? toAdd) {
  if (toAdd != null) {
    toBeFilled.add(
        ProductRawDataCategory(categoryName, getProductRawDataElements(toAdd)));
  }
}

List<ProductRawDataElement> getProductRawDataElements(List<String> elements) =>
    elements.map((element) => ProductRawDataElement(element)).toList();

@protected
OpenFoodFactsLanguage getLanguage() => ProductQuery.getLanguage();
