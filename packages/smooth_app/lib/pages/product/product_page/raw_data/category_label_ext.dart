import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';

extension CategoryLabelExt on ProductRawDataCategoryLabel {
  String toL10nString(AppLocalizations appLocalizations) => switch (this) {
        ProductRawDataCategoryLabel.labels => appLocalizations.label_refresh,
        ProductRawDataCategoryLabel.category => appLocalizations.category,
        ProductRawDataCategoryLabel.ingredients => appLocalizations.ingredients,
        ProductRawDataCategoryLabel.countries =>
          appLocalizations.country_chooser_label_from_settings,
        ProductRawDataCategoryLabel.nutriment => appLocalizations.nutrition,
        ProductRawDataCategoryLabel.packaging =>
          appLocalizations.packaging_information,
        ProductRawDataCategoryLabel.stores =>
          appLocalizations.edit_product_form_item_stores_title,
      };
}
