part of "../screens.dart";

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Rinnai 522-E",
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
                                      Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: AppTheme.colors.surface,
                                                borderRadius:
                                                    BorderRadius.circular(12.0)),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(top: 12.0),
                                            width: 100,
                                            child: ElevatedButton(
                                              onPressed: () {},
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
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Divider(height: 2, color: AppTheme.colors.outline),
                              ],
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
