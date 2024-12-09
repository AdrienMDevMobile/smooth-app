import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smooth_app/pages/product/attribute_first_row_helper.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';
import 'package:smooth_app/query/product_query.dart';

extension RawDataExt on Product {
  List<ProductRawDataCategory> toRawDatas() {
    final List<ProductRawDataCategory> toReturn = <ProductRawDataCategory>[];

    final OpenFoodFactsLanguage language = _getLanguage();

    _addRawDataInList(toReturn, ProductRawDataCategories.labels,
        labelsTagsInLanguages?[language]);

    _addRawDataInList(toReturn, ProductRawDataCategories.category,
        categoriesTagsInLanguages?[language]);

    _addRawDataInList(toReturn, ProductRawDataCategories.ingredients,
        _splitString(ingredientsTextInLanguages?[language]));

    // TODO(micheldr): Change presentation into two Textfields instead of concatenation.
    _addRawDataInList(
        toReturn,
        ProductRawDataCategories.nutriment,
        AttributeFirstRowNutritionHelper(product: this)
            .getAllTerms()
            .map((StringPair pair) => '${pair.first} ${pair.second}')
            .toList());

    _addRawDataInList(
        toReturn, ProductRawDataCategories.packaging, _splitString(packaging));

    _addRawDataInList(
        toReturn, ProductRawDataCategories.stores, _splitString(stores));

    _addRawDataInList(toReturn, ProductRawDataCategories.countries,
        countriesTagsInLanguages?[language]);

    return toReturn;
  }

  void _addRawDataInList(List<ProductRawDataCategory> toBeFilled,
      ProductRawDataCategories label, List<String>? toAdd) {
    if (toAdd != null) {
      toBeFilled.add(ProductRawDataCategory(label, _toRawData(toAdd)));
    }
  }

  List<ProductRawDataElement> _toRawData(List<String> list) =>
      list.map((String element) => ProductRawDataElement(element)).toList();

  List<String>? _splitString(String? input) {
    if (input == null) {
      return null;
    }
    input = input.trim();
    if (input.isEmpty) {
      return null;
    }
    return input.split(',');
  }

  @protected
  OpenFoodFactsLanguage _getLanguage() => ProductQuery.getLanguage();
}
