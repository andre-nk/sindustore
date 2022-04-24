part of "../widgets.dart";

class CheckoutProductCard extends StatelessWidget {
  const CheckoutProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rinnai 52",
                        style: AppTheme.text.title,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          "Rp320.000",
                          style: AppTheme.text.subtitle,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: AppTheme.colors.surface,
                        borderRadius: BorderRadius.circular(12.0)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppTheme.colors.outline),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: const Text("Pilihan diskon (2)"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 0,
                            fillColor: AppTheme.colors.primary,
                            child: Icon(
                              Ionicons.remove_outline,
                              size: 16.0,
                              color: AppTheme.colors.secondary,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            shape: const CircleBorder(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Text(
                            "1",
                            style: AppTheme.text.subtitle,
                          ),
                        ),
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: RawMaterialButton(
                            onPressed: () {},
                            elevation: 0,
                            fillColor: AppTheme.colors.primary,
                            child: Icon(
                              Ionicons.add_outline,
                              size: 16.0,
                              color: AppTheme.colors.secondary,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            shape: const CircleBorder(),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Divider(height: 2, color: AppTheme.colors.outline),
        ),
      ],
    );
  }
}
