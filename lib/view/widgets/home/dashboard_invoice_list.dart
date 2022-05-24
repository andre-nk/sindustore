part of "../widgets.dart";

class DashboardInvoiceList extends StatelessWidget {
  const DashboardInvoiceList({Key? key, required this.snapshot}) : super(key: key);

  final FirestoreQueryBuilderSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.docs.length + 2,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: -1 * MQuery.width(1.005, context),
                child: Container(
                  width: MQuery.width(1.5, context),
                  height: MQuery.width(1.5, context),
                  decoration: BoxDecoration(
                    color: AppTheme.colors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                child: Image.asset("assets/logo_yellow.png", height: 48),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MQuery.width(0.05, context),
                  vertical: MQuery.height(0.08, context),
                ).copyWith(
                  bottom: MQuery.height(0, context),
                ),
                child: const MainBox(),
              ),
            ],
          );
        } else if (index == 1) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MQuery.width(0.075, context),
            ).copyWith(top: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  "Nota aktif",
                  style: AppTheme.text.h3,
                ),
                InkWell(
                  onTap: (){
                    RouteWrapper.push(context, child: const InvoiceListPage());
                  },
                  child: AutoSizeText(
                    "lihat semua",
                    style: AppTheme.text.subtitle.copyWith(color: AppTheme.colors.tertiary),
                  ),
                )
              ],
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MQuery.width(0.05, context),
            ).copyWith(bottom: index == snapshot.docs.length + 1 ? 32.0 : 0.0),
            child: InvoiceCard(
              index: index - 1,
              invoiceUID: snapshot.docs[index - 2].id,
              invoice: (snapshot.docs[index - 2].data() as Invoice),
            ),
          );
        }
      },
    );
  }
}
