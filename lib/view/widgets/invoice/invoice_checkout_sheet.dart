part of "../widgets.dart";

class InvoiceCheckoutSheet extends StatelessWidget {
  const InvoiceCheckoutSheet({Key? key, required this.invoice, this.existingInvoiceUID})
      : super(key: key);

  final Invoice invoice;
  final String? existingInvoiceUID;

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
                      padding:
                          const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: state.invoice.status == InvoiceStatus.paid
                            ? AppTheme.colors.success
                            : AppTheme.colors.tertiary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        state.invoice.status.name.capitalize(),
                        style: AppTheme.text.footnote.copyWith(color: Colors.white),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
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
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => PrinterBloc(
                    BlueThermalPrinter.instance,
                    ProductRepository(),
                    InvoiceRepository(),
                  )..add(PrinterEventScan()),
                ),
                BlocProvider(
                  create: (context) => SheetsBloc(
                    SheetsRepository(),
                  ),
                )
              ],
              child: BlocBuilder<SheetsBloc, SheetsState>(
                builder: (context, state) {
                  return BlocConsumer<PrinterBloc, PrinterState>(
                    listener: (context, state) {
                      if (state is PrinterStatePermissionError) {
                        context.read<PrinterBloc>().add(PrinterEventRequestPermission());
                      } else if (state is PrinterStatePrinted) {
                        Invoice invoiceInstance = Invoice(
                          adminHandlerUID: invoice.adminHandlerUID,
                          customerName: invoice.customerName,
                          products: invoice.products,
                          status: InvoiceStatus.paid,
                          createdAt: invoice.createdAt,
                          updatedAt: invoice.updatedAt,
                        );

                        if (existingInvoiceUID != null) {
                          context.read<InvoiceBloc>().add(
                                InvoiceEventUpdate(
                                  invoice: invoiceInstance,
                                  invoiceUID: existingInvoiceUID!,
                                ),
                              );
                        } else {
                          context.read<InvoiceBloc>().add(
                                InvoiceEventCreate(invoice: invoiceInstance),
                              );
                        }

                        context.read<SheetsBloc>().add(SheetsEventInsertInvoice(invoice));

                        //TODO: PROPER ERROR HANDLING
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: AppTheme.colors.success,
                            content: Text(
                              "Nota berhasil dicetak!",
                              style: AppTheme.text.subtitle.copyWith(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      return Opacity(
                        opacity: invoice.status != InvoiceStatus.paid ? 1.0 : 0.5,
                        child: WideButton(
                          title: "Konfirmasi dan cetak nota",
                          onPressed: () {
                            if (invoice.status != InvoiceStatus.paid) {
                              if (state is PrinterStateLoaded &&
                                  context.read<InvoiceBloc>().state
                                      is InvoiceStateActivated) {
                                context.read<PrinterBloc>().add(
                                      PrinterEventPrint(
                                        invoice: (context.read<InvoiceBloc>().state
                                                as InvoiceStateActivated)
                                            .invoice,
                                        device: state.devices
                                            .where((element) => element.name == "MPT-II")
                                            .first,
                                      ),
                                    );
                              }
                            }
                          },
                        ),
                      );
                    },
                  );
                },
              ),
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
