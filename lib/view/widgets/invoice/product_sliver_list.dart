part of "../widgets.dart";

class ProductSliverList extends StatelessWidget {
  const ProductSliverList({Key? key, required this.snapshot}) : super(key: key);

  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (snapshot.hasMore && index + 1 == snapshot.docs.length) {
            snapshot.fetchMore();
          }

          return Container(
            margin: index == snapshot.docs.length - 1
                ? EdgeInsets.only(bottom: MQuery.height(0.1, context))
                : EdgeInsets.zero,
            child: snapshot.docs[index].data() != null
                ? ProductCard(
                    product: snapshot.docs[index].data() as Product,
                  )
                : const SizedBox(),
          );
        },
        childCount: snapshot.docs.length,
      ),
    );
  }
}
