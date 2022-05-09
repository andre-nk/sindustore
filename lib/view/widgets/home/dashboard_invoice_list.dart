part of "../widgets.dart";

class DashboardInvoiceList extends StatelessWidget {
  const DashboardInvoiceList({Key? key, required this.snapshot}) : super(key: key);

  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.docs.length + 2,
      padding: EdgeInsets.symmetric(
        horizontal: MQuery.width(0.05, context),
        vertical: MQuery.height(0.105, context),
      ),
      itemBuilder: (context, index) {
        if (index == 0) {
          return const MainBox();
        } else if (index == 1) {
          return Padding(
            padding: const EdgeInsets.only(top: 36.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nota aktif",
                  style: AppTheme.text.h3,
                ),
                Text(
                  "lihat semua",
                  style: AppTheme.text.subtitle.copyWith(color: AppTheme.colors.tertiary),
                )
              ],
            ),
          );
        } else {
          return DashboardInvoiceCard(
            index: index - 1,
            invoice: (snapshot.docs[index - 2].data() as Invoice),
          );
        }
      },
    );
  }
}
