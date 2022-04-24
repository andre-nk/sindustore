part of "../widgets.dart";

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Yth. (opsional)",
                style: AppTheme.text.footnote,
              ),
              TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                  hintText: "Nama konsumen (contoh: Sutrisno)",
                  hintStyle:
                      AppTheme.text.subtitle.copyWith(color: AppTheme.colors.outline),
                ),
              ),
            ],
          ),
          Divider(thickness: 1.25, height: 8, color: AppTheme.colors.outline),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dirilis pada",
                  style: AppTheme.text.footnote,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    "24 April 2022, 12:55",
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
