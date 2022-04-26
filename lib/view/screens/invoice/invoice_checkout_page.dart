part of "../screens.dart";

class InvoiceCheckoutPage extends StatelessWidget {
  const InvoiceCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GeneralAppBar(title: "Nota 001"),
      body: SafeArea(
        child: Stack(
          children: [
            Expanded(
              flex: 1,
              child: ListView(
                children: [
                  const CheckoutHeader(),
                  Container(
                    margin: EdgeInsets.only(
                      top: MQuery.height(0.025, context),
                      bottom: MQuery.height(0.015, context),
                    ),
                    height: 12,
                    color: AppTheme.colors.surface,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Produk (0)",
                              style: AppTheme.text.paragraph.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(), elevation: 0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text(
                                  "Tambah",
                                  style: AppTheme.text.footnote.copyWith(
                                    color: AppTheme.colors.secondary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: MQuery.height(0.25, context)),
                          child: Column(children: const []),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            const Positioned(
              child: CheckoutSheet(),
              bottom: 0,
            ),
          ],
        ),
      ),
    );
  }
}
