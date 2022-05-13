part of "../widgets.dart";

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class DashboardInvoiceCard extends StatelessWidget {
  const DashboardInvoiceCard({
    Key? key,
    required this.invoice,
    required this.index,
  }) : super(key: key);

  final Invoice invoice;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(16.0).copyWith(bottom: 12.0),
      decoration: BoxDecoration(
        color: AppTheme.colors.background,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[900]!.withOpacity(0.05),
            spreadRadius: 10,
            blurRadius: 15,
            offset: const Offset(0, 1),
          ),
        ],
        border: Border.all(
          color: AppTheme.colors.outline,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nota - 0" + index.toString(),
                    style: AppTheme.text.paragraph.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: Text(
                      DateFormat.Hm().format(invoice.createdAt) +
                          ", " +
                          DateFormat.yMd().format(invoice.createdAt),
                      style: AppTheme.text.footnote,
                    ),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: AppTheme.colors.tertiary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                child: Text(
                  invoice.status.name.capitalize(),
                  style: AppTheme.text.footnote.copyWith(color: Colors.white),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Divider(
              color: AppTheme.colors.outline,
            ),
          ),
          SizedBox(
            height: MQuery.height(0.105, context),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemCount: invoice.products.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (context) => ProductBloc(ProductRepository())
                      ..add(
                        ProductEventFetchByID(
                            productID: invoice.products[index].productID),
                      ),
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        if (state is ProductStateByIDLoaded) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${state.product.productName} (${invoice.products[index].quantity}x)" ,
                                  style: AppTheme.text.footnote.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                invoice.products[index].discount != 0
                                    ? Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(
                                              NumberFormat.simpleCurrency(
                                                locale: 'id_ID',
                                                decimalDigits: 0,
                                              ).format(
                                                state.product.productSellPrice.toInt(),
                                              ),
                                              style: AppTheme.text.footnote.copyWith(
                                                  fontSize: 11,
                                                  color: AppTheme.colors.outline,
                                                  decoration: TextDecoration.lineThrough),
                                            ),
                                          ),
                                          Text(
                                            NumberFormat.simpleCurrency(
                                              locale: 'id_ID',
                                              decimalDigits: 0,
                                            ).format(
                                              state.product.productSellPrice -
                                                  invoice.products[index].discount,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Text(
                                        NumberFormat.simpleCurrency(
                                          locale: 'id_ID',
                                          decimalDigits: 0,
                                        ).format(
                                          state.product.productSellPrice.toInt(),
                                        ),
                                      ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          BlocProvider<InvoiceValueCubit>(
            create: (context) => InvoiceValueCubit(
              invoiceRepository: InvoiceRepository(),
            )..sumInvoice(invoice),
            child: BlocBuilder<InvoiceValueCubit, InvoiceValueState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        NumberFormat.simpleCurrency(
                          locale: 'id_ID',
                          decimalDigits: 0,
                        ).format(state.invoiceValue),
                        style:
                            AppTheme.text.paragraph.copyWith(fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
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
                              "Bayar",
                              style: AppTheme.text.footnote.copyWith(
                                color: AppTheme.colors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
