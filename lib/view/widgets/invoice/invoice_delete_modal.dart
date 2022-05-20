part of "../widgets.dart";

class InvoiceDeleteModal extends StatelessWidget {
  const InvoiceDeleteModal({
    Key? key,
    required this.invoiceUID,
    required this.ancestorContext,
  }) : super(key: key);

  final String invoiceUID;
  final BuildContext ancestorContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      contentPadding: const EdgeInsets.all(24.0).copyWith(right: 32.0),
      title: const Text("Hapus nota ini?"),
      content: const Text(
        "Hati-hati, data nota ini tidak dapat dikembalikan setelah terhapus!",
      ),
      actions: [
        BlocProvider(
          create: (context) => InvoiceBloc(InvoiceRepository()),
          child: BlocBuilder<InvoiceBloc, InvoiceState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  context
                      .read<InvoiceBloc>()
                      .add(InvoiceEventDelete(invoiceUID: invoiceUID));
                  Navigator.pop(ancestorContext);
                },
                child: Text(
                  "Hapus",
                  style: AppTheme.text.subtitle.copyWith(
                    color: AppTheme.colors.error,
                  ),
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            "Batal",
            style: AppTheme.text.subtitle,
          ),
        ),
      ],
    );
  }
}
