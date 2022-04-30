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
          return Container(
            width: MQuery.width(0.9, context),
            padding: EdgeInsets.only(
                left: MQuery.width(0.035, context), right: MQuery.width(0.02, context)),
            decoration: BoxDecoration(
                border: Border.all(color: AppTheme.colors.outline),
                borderRadius: const BorderRadius.all(Radius.circular(8.0))),
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: ["Tanpa diskon", ...product.productDiscounts]
                    .map((item) => DropdownMenuItem<String>(
                          value: item is ProductDiscount ? item.id : item.toString(),
                          child: Text(
                            item is ProductDiscount
                                ? item.discountName +
                                    " (${NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0).format(item.amount)})"
                                : item.toString(),
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: state is DiscountStateActive ? state.discountID : "Tanpa diskon",
                onChanged: (value) {
                  context
                      .read<DiscountBloc>()
                      .add(DiscountEventSelect(discountID: value as String));
                },
                buttonHeight: 40,
                buttonWidth: 140,
                itemHeight: 40,
              ),
            ),
          );
        },
      ),
    );
  }
}
