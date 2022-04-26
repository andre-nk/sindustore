part of "../widgets.dart";

class ProductCardQuantity extends StatelessWidget {
  const ProductCardQuantity({
    Key? key,
    this.activatedProduct,
    this.deactivatedProduct,
  }) : super(key: key);

  final InvoiceItem? activatedProduct;
  final Product? deactivatedProduct;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        print(state.toString() + " " + activatedProduct.toString());

        if (state is InvoiceStateActivated && activatedProduct != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: RawMaterialButton(
                  onPressed: () {
                    context.read<InvoiceBloc>().add(
                          InvoiceEventRemoveItem(
                            invoice: state.invoice,
                            productID: activatedProduct!.productID,
                          ),
                        );
                  },
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
                  activatedProduct!.quantity.toString(),
                  style: AppTheme.text.subtitle,
                ),
              ),
              SizedBox(
                width: 24,
                height: 24,
                child: RawMaterialButton(
                  onPressed: () {
                    context.read<InvoiceBloc>().add(
                          InvoiceEventAddItem(
                            invoice: state.invoice,
                            productID: activatedProduct!.productID,
                          ),
                        );
                  },
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
          );
        } else if (state is InvoiceStateActivated && activatedProduct != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 12.0),
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<InvoiceBloc>().add(
                          InvoiceEventAddItem(
                            invoice: state.invoice,
                            productID: activatedProduct!.productID,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.colors.primary,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Center(
                    child: Text(
                      "Tambah",
                      style: AppTheme.text.footnote.copyWith(
                        color: AppTheme.colors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else if (state is InvoiceStateInitial && deactivatedProduct != null) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 12.0),
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    print("Activation");

                    context.read<InvoiceBloc>().add(
                          InvoiceEventActivate(
                            adminHandlerUID: "", //TODO: CALL ADMIN HANDLER UID,
                            initialProductID: deactivatedProduct!.id,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppTheme.colors.primary,
                    shape: const StadiumBorder(),
                    elevation: 0,
                  ),
                  child: Center(
                    child: Text(
                      "Tambah",
                      style: AppTheme.text.footnote.copyWith(
                        color: AppTheme.colors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
