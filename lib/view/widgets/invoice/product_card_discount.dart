part of "../widgets.dart";

class ProductCardDiscount extends StatelessWidget {
  const ProductCardDiscount({Key? key, required this.product, required this.isMini})
      : super(key: key);

  final Product product;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscountBloc(DiscountRepository()),
      child: BlocBuilder<DiscountBloc, DiscountState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0, left: 4.0),
                child: Text("Pilihan diskon:"),
              ),
              Container(
                width: MQuery.width(0.9, context),
                padding: EdgeInsets.only(
                    left: MQuery.width(0.035, context),
                    right: MQuery.width(0.02, context)),
                decoration: BoxDecoration(
                    border: Border.all(color: AppTheme.colors.outline),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0))),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2<ProductDiscount>(
                    hint: Text(
                      'Select Item',
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    items: product.productDiscounts
                        .map((item) => DropdownMenuItem<ProductDiscount>(
                              value: item,
                              child: Text(
                                item.discountName +
                                    " (${NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0).format(item.amount)})",
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    value: state is DiscountStateActive
                        ? state.productDiscount
                        : product.productDiscounts.first,
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<DiscountBloc>()
                            .add(DiscountEventSelect(productDiscount: value));
                      }
                    },
                    buttonHeight: 40,
                    buttonWidth: 140,
                    itemHeight: 40,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
