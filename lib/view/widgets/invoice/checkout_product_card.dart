part of "../widgets.dart";

class CheckoutProductCard extends StatelessWidget {
  const CheckoutProductCard({Key? key, required this.product}) : super(key: key);

  final Product product;

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
                        product.productName,
                        style: AppTheme.text.title,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Text(
                          NumberFormat.simpleCurrency(locale: 'id_ID', decimalDigits: 0)
                              .format(product.productSellPrice.toInt()),
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
                    BlocConsumer<InvoiceBloc, InvoiceState>(
                      listener: ((context, state) {
                        if (state is InvoiceStateDeactivated) {
                          print("deactivated, routing back...");
                        }
                      }),
                      builder: (context, state) {
                        print(state);

                        if (state is InvoiceStateActivated) {
                          for (var stateProduct in state.invoice.products) {
                            if (stateProduct.productID == product.id) {
                              //? THIS PRODUCT EXISTS IN THE INVOICE
                              return ProductCardQuantity(
                                activatedProduct: stateProduct,
                              );
                            } else {
                              return ProductCardQuantity(
                                activatedProduct: stateProduct,
                              );
                            }
                          }
                        } else if (state is InvoiceStateInitial) {
                          print("Initial");

                          return ProductCardQuantity(
                            deactivatedProduct: product,
                          );
                        } else {
                          return Container(color: Colors.red, width: 50,);
                        }

                        return const SizedBox();
                      },
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
