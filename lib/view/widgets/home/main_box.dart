part of "../widgets.dart";

class MainBox extends StatelessWidget {
  const MainBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppTheme.colors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!.withOpacity(0.075),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4.0,
              left: 3,
              right: 4,
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Icon(
                    Ionicons.search,
                    size: 20,
                    color: AppTheme.colors.primary,
                  ),
                ),
                border: InputBorder.none,
                hintText: "Cari produk di toko...",
                hintStyle:
                    AppTheme.text.subtitle.copyWith(color: AppTheme.colors.outline),
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppTheme.colors.outline.withOpacity(0.25),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Ionicons.cart_outline, size: 24),
                      ),
                      Text("Restock"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    RouteWrapper.push(context, child: const ProductListPage());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Ionicons.receipt_outline, size: 24),
                      ),
                      Text("Buat Nota"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Ionicons.time_outline, size: 24),
                      ),
                      Text("Riwayat"),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Ionicons.information_circle_outline, size: 24),
                      ),
                      Text("Informasi"),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
