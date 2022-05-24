part of "../widgets.dart";

class ProductCardDiscount extends StatelessWidget {
  const ProductCardDiscount({
    Key? key,
    required this.product,
    required this.isMini,
    required this.ancestorContext,
  }) : super(key: key);

  final Product product;
  final BuildContext ancestorContext;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
              child: AutoSizeText("Pilihan diskon:"),
            ),
            SizedBox(
              width: MQuery.width(0.9, context),
              child: Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: MQuery.width(0.035, context),
                        right: MQuery.width(0.02, context),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.colors.outline),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<double>(
                          hint: AutoSizeText(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: product.productDiscounts
                              .map(
                                (item) => DropdownMenuItem<double>(
                                  value: item.amount,
                                  child: AutoSizeText(
                                    item.discountName +
                                        " (${NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0).format(item.amount)})",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: state is InvoiceStateActivated &&
                                  state.invoice.products.isNotEmpty
                              ? state.invoice.products
                                          .where((element) =>
                                              element.productID == product.id)
                                          .isNotEmpty &&
                                      state.invoice.products
                                              .where((element) =>
                                                  element.productID == product.id)
                                              .first
                                              .discount !=
                                          0
                                  ? state.invoice.products
                                      .where((element) => element.productID == product.id)
                                      .first
                                      .discount
                                  : product.productDiscounts.isEmpty
                                      ? 0.0
                                      : product.productDiscounts.first.amount
                              : product.productDiscounts.isEmpty
                                  ? 0.0
                                  : product.productDiscounts.first.amount,
                          onChanged: (value) {
                            if (value != null && state is InvoiceStateActivated) {
                              context.read<InvoiceBloc>().add(
                                    InvoiceEventEditDiscount(
                                      invoice: state.invoice,
                                      productID: product.id,
                                      productDiscount: value,
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ProductDiscountModal(productID: product.id);
                          },
                        );
                      },
                      splashRadius: 16,
                      icon: const Center(
                        child: Icon(Ionicons.add_circle_outline),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
