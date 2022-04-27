part of "../widgets.dart";

class ProductCardDiscount extends StatelessWidget {
  const ProductCardDiscount({Key? key, required this.product, required this.isMini}) : super(key: key);

  final Product product;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return product.productDiscounts.isNotEmpty
        ? ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: isMini ? const EdgeInsets.symmetric(horizontal: 12.0) : const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
                side: BorderSide(color: AppTheme.colors.primary),
              ),
              elevation: 0,
              primary: AppTheme.colors.background,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Pilihan diskon (${product.productDiscounts.length})",
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(Ionicons.chevron_down, size: 16),
                )
              ],
            ),
          )
        : const SizedBox();
  }
}
