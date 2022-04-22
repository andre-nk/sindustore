part of "../screens.dart";

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<SliverCubit>(
          create: (context) => SliverCubit(),
          child: BlocBuilder<SliverCubit, bool>(
            builder: (context, state) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  if (notification.context != null &&
                      notification.context!.widget is RawGestureDetector) {
                    if ((notification.context!.widget as RawGestureDetector)
                            .gestures
                            .entries
                            .first
                            .value
                        is! GestureRecognizerFactoryWithHandlers<
                            HorizontalDragGestureRecognizer>) {
                      context.read<SliverCubit>().scroll(notification.direction);
                    }
                  }

                  return true;
                },
                child: CustomScrollView(
                  slivers: [
                    ProductSliverAppBar(state: state),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ListTile(title: Text('Item #$index')),
                        childCount: 1000,
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
