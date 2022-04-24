part of "../widgets.dart";

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
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
                        NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0).format(product.productSellPrice.toInt()),
                        style: AppTheme.text.subtitle,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppTheme.colors.surface,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(product.productCoverURL),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 12.0),
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: AppTheme.colors.primary,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: Center(
                          child: Text(
                            "Tambah",
                            style: AppTheme.text.footnote.copyWith(
                                color: AppTheme.colors.secondary,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Divider(height: 2, color: AppTheme.colors.outline),
        ],
      ),
    );
  }
}
