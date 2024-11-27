import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/category_label_ext.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/product_raw_data_category.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/models/raw_data_element.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_element_item.dart';
import 'package:smooth_app/pages/product/product_page/raw_data/product_raw_data_list_ext.dart';
import 'package:smooth_app/resources/app_icons.dart';
import 'package:smooth_app/themes/smooth_theme.dart';
import 'package:smooth_app/themes/smooth_theme_colors.dart';
import 'package:smooth_app/themes/theme_provider.dart';

class ProductRawDataCategoryItem extends StatelessWidget {
  const ProductRawDataCategoryItem(this.category, {this.controller});

  final ProductRawDataCategory category;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _ProductRawDataCategoryTile(category.icon, category.label),
          _CategoryListView(
              elements: category.rawDatas, controller: controller),
        ]);
  }
}

class _ProductRawDataCategoryTile extends StatelessWidget {
  const _ProductRawDataCategoryTile(this.icon, this.label);

  final AppIcon icon;
  final ProductRawDataCategoryLabel label;
  @override
  Widget build(BuildContext context) {
    final Color contentColor = context.lightTheme()
        ? context.extension<SmoothColorsThemeExtension>().primaryBlack
        : Colors.white;

    final AppLocalizations appLocalizations = AppLocalizations.of(context);

    return Row(
      children: <Widget>[
        IconTheme(
          data: IconThemeData(
            color: contentColor,
            size: 18.0,
          ),
          child: icon,
        ),
        Text(label.toL10nString(appLocalizations)),
      ],
    );
  }
}

class _CategoryListView extends StatefulWidget {
  const _CategoryListView({required this.elements, this.controller});

  final List<ProductRawDataSubCategory> elements;
  final ScrollController? controller;

  @override
  State<StatefulWidget> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<_CategoryListView> {
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
      listToShow = widget.elements.shortenIfTooLong();
    }
    return Container(
      margin: const EdgeInsets.only(left: 90.0),
      child: ListView.separated(
        controller: widget.controller,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ProductRawDataElementItem(
              listToShow[index], () => extendList());
        },
        separatorBuilder: (BuildContext context, _) => const Divider(
            color: Colors
                .black), //TODO utiliser contexte : remplacer noir par blanc dans le cas de dark mode
        itemCount: listToShow.length,
      ),
    );
  }
}
