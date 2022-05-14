part of "../widgets.dart";

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet(
      {Key? key, required this.product, required this.ancestorContext})
      : super(key: key);

  final Product product;
  final BuildContext ancestorContext;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: BlocProvider.of<InvoiceBloc>(ancestorContext)),
      ],
      child: Padding(
        padding: EdgeInsets.all(MQuery.height(0.025, context)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: MQuery.height(0.025, context)),
                  width: MQuery.width(0.125, context),
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    color: AppTheme.colors.outline,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(right: 16.0),
                            decoration: BoxDecoration(
                              color: AppTheme.colors.surface,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.productName,
                                style: AppTheme.text.title,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: BlocBuilder<InvoiceBloc, InvoiceState>(
                                  builder: (context, invoiceState) {
                                    if (invoiceState is InvoiceStateActivated &&
                                        invoiceState.invoice.products.isNotEmpty) {
                                      List<InvoiceItem> filteredItems = invoiceState
                                          .invoice.products
                                          .where((element) =>
                                              element.productID == product.id)
                                          .toList();

                                      if (filteredItems.isNotEmpty &&
                                          filteredItems.first.discount != 0) {
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 8.0,
                                              ),
                                              child: Text(
                                                NumberFormat.simpleCurrency(
                                                  locale: 'id_ID',
                                                  decimalDigits: 0,
                                                ).format(
                                                  product.productSellPrice.toInt(),
                                                ),
                                                style: AppTheme.text.footnote.copyWith(
                                                  fontSize: 12,
                                                  color: AppTheme.colors.outline,
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.simpleCurrency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                              ).format(
                                                product.productSellPrice.toInt() +
                                                    invoiceState.invoice.products
                                                        .where((element) =>
                                                            element.productID ==
                                                            product.id)
                                                        .first
                                                        .discount,
                                              ),
                                              style: AppTheme.text.subtitle,
                                            )
                                          ],
                                        );
                                      } else {
                                        return Text(
                                          NumberFormat.simpleCurrency(
                                            locale: 'id_ID',
                                            decimalDigits: 0,
                                          ).format(
                                            product.productSellPrice.toInt(),
                                          ),
                                          style: AppTheme.text.subtitle,
                                        );
                                      }
                                    } else {
                                      return Text(
                                        NumberFormat.simpleCurrency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                        ).format(
                                          product.productSellPrice.toInt(),
                                        ),
                                        style: AppTheme.text.subtitle,
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Ionicons.create_outline,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 2,
                  color: AppTheme.colors.outline,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
                  child: ProductCardDiscount(
                      product: product, isMini: false, ancestorContext: ancestorContext),
                ),
                Divider(
                  height: 2,
                  color: AppTheme.colors.outline,
                ),
              ],
            ),
            SizedBox(
              width: MQuery.width(0.9, context),
              child: ProductCardQuantityLarge(product: product),
            ),
          ],
        ),
      ),
    );
  }
}
