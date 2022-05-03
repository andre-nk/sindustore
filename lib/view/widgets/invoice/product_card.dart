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
                        Padding(
                          padding: const EdgeInsets.only(top: 2.0),
                          child: Text(
                            NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0)
                                .format(product.productSellPrice.toInt()),
                            style: AppTheme.text.subtitle,
                          ),
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
                          ProductCardDiscount(product: product, isMini: true),
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
