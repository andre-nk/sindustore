part of "../widgets.dart";

class InvoiceCardItemList extends StatelessWidget {
  const InvoiceCardItemList({Key? key, required this.invoice}) : super(key: key);

  final Invoice invoice;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MQuery.height(0.105, context),
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Scrollbar(
          radius: const Radius.circular(50.0),
          child: ListView.builder(
            itemCount: invoice.products.length,
            itemBuilder: (context, index) {
              return BlocProvider(
                create: (context) => ProductBloc(ProductRepository())
                  ..add(
                    ProductEventFetchByID(productID: invoice.products[index].productID),
                  ),
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductStateByIDLoaded) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${state.product.productName} (${invoice.products[index].quantity}x)",
                              style: AppTheme.text.footnote.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            invoice.products[index].discount != 0
                                ? Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          NumberFormat.simpleCurrency(
                                            locale: 'id_ID',
                                            decimalDigits: 0,
                                          ).format(
                                            state.product.productSellPrice.toInt(),
                                          ),
                                          style: AppTheme.text.footnote.copyWith(
                                              fontSize: 11,
                                              color: AppTheme.colors.outline,
                                              decoration: TextDecoration.lineThrough),
                                        ),
                                      ),
                                      Text(
                                        NumberFormat.simpleCurrency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                        ).format(
                                          state.product.productSellPrice +
                                              invoice.products[index].discount,
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    NumberFormat.simpleCurrency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                    ).format(
                                      state.product.productSellPrice.toInt(),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
