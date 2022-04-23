part of "../screens.dart";

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const ProductFAB(),
      body: SafeArea(
        child: BlocProvider<SliverCubit>(
          create: (context) => SliverCubit(),
          child: BlocBuilder<SliverCubit, SliverState>(
            builder: (context, state) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.context != null &&
                      notification.context!.widget is RawGestureDetector) {
                    final scrollGestures =
                        (notification.context!.widget as RawGestureDetector)
                            .gestures
                            .entries;
                    if (scrollGestures.isNotEmpty &&
                        scrollGestures.first.value
                            is GestureRecognizerFactoryWithHandlers<
                                VerticalDragGestureRecognizer>) {
                      context.read<SliverCubit>().verticalScroll(notification.direction);
                    } else if (scrollGestures.isNotEmpty &&
                        scrollGestures.first.value
                            is GestureRecognizerFactoryWithHandlers<
                                HorizontalDragGestureRecognizer>) {
                      context.read<SliverCubit>().horizontalScroll(notification.metrics);
                    }
                  }

                  return true;
                },
                child: CustomScrollView(
                  slivers: [
                    const ProductSliverAppBar(),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Container(
                            margin: index == 9
                                ? EdgeInsets.only(bottom: MQuery.height(0.1, context))
                                : EdgeInsets.zero,
                            child: const ProductCard(
                              productTitle: "Rinnai 522-E",
                              productPrice: "Rp320.000",
                              productCoverURL: "",
                            ),
                          );
                        },
                        childCount: 10,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
