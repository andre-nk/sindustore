part of "../screens.dart";

class InvoiceCheckoutPage extends StatelessWidget {
  const InvoiceCheckoutPage(
      {Key? key, required this.ancestorContext, this.existingInvoiceUID})
      : super(key: key);

  final BuildContext ancestorContext;
  final String? existingInvoiceUID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<InvoiceBloc>(ancestorContext),
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, invoiceState) {
          return Scaffold(
            appBar: const GeneralAppBar(title: "Cetak nota"),
            body: SafeArea(
              child: SizedBox(
                height: MQuery.height(1, context),
                child: Stack(
                  children: [
                    invoiceState is InvoiceStateActivated && invoiceState.invoice.products.isNotEmpty
                        ? BlocProvider(
                            create: (context) => ProductBloc(ProductRepository())
                              ..add(
                                ProductEventInvoiceFetch(
                                  invoiceItems: invoiceState.invoice.products,
                                ),
                              ),
                            child: SizedBox(
                              height: MQuery.height(0.65, context),
                              child: BlocBuilder<ProductBloc, ProductState>(
                                builder: (context, productState) {
                                  if (productState is ProductStateInvoiceLoaded) {
                                    return ListView.builder(
                                      itemCount: productState.invoiceProduct.length + 3,
                                      itemBuilder: (context, index) {
                                        if (index == 0) {
                                          return InvoiceCheckoutHeader(
                                            invoice: invoiceState.invoice,
                                          );
                                        } else if (index == 1) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                              top: MQuery.height(0.025, context),
                                              bottom: MQuery.height(0.015, context),
                                            ),
                                            height: 12,
                                            color: AppTheme.colors.surface,
                                          );
                                        } else if (index == 2) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  "Produk (${invoiceState.invoice.products.length})",
                                                  style: AppTheme.text.paragraph.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                      shape: const StadiumBorder(),
                                                      elevation: 0),
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
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
                                          );
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0,
                                            ),
                                            child: ProductCard(
                                              isCheckout: true,
                                              product: productState.invoiceProduct[index - 3],
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } else if (productState is ProductStateFetching) {
                                    return const CustomLoadingIndicator();
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                            ),
                          )
                        : Column(
                            children: [
                              invoiceState is InvoiceStateActivated
                                  ? InvoiceCheckoutHeader(
                                      invoice: invoiceState.invoice,
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
                    invoiceState is InvoiceStateActivated
                        ? Positioned(
                            child: InvoiceCheckoutSheet(
                              invoice: invoiceState.invoice,
                              existingInvoiceUID: existingInvoiceUID,
                            ),
                            bottom: 0,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
