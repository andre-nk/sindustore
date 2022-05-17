part of "../screens.dart";

class InvoiceProductListPage extends StatelessWidget {
  const InvoiceProductListPage({
    Key? key,
    this.existingInvoice,
    this.existingInvoiceUID,
    this.dashboardSearchQuery,
  }) : super(key: key);

  final Invoice? existingInvoice;
  final String? existingInvoiceUID;
  final Query? dashboardSearchQuery;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        existingInvoice != null
            ? BlocProvider<InvoiceBloc>(
                create: (context) => InvoiceBloc(InvoiceRepository())
                  ..add(InvoiceEventRead(invoice: existingInvoice!)),
              )
            : BlocProvider<InvoiceBloc>(
                create: (context) =>
                    InvoiceBloc(InvoiceRepository())..add(const InvoiceEventActivate()),
              ),
        BlocProvider<ProductBloc>(
          create: (context) =>
              ProductBloc(ProductRepository())..add(const ProductEventFetchQuery()),
        ),
      ],
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: InvoiceProductListFAB(
          existingInvoice: existingInvoice,
          existingInvoiceUID: existingInvoiceUID,
        ),
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
                        context.read<ProductBloc>().add(const ProductEventFetchQuery());
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
                      if (state is ProductStateQueryLoaded) {
                        return FirestoreQueryBuilder(
                          pageSize: 10,
                          query: dashboardSearchQuery ?? state.query,
                          builder: (context, snapshot, _) {
                            return CustomScrollView(
                              slivers: [
                                InvoiceProductListAppBar(
                                  existingInvoice: existingInvoice,
                                  existingInvoiceUID: existingInvoiceUID,
                                ),
                                InvoiceProductSliverList(snapshot: snapshot)
                              ],
                            );
                          },
                        );
                      } else {
                        return const CustomLoadingIndicator();
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
