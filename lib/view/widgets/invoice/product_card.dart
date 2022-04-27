part of "../widgets.dart";

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showMaterialModalBottomSheet(
              context: context,
              builder: (context) {
                return SizedBox(
                  height: MQuery.height(0.4, context),
                  child: ProductBottomSheet(product: product),
                );
              },
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
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
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: AppTheme.colors.surface,
                          borderRadius: BorderRadius.circular(12.0)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ProductCardDiscount(product: product, isMini: true,)
                    BlocBuilder<InvoiceBloc, InvoiceState>(
                      builder: (context, state) {
                        if (state is InvoiceStateActivated) {
                          for (var stateProduct in state.invoice.products) {
                            if (stateProduct.productID == product.id) {
                              //? THIS PRODUCT EXISTS IN THE INVOICE
                              return ProductCardQuantity(
                                activatedProduct: stateProduct,
                              );
                            } else {
                              return ProductCardQuantity(
                                deactivatedProduct: product,
                              );
                            }
                          }
                        } else if (state is InvoiceStateInitial) {
                          return ProductCardQuantity(
                            deactivatedProduct: product,
                          );
                        } else {
                          return const SizedBox();
                        }

                        return const SizedBox();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        Divider(height: 2, color: AppTheme.colors.outline),
      ],
    );
  }
}
