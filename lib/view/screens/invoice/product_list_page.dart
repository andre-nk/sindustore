part of "../screens.dart";

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InvoiceBloc>(create: (context) => InvoiceBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc(AuthRepository())),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(ProductRepository())
            ..add(
              ProductEventFetchQuery(),
            ),
        ),
      ],
      child: Scaffold(
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
                        context
                            .read<SliverCubit>()
                            .verticalScroll(notification.direction);
                      } else if (scrollGestures.isNotEmpty &&
                          scrollGestures.first.value
                              is GestureRecognizerFactoryWithHandlers<
                                  HorizontalDragGestureRecognizer>) {
                        context
                            .read<SliverCubit>()
                            .horizontalScroll(notification.metrics);
                      }
                    }

                    return true;
                  },
                  child: BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is ProductStateCreated) {
                        context.read<ProductBloc>().add(ProductEventFetchQuery());
                      } else if (state.exception != null) {
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                            SnackBar(
                              backgroundColor: AppTheme.colors.error,
                              content: Text(
                                state.exception.toString(),
                                style:
                                    AppTheme.text.subtitle.copyWith(color: Colors.white),
                              ),
                            ),
                          );
                      }
                    },
                    builder: (context, state) {
                      if (state is ProductStateFetching) {
                        return const LoadingIndicator();
                      } else if (state is ProductStateQueryLoaded) {
                        return FirestoreQueryBuilder(
                          pageSize: 10,
                          query: state.query,
                          builder: (context, snapshot, _) {
                            return CustomScrollView(
                              slivers: [
                                const ProductSliverAppBar(),
                                ProductSliverList(snapshot: snapshot)
                              ],
                            );
                          },
                        );
                      } else if (state is ProductStateQueryLoaded) {
                        return FirestoreQueryBuilder(
                          pageSize: 10,
                          query: state.query,
                          builder: (context, snapshot, _) {
                            return CustomScrollView(
                              slivers: [
                                const ProductSliverAppBar(),
                                ProductSliverList(snapshot: snapshot)
                              ],
                            );
                          },
                        );
                      } else {
                        return const LoadingIndicator();
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
