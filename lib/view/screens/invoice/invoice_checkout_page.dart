part of "../screens.dart";

class InvoiceCheckoutPage extends StatelessWidget {
  const InvoiceCheckoutPage(
      {Key? key, required this.ancestorContext, this.existingInvoice})
      : super(key: key);

  final BuildContext ancestorContext;
  final Invoice? existingInvoice;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<InvoiceBloc>(ancestorContext),
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const GeneralAppBar(title: "Cetak nota"),
            body: SafeArea(
              child: Stack(
                children: [
                  state is InvoiceStateActivated && state.invoice.products.isNotEmpty
                      ? Column(
                          children: [
                            InvoiceCheckoutHeader(invoice: state.invoice),
                            Container(
                              margin: EdgeInsets.only(
                                top: MQuery.height(0.025, context),
                                bottom: MQuery.height(0.015, context),
                              ),
                              height: 12,
                              color: AppTheme.colors.surface,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Produk (${state.invoice.products.length})",
                                        style: AppTheme.text.paragraph.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(), elevation: 0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            "Tambah",
                                            style: AppTheme.text.footnote.copyWith(
                                              color: AppTheme.colors.secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: MQuery.height(0.675, context),
                                    padding: EdgeInsets.only(
                                      bottom: MQuery.height(0.25, context),
                                    ),
                                    child: BlocProvider(
                                      create: (context) =>
                                          ProductBloc(ProductRepository())
                                            ..add(
                                              ProductEventInvoiceFetch(
                                                invoiceItems: state.invoice.products,
                                              ),
                                            ),
                                      child: BlocBuilder<ProductBloc, ProductState>(
                                        builder: (context, state) {
                                          if (state is ProductStateInvoiceLoaded) {
                                            return ListView.builder(
                                              itemCount: state.invoiceProduct.length,
                                              itemBuilder: (context, index) {
                                                return ProductCard(
                                                  isCheckout: true,
                                                  product: state.invoiceProduct[index],
                                                );
                                              },
                                            );
                                          } else if (state is ProductStateFetching) {
                                            return const CustomLoadingIndicator();
                                          } else {
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            state is InvoiceStateActivated
                                ? InvoiceCheckoutHeader(
                                    invoice: state.invoice,
                                  )
                                : const SizedBox(),
                            Container(
                              margin: EdgeInsets.only(
                                top: MQuery.height(0.025, context),
                                bottom: MQuery.height(0.015, context),
                              ),
                              height: 12,
                              color: AppTheme.colors.surface,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Belum ada produk",
                                        style: AppTheme.text.paragraph.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(), elevation: 0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Text(
                                            "Tambah",
                                            style: AppTheme.text.footnote.copyWith(
                                              color: AppTheme.colors.secondary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    height: MQuery.height(0.65, context),
                                    padding: EdgeInsets.only(
                                      bottom: MQuery.height(0.25, context),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/404_illustration.png",
                                            height: MQuery.height(0.1, context),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 36.0,
                                              bottom: 8.0,
                                            ),
                                            child: Text(
                                              "Belum ada produk di nota ini!",
                                              style: AppTheme.text.title,
                                            ),
                                          ),
                                          Text(
                                            "Coba mulai tambahkan produk melalui tombol di atas",
                                            style: AppTheme.text.subtitle,
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                  state is InvoiceStateActivated
                      ? const Positioned(
                          child: InvoiceCheckoutSheet(),
                          bottom: 0,
                        )
                      : const SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
