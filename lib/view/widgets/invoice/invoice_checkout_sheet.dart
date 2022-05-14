part of "../widgets.dart";

class InvoiceCheckoutSheet extends StatelessWidget {
  const InvoiceCheckoutSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MQuery.width(1, context),
      height: MQuery.height(0.215, context),
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
              Container(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                decoration: BoxDecoration(
                  color: AppTheme.colors.tertiary,
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                ),
                child: Text(
                  "Pending",
                  style: AppTheme.text.footnote
                      .copyWith(color: Colors.white, fontWeight: FontWeight.w400),
                ),
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
                Text(
                  "Rp0",
                  style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
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
