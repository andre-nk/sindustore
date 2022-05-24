part of "../widgets.dart";

class ProductCardQuantity extends StatelessWidget {
  const ProductCardQuantity({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocBuilder<InvoiceBloc, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceStateActivated) {
            List<InvoiceItem> containedProducts = state.invoice.products
                .deepSearchByValue<InvoiceItem>((item) => item.productID == product.id)
                .cast<InvoiceItem>();

            //INVOICE CONTAINS X PRODUCT
            if (containedProducts.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Row(
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
                                  productID: containedProducts.first.productID,
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
                      child: AutoSizeText(
                        containedProducts.first.quantity.toString(),
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
                                  productID: containedProducts.first.productID,
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
                ),
              );

              //INVOICE DOESN'T CONTAINS X PRODUCT OR INVOICE MIGHT BE EMPTY (NO SEARCH RESULT AS WELL)
            } else if (containedProducts.isEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<InvoiceBloc>().add(
                              InvoiceEventAddItem(
                                invoice: state.invoice,
                                productID: product.id,
                              ),
                            );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: AppTheme.colors.primary,
                        shape: const StadiumBorder(),
                        elevation: 0,
                      ),
                      child: Center(
                        child: AutoSizeText(
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

              //ELSE (UNEXPECTED OUTCOME)
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

class ProductCardQuantityLarge extends StatelessWidget {
  const ProductCardQuantityLarge({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InvoiceBloc, InvoiceState>(
      builder: (context, state) {
        if (state is InvoiceStateActivated) {
          List<InvoiceItem> containedProducts = state.invoice.products
              .deepSearchByValue<InvoiceItem>((item) => item.productID == product.id)
              .cast<InvoiceItem>();

          //INVOICE CONTAINS X PRODUCT
          if (containedProducts.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: RawMaterialButton(
                      onPressed: () {
                        context.read<InvoiceBloc>().add(
                              InvoiceEventRemoveItem(
                                invoice: state.invoice,
                                productID: containedProducts.first.productID,
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
                    child: AutoSizeText(
                      containedProducts.first.quantity.toString(),
                      style: AppTheme.text.title,
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: RawMaterialButton(
                      onPressed: () {
                        context.read<InvoiceBloc>().add(
                              InvoiceEventAddItem(
                                invoice: state.invoice,
                                productID: containedProducts.first.productID,
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
              ),
            );

            //INVOICE DOESN'T CONTAINS X PRODUCT OR INVOICE MIGHT BE EMPTY (NO SEARCH RESULT AS WELL)
          } else if (containedProducts.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MQuery.width(0.875, context),
                  height: 52,
                  child: WideButton(
                    title: "Tambah",
                    onPressed: () {
                      context.read<InvoiceBloc>().add(
                            InvoiceEventAddItem(
                              invoice: state.invoice,
                              productID: product.id,
                            ),
                          );
                    },
                  ),
                )
              ],
            );

            //ELSE (UNEXPECTED OUTCOME)
          } else {
            return const SizedBox();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
