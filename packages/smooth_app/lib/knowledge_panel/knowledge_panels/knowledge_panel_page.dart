import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_app/data_models/up_to_date_mixin.dart';
import 'package:smooth_app/database/local_database.dart';
import 'package:smooth_app/generic_lib/design_constants.dart';
import 'package:smooth_app/generic_lib/widgets/smooth_card.dart';
import 'package:smooth_app/helpers/product_cards_helper.dart';
import 'package:smooth_app/knowledge_panel/knowledge_panels/knowledge_panel_expanded_card.dart';
import 'package:smooth_app/knowledge_panel/knowledge_panels_builder.dart';
import 'package:smooth_app/pages/product/common/product_refresher.dart';
import 'package:smooth_app/pages/scan/carousel/scan_carousel_manager.dart';
import 'package:smooth_app/themes/smooth_theme.dart';
import 'package:smooth_app/themes/smooth_theme_colors.dart';
import 'package:smooth_app/themes/theme_provider.dart';
import 'package:smooth_app/widgets/smooth_app_bar.dart';
import 'package:smooth_app/widgets/smooth_scaffold.dart';

/// Detail page of knowledge panels (if you click on the forward/more button).
class KnowledgePanelPage extends StatefulWidget {
  const KnowledgePanelPage({
    required this.panelId,
    required this.product,
  });

  final String panelId;
  final Product product;

  @override
  State<KnowledgePanelPage> createState() => _KnowledgePanelPageState();
}

class _KnowledgePanelPageState extends State<KnowledgePanelPage>
    with TraceableClientMixin, UpToDateMixin {
  @override
  String get actionName => 'Opened full knowledge panel page';

  @override
  void initState() {
    super.initState();
    initUpToDate(widget.product, context.read<LocalDatabase>());
  }

  static KnowledgePanelPanelGroupElement? _groupElementOf(
      BuildContext context) {
    try {
      return Provider.of<KnowledgePanelPanelGroupElement>(context);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations appLocalizations = AppLocalizations.of(context);
    final String title = _getTitle();

    context.watch<LocalDatabase>();
    refreshUpToDate();
    return SmoothScaffold(
      backgroundColor: context.lightTheme()
          ? context.extension<SmoothColorsThemeExtension>().primaryLight
          : null,
      appBar: SmoothAppBar(
        title: Semantics(
          label: _getTitleForAccessibility(appLocalizations, title),
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subTitle: Text(
          getProductNameAndBrands(upToDateProduct, appLocalizations),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProduct(context),
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: SMALL_SPACE,
                      top: SMALL_SPACE,
                    ),
                    child: SmoothCard(
                      padding: const EdgeInsets.all(
                        SMALL_SPACE,
                      ),
                      child: KnowledgePanelExpandedCard(
                        panelId: widget.panelId,
                        product: upToDateProduct,
                        isInitiallyExpanded: true,
                        isClickable: true,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _refreshProduct(BuildContext context) async {
    try {
      final String? barcode =
          ExternalScanCarouselManager.read(context).currentBarcode;
      if (barcode?.isEmpty == true) {
        return;
      }
      await ProductRefresher().fetchAndRefresh(
        barcode: barcode ?? '',
        context: context,
      );
    } catch (e) {
      //no refreshing during onboarding
    }
  }

  String _getTitle() {
    final KnowledgePanelPanelGroupElement? groupElement =
        _groupElementOf(context);
    if (groupElement?.title != null &&
        groupElement?.title!.isNotEmpty == true) {
      return groupElement!.title!;
    }
    final KnowledgePanel? panel = KnowledgePanelsBuilder.getKnowledgePanel(
      upToDateProduct,
      widget.panelId,
    );
    if (panel?.titleElement?.title.isNotEmpty == true) {
      return (panel?.titleElement?.title)!;
    }
    return '';
  }

  String _getTitleForAccessibility(
    AppLocalizations appLocalizations,
    String title,
  ) {
    final String productName = upToDateProduct.productName ??
        upToDateProduct.abbreviatedName ??
        upToDateProduct.genericName ??
        '';
    if (title.isEmpty) {
      return appLocalizations.knowledge_panel_page_title_no_title(productName);
    } else {
      return appLocalizations.knowledge_panel_page_title(
        title,
        productName,
      );
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('panelId', widget.panelId));
  }
}
