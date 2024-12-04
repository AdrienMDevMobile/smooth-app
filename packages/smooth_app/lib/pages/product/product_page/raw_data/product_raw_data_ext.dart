import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:smooth_app/pages/product/attribute_first_row_helper.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';
import 'package:smooth_app/query/product_query.dart';
import 'package:smooth_app/resources/app_icons.dart';
import 'package:smooth_app/resources/app_icons.dart' as icons;

//ICI faire les derniers elements
extension RawDataExt on Product {
  List<ProductRawDataCategory> toRawDatas() {
    final List<ProductRawDataCategory> toReturn = <ProductRawDataCategory>[];

    final OpenFoodFactsLanguage language = _getLanguage();

    _addRawDataInList(toReturn, ProductRawDataCategoryLabel.labels,
        const icons.Labels(), labelsTagsInLanguages?[language]);

    _addRawDataInList(toReturn, ProductRawDataCategoryLabel.category,
        const icons.Categories(), categoriesTagsInLanguages?[language]);

    _addRawDataInList(
        toReturn,
        ProductRawDataCategoryLabel.ingredients,
        const icons.Ingredients(),
        _splitString(ingredientsTextInLanguages?[language]));

    _addRawDataInList(
        toReturn,
        ProductRawDataCategoryLabel.nutriment,
        const icons.NutritionFacts(),
        AttributeFirstRowNutritionHelper(product: this)
            .getAllTerms()
            .map((StringPair pair) => "${pair.first} ${pair.second}")
            .toList());

    _addRawDataInList(toReturn, ProductRawDataCategoryLabel.packaging,
        const icons.Packaging(), _splitString(packaging));

    _addRawDataInList(toReturn, ProductRawDataCategoryLabel.stores,
        const icons.Stores(), _splitString(stores));

    _addRawDataInList(toReturn, ProductRawDataCategoryLabel.countries,
        const icons.Countries(), countriesTagsInLanguages?[language]);

    return toReturn;
  }

  void _addRawDataInList(List<ProductRawDataCategory> toBeFilled,
      ProductRawDataCategoryLabel label, AppIcon icon, List<String>? toAdd) {
    if (toAdd != null) {
      toBeFilled.add(ProductRawDataCategory(label, icon, toAdd._toRawData()));
    }
  }

  @protected
  OpenFoodFactsLanguage _getLanguage() => ProductQuery.getLanguage();
}

extension _ProductRawDataElementExt on List<String> {
  List<ProductRawDataElement> _toRawData() =>
      map((String element) => ProductRawDataElement(element)).toList();
}

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
