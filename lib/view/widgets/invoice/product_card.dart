part of "../widgets.dart";

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product, required this.isCheckout})
      : super(key: key);
  final Product product;
  final bool isCheckout;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: MQuery.height(0.425, context),
                  child: ProductBottomSheet(
                    product: product,
                    ancestorContext: context,
                  ),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 20.0,
            ).copyWith(bottom: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName,
                          style: AppTheme.text.title,
                        ),
                        BlocBuilder<InvoiceBloc, InvoiceState>(
                          builder: (context, invoiceState) {
                            if (invoiceState is InvoiceStateActivated &&
                                invoiceState.invoice.products.isNotEmpty) {
                              List<InvoiceItem> filteredItems = invoiceState
                                  .invoice.products
                                  .where((element) => element.productID == product.id)
                                  .toList();

                              if (filteredItems.isNotEmpty && filteredItems.first.discount != 0) {
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
                                                    element.productID == product.id)
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
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: AppTheme.colors.surface,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        !isCheckout
                            ? ProductCardQuantity(
                                product: product,
                              )
                            : const SizedBox()
                      ],
                    ),
                  ],
                ),
                isCheckout
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ProductCardDiscount(
                            product: product,
                            isMini: true,
                            ancestorContext: context,
                          ),
                          ProductCardQuantity(
                            product: product,
                          )
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
        Divider(height: 2, color: AppTheme.colors.outline),
      ],
    );
  }
}
