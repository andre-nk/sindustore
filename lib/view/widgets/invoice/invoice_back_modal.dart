part of "../widgets.dart";

class InvoiceBackModal extends StatelessWidget {
  const InvoiceBackModal({Key? key, required this.invoice, required this.ancestorContext}) : super(key: key);

  final Invoice invoice;
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
      title: const Text("Simpan nota ini?"),
      content: const Text(
        "Nota baru ini dapat disimpan atau dihapus jika kamu kembali ke Beranda",
      ),
      actions: [
        TextButton(
          onPressed: () {
            RouteWrapper.removeAllAndPush(context, child: const HomeWrapperPage());
          },
          child: Text(
            "Hapus",
            style: AppTheme.text.subtitle.copyWith(
              color: AppTheme.colors.error
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ancestorContext.read<InvoiceBloc>().add(InvoiceEventCreate(invoice: invoice));
          },
          child: Text(
            "Simpan",
            style: AppTheme.text.subtitle.copyWith(
              color: AppTheme.colors.tertiary,
            ),
          ),
        ),
      ],
    );
  }
}
