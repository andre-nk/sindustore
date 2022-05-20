part of "../screens.dart";

class ProductEditorPage extends StatefulWidget {
  const ProductEditorPage({Key? key, this.existingProduct}) : super(key: key);

  final Product? existingProduct;

  @override
  State<ProductEditorPage> createState() => _ProductEditorPageState();
}

class _ProductEditorPageState extends State<ProductEditorPage> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController productBuyPriceController = TextEditingController();
  TextEditingController productSellPriceController = TextEditingController();
  TextEditingController productNewDiscountNameController = TextEditingController();
  TextEditingController productNewDiscountAmountController = TextEditingController();
  List<TextEditingController> tags = [];
  List<ProductDiscount> productDiscounts = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingProduct != null) {
      productNameController = TextEditingController.fromValue(
        TextEditingValue(text: widget.existingProduct!.productName),
      );
      productBuyPriceController = TextEditingController.fromValue(
        TextEditingValue(text: widget.existingProduct!.productBuyPrice.toString()),
      );
      productSellPriceController = TextEditingController.fromValue(
        TextEditingValue(text: widget.existingProduct!.productSellPrice.toString()),
      );
      tags = widget.existingProduct!.tags
          .map((e) => TextEditingController.fromValue(
                TextEditingValue(text: e),
              ))
          .toList();
      productDiscounts = widget.existingProduct!.productDiscounts;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductRepository()),
      child: Scaffold(
        appBar: GeneralAppBar(
            title: "Buat produk baru",
            singleAction: widget.existingProduct != null
                ? Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    child: BlocBuilder<ProductBloc, ProductState>(
                      builder: (context, state) {
                        return IconButton(
                          icon: Icon(
                            Ionicons.trash_bin_outline,
                            color: AppTheme.colors.error,
                            size: 22,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (innerContext) {
                                return AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12.0),
                                    ),
                                  ),
                                  contentPadding:
                                      const EdgeInsets.all(24.0).copyWith(right: 32.0),
                                  title: const Text("Hapus produk ini?"),
                                  content: const Text(
                                    "Hati-hati, data produk ini tidak dapat dikembalikan setelah terhapus!",
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        context.read<ProductBloc>().add(
                                            ProductEventDelete(
                                                widget.existingProduct!.id));
                                        Navigator.pop(innerContext);
                                      },
                                      child: Text(
                                        "Hapus",
                                        style: AppTheme.text.subtitle.copyWith(
                                          color: AppTheme.colors.error,
                                        ),
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
                              },
                            );
                          },
                        );
                      },
                    ),
                  )
                : const SizedBox()),
        body: ListView(
          padding: const EdgeInsets.all(24.0).copyWith(top: 12.0),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Nama produk",
                    style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextField(
                    controller: productNameController,
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          width: 1,
                          style: BorderStyle.solid,
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 16,
                      ),
                      hintText: "contoh: Rinnai 522-E",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Harga Beli:",
                      style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextField(
                      controller: productBuyPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Rp",
                            style: AppTheme.text.subtitle,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints.tight(const Size(48, 22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: AppTheme.colors.primary,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        hintText: "contoh: 250000",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Harga Jual:",
                      style: AppTheme.text.subtitle.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: TextField(
                      controller: productSellPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        isDense: true,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            "Rp",
                            style: AppTheme.text.subtitle,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints.tight(const Size(48, 22)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: AppTheme.colors.primary,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                        hintText: "contoh: 300000",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tags:",
                          style: AppTheme.text.subtitle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              tags.add(TextEditingController());
                            });
                          },
                          splashRadius: 20.0,
                          icon: const Icon(Ionicons.add_circle_outline),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    height: MQuery.height(0.075 * tags.length, context),
                    child: ListView.builder(
                      itemCount: tags.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: index != 0
                              ? const EdgeInsets.only(top: 12.0)
                              : const EdgeInsets.all(0.0),
                          child: TextField(
                            controller: tags[index],
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    tags.removeLast();
                                  });
                                },
                                splashRadius: 20.0,
                                icon: Icon(
                                  Ionicons.close_circle_outline,
                                  color: AppTheme.colors.error,
                                ),
                              ),
                              suffixIconConstraints:
                                  BoxConstraints.tight(const Size(36, 48)),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.colors.primary),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppTheme.colors.primary),
                              ),
                              hintText: "contoh: Kompor",
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Diskon Produk:",
                          style: AppTheme.text.subtitle.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                productNewDiscountNameController.clear();
                                productNewDiscountAmountController.clear();

                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    height: MQuery.height(0.31, context),
                                    width: MQuery.width(0.95, context),
                                    padding:
                                        EdgeInsets.all(MQuery.height(0.025, context)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(20)),
                                      color: AppTheme.colors.background,
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Buat pilihan diskon baru:",
                                          style: AppTheme.text.title
                                              .copyWith(fontWeight: FontWeight.w500),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 24.0),
                                          child: TextField(
                                            controller: productNewDiscountNameController,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(12),
                                                borderSide: BorderSide(
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                  color: AppTheme.colors.primary,
                                                ),
                                              ),
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding: const EdgeInsets.symmetric(
                                                vertical: 14,
                                                horizontal: 16,
                                              ),
                                              hintText: "Nama diskon...",
                                              hintStyle: AppTheme.text.subtitle.copyWith(
                                                color: AppTheme.colors.outline,
                                              ),
                                              label: const Text("Nama diskon"),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 16.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller:
                                                productNewDiscountAmountController,
                                            decoration: InputDecoration(
                                                isDense: true,
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(12),
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    style: BorderStyle.solid,
                                                    color: AppTheme.colors.primary,
                                                  ),
                                                ),
                                                prefixText: "-Rp ",
                                                prefixStyle: AppTheme.text.subtitle,
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 14,
                                                  horizontal: 16,
                                                ),
                                                hintText: "Jumlah pengurangan harga",
                                                hintStyle:
                                                    AppTheme.text.subtitle.copyWith(
                                                  color: AppTheme.colors.outline,
                                                ),
                                                label: const Text(
                                                    "Jumlah pengurangan harga")),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.only(top: 24),
                                              width: 116,
                                              height: 68,
                                              child: WideButton(
                                                title: "Tambah",
                                                onPressed: () {
                                                  String discountAmount =
                                                      productNewDiscountAmountController
                                                          .text;

                                                  if (discountAmount.isNotEmpty &&
                                                      double.parse(discountAmount
                                                              .replaceAll('.', '')
                                                              .replaceAll('-', '')) >=
                                                          0) {
                                                    setState(() {
                                                      productDiscounts
                                                          .add(ProductDiscount(
                                                        id: const Uuid().v4(),
                                                        amount: double.parse(
                                                            discountAmount
                                                                .replaceAll('.', '')
                                                                .replaceAll('-', '')),
                                                        discountName:
                                                            productNewDiscountNameController
                                                                .text,
                                                      ));
                                                    });

                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          splashRadius: 20.0,
                          icon: const Icon(Ionicons.add_circle_outline),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(right: 0.0, left: 8.0),
                    height: MQuery.height(0.075 * productDiscounts.length, context),
                    child: ListView.builder(
                      itemCount: productDiscounts.length,
                      itemBuilder: (context, index) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              productDiscounts[index].discountName,
                              style: AppTheme.text.footnote
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    NumberFormat.simpleCurrency(
                                      locale: 'id_ID',
                                      decimalDigits: 0,
                                    ).format(productDiscounts[index].amount),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      productDiscounts.removeLast();
                                    });
                                  },
                                  splashRadius: 20.0,
                                  icon: Icon(
                                    Ionicons.close_circle_outline,
                                    color: AppTheme.colors.error,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateSuccess) {
                    Navigator.pop(context);
                  } else if (state is ProductStateFetching) {
                    print(state.exception);
                  }
                },
                builder: (context, state) {
                  return WideButton(
                    onPressed: () {
                      if (productNameController.text.isEmpty) {
                        print("todo: snackbar title");
                      } else if (productBuyPriceController.text.isEmpty ||
                          double.parse(productBuyPriceController.text
                                  .replaceAll('.', '')
                                  .replaceAll('-', '')) <=
                              0) {
                        print("todo: snackbar buy");
                      } else if (productSellPriceController.text.isEmpty ||
                          double.parse(productSellPriceController.text
                                  .replaceAll('.', '')
                                  .replaceAll('-', '')) <=
                              0) {
                        print("todo: snackbar sell");
                      } else {
                        if (widget.existingProduct != null) {
                          context.read<ProductBloc>().add(
                                ProductEventUpdate(
                                  existingProductID: widget.existingProduct!.id,
                                  productName: productNameController.text,
                                  productBuyPrice:
                                      double.parse(productBuyPriceController.text),
                                  productSellPrice:
                                      double.parse(productSellPriceController.text),
                                  tags: tags.map((e) => e.text).toList(),
                                  productDiscounts: productDiscounts,
                                ),
                              );
                        } else {
                          context.read<ProductBloc>().add(
                                ProductEventCreate(
                                  productName: productNameController.text,
                                  productBuyPrice:
                                      double.parse(productBuyPriceController.text),
                                  productSellPrice:
                                      double.parse(productSellPriceController.text),
                                  tags: tags.map((e) => e.text).toList(),
                                  productDiscounts: productDiscounts,
                                ),
                              );
                        }
                      }
                    },
                    title: "Simpan produk",
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
