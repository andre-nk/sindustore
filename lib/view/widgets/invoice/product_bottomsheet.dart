part of "../widgets.dart";

class ProductBottomSheet extends StatelessWidget {
  const ProductBottomSheet({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => InvoiceBloc()),
        BlocProvider(create: (context) => AuthBloc(AuthRepository())),
      ],
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(MQuery.height(0.025, context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                Row(
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
                              borderRadius: BorderRadius.circular(12.0)),
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
                              child: Text(
                                NumberFormat.simpleCurrency(
                                        locale: 'id_ID', decimalDigits: 0)
                                    .format(product.productSellPrice.toInt()),
                                style: AppTheme.text.subtitle,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Ionicons.create_outline,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ProductCardDiscount(
                    product: product,
                    isMini: false,
                  ),
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }
}
