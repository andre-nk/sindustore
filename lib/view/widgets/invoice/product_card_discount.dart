part of "../widgets.dart";

class ProductCardDiscount extends StatelessWidget {
  const ProductCardDiscount({Key? key, required this.product, required this.isMini})
      : super(key: key);

  final Product product;
  final bool isMini;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      items: product.productDiscounts.map((discount) {
        return DropdownMenuItem(child: Text(discount.discountName));
      }).toList(),
      hint: Text(product.productDiscounts.isNotEmpty
          ? "Pilihan diskon (${product.productDiscounts.length})"
          : "Pilihan diskon"),
      icon: const Icon(Ionicons.chevron_down),
      iconSize: 16,
      dropdownWidth: double.infinity,
      buttonWidth: double.infinity,
    );
  }
}
