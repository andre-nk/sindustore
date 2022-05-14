part of "../widgets.dart";

class InvoiceCardValue extends StatelessWidget {
  const InvoiceCardValue({Key? key, required this.invoice, required this.invoiceUID}) : super(key: key);

  final Invoice invoice;
  final String invoiceUID;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InvoiceValueCubit>(
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
                  style: AppTheme.text.paragraph.copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      RouteWrapper.push(
                        context,
                        child: InvoiceProductListPage(
                          existingInvoice: invoice,
                          existingInvoiceUID: invoiceUID,
                        ),
                      );
                    },
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
    );
  }
}
