part of '../widgets.dart';

class ProductDiscountModal extends StatelessWidget {
  const ProductDiscountModal({Key? key, required this.productID}) : super(key: key);

  final String productID;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: BlocProvider(
        create: (context) => DiscountBloc(DiscountRepository()),
        child: Container(
          height: MQuery.height(0.31, context),
          width: MQuery.width(0.95, context),
          padding: EdgeInsets.all(MQuery.height(0.025, context)),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppTheme.colors.background,
          ),
          child: BlocConsumer<DiscountBloc, DiscountState>(
            listener: (_, state) {
              if (state is DiscountStateCreated) {
                Navigator.of(context).pop();
              }
            },
            builder: (context, state) {
              if (state is DiscountStateFormChanged) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Buat pilihan diskon baru:",
                      style: AppTheme.text.title.copyWith(fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 24.0),
                      child: TextField(
                        onChanged: (value) {
                          context.read<DiscountBloc>().add(DiscountEventFormChange(
                              discountName: value, amount: state.amount));
                        },
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
                            label: const Text("Nama diskon")),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          if (value.isNotEmpty &&
                              double.parse(
                                      value.replaceAll('.', '').replaceAll('-', '')) >=
                                  0) {
                            context.read<DiscountBloc>().add(
                                  DiscountEventFormChange(
                                    amount: double.parse(
                                        value.replaceAll('.', '').replaceAll('-', '')),
                                    discountName: state.discountName,
                                  ),
                                );
                          }
                        },
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
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 14,
                              horizontal: 16,
                            ),
                            hintText: "Jumlah pengurangan harga",
                            hintStyle: AppTheme.text.subtitle.copyWith(
                              color: AppTheme.colors.outline,
                            ),
                            label: const Text("Jumlah pengurangan harga")),
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
                              if (state.discountName.isNotEmpty) {
                                print(state.discountName + " " + state.amount.toString());
                                context.read<DiscountBloc>().add(
                                      DiscountEventCreate(
                                        productID: productID,
                                        discountName: state.discountName,
                                        amount: state.amount,
                                      ),
                                    );
                              } else {
                                print("can't");
                              }
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              } else if (state is DiscountStateFailed) {
                return const SizedBox();
              } else {
                return const LoadingIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
