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
          height: MQuery.height(0.3, context),
          width: MQuery.width(0.9, context),
          padding: EdgeInsets.all(MQuery.height(0.025, context)),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: AppTheme.colors.background,
          ),
          child: BlocBuilder<DiscountBloc, DiscountState>(
            builder: (context, state) {
              if (state is DiscountStateFetching) {
                return const LoadingIndicator();
              } else if (state is DiscountStateLoaded) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Text("Pilihan diskon (${state.productDiscounts.length}):"),
                      ],
                    )
                  ],
                );
              } else {
                print(state);
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
