part of "../widgets.dart";

class InvoiceCheckoutHeader extends StatelessWidget {
  const InvoiceCheckoutHeader({Key? key, this.invoice})
      : super(key: key);

  final Invoice? invoice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          BlocBuilder<InvoiceBloc, InvoiceState>(
            builder: (context, state) {
              if (state is InvoiceStateActivated) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "Yth. (opsional)",
                      style: AppTheme.text.footnote,
                    ),
                    TextFormField(
                      controller: TextEditingController.fromValue(
                        TextEditingValue(text: state.invoice.customerName),
                      ),
                      onFieldSubmitted: (value) {
                        context.read<InvoiceBloc>().add(
                              InvoiceEventUpdateCustomerName(
                                invoice: state.invoice,
                                newCustomerName: value,
                              ),
                            );
                      },
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: "Nama konsumen (contoh: Sutrisno)",
                        hintStyle: AppTheme.text.subtitle.copyWith(
                          color: AppTheme.colors.outline,
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          Divider(thickness: 1.25, height: 8, color: AppTheme.colors.outline),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  "Dirilis pada",
                  style: AppTheme.text.footnote,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: AutoSizeText(
                    invoice != null
                        ? DateFormat.Hm().format(invoice!.createdAt) +
                            ", " +
                            DateFormat.yMd().format(invoice!.createdAt)
                        : "Belum dirilis",
                    style: AppTheme.text.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
