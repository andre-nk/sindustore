part of "../widgets.dart";

class InvoiceCheckoutSheet extends StatelessWidget {
  const InvoiceCheckoutSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MQuery.width(1, context),
      height: MQuery.height(0.225, context),
      padding: EdgeInsets.all(MQuery.width(0.05, context)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Status nota",
                style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
              ),
              BlocBuilder<InvoiceBloc, InvoiceState>(
                builder: (context, state) {
                  if (state is InvoiceStateActivated) {
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                      decoration: BoxDecoration(
                        color: state.invoice.status == InvoiceStatus.cancelled ||
                                state.invoice.status == InvoiceStatus.loan
                            ? AppTheme.colors.error
                            : state.invoice.status == InvoiceStatus.hold ||
                                    state.invoice.status == InvoiceStatus.returned
                                ? AppTheme.colors.outline
                                : state.invoice.status == InvoiceStatus.paid
                                    ? AppTheme.colors.success
                                    : AppTheme.colors.tertiary,
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<InvoiceStatus>(
                          icon: const SizedBox(),
                          style: AppTheme.text.footnote.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          isDense: true,
                          alignment: Alignment.center,
                          items: [
                            InvoiceStatus.cancelled,
                            InvoiceStatus.pending,
                            InvoiceStatus.loan,
                            InvoiceStatus.paid,
                            InvoiceStatus.hold,
                            InvoiceStatus.returned,
                          ]
                              .map(
                                (item) => DropdownMenuItem<InvoiceStatus>(
                                  value: item,
                                  child: Text(
                                    item.name.capitalize(),
                                    style: AppTheme.text.footnote.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          value: state.invoice.status,
                          onChanged: (value) {
                            context.read<InvoiceBloc>().add(
                                  InvoiceEventMarkStatus(
                                    invoice: state.invoice,
                                    status: value!,
                                  ),
                                );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Total:",
                  style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
                ),
                BlocBuilder<InvoiceBloc, InvoiceState>(
                  builder: (context, state) {
                    if (state is InvoiceStateActivated) {
                      return BlocProvider(
                        create: (context) => InvoiceValueCubit(
                          invoiceRepository: InvoiceRepository(),
                        )..sumInvoice(state.invoice),
                        child: BlocBuilder<InvoiceValueCubit, InvoiceValueState>(
                          builder: (context, state) {
                            return Text(
                              NumberFormat.simpleCurrency(
                                locale: 'id_ID',
                                decimalDigits: 0,
                              ).format(state.invoiceValue),
                              style: AppTheme.text.subtitle
                                  .copyWith(fontWeight: FontWeight.w500),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: WideButton(
              title: "Konfirmasi dan cetak nota",
              onPressed: () {},
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: AppTheme.colors.background,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24.0),
          topLeft: Radius.circular(24.0),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.colors.outline.withOpacity(0.5),
            offset: const Offset(0, -8),
            blurRadius: 20.0,
          ),
        ],
      ),
    );
  }
}
