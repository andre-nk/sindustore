part of "../widgets.dart";

class InvoiceProductSliverList extends StatelessWidget {
  const InvoiceProductSliverList({Key? key, required this.snapshot}) : super(key: key);

  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            snapshot.fetchMore();
          }
    
          if (snapshot.docs.isEmpty) {
            return SizedBox(
              height: MQuery.height(0.6, context),
              width: MQuery.width(0.75, context),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/404_illustration.png",
                      height: MQuery.height(0.125, context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
                      child: AutoSizeText(
                        "Produk tidak ditemukan.",
                        style: AppTheme.text.h3,
                      ),
                    ),
                    AutoSizeText(
                      "Coba gunakan kata kunci lain.",
                      style: AppTheme.text.subtitle,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              margin: index == snapshot.docs.length - 1
                  ? EdgeInsets.only(bottom: MQuery.height(0.1, context))
                  : EdgeInsets.zero,
              child: snapshot.docs[index].data() != null
                  ? ProductCard(
                      isCheckout: false,
                      product: snapshot.docs[index].data() as Product,
                    )
                  : const SizedBox(),
            );
          }
        },
        childCount: snapshot.docs.isEmpty ? 1 : snapshot.docs.length,
      ),
    );
  }
}
