part of "../widgets.dart";

class InvoiceProductListFAB extends StatelessWidget {
  const InvoiceProductListFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        return SizedBox(
          height: 72,
          width: MQuery.width(0.9, context),
          child: FloatingActionButton.extended(
            onPressed: () {
              if (state is InvoiceStateActivated && state.invoice.products.isNotEmpty) {
                RouteWrapper.push(
                  context,
                  child: InvoiceCheckoutPage(
                    ancestorContext: context,
                  ),
                );
              }
            },
            backgroundColor: state is InvoiceStateActivated && state.invoice.products.isNotEmpty
                ? AppTheme.colors.primary
                : AppTheme.colors.primary.withOpacity(0.8),
            label: SizedBox(
              width: MQuery.width(0.75, context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  state is InvoiceStateActivated && state.invoice.products.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${state.invoice.products.length} produk",
                              style: AppTheme.text.subtitle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Lanjut ke halaman checkout",
                                style: AppTheme.text.footnote
                                    .copyWith(color: Colors.white, letterSpacing: 0.1),
                              ),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Belum ada produk",
                              style: AppTheme.text.subtitle.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.1,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                "Tambah produk diatas...",
                                style: AppTheme.text.footnote
                                    .copyWith(color: Colors.white, letterSpacing: 0.1),
                              ),
                            ),
                          ],
                        ),
                  const Icon(
                    Ionicons.chevron_forward,
                    size: 24,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
