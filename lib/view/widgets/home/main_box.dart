part of "../widgets.dart";

class MainBox extends StatefulWidget {
  const MainBox({Key? key}) : super(key: key);

  @override
  State<MainBox> createState() => _MainBoxState();
}

class _MainBoxState extends State<MainBox> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppTheme.colors.background,
        border: Border.all(color: AppTheme.colors.outline, width: 1.25),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4.0,
              left: 3,
              right: 4,
            ),
            child: BlocProvider(
              create: (context) => ProductBloc(ProductRepository()),
              child: BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductStateQueryLoaded) {
                    RouteWrapper.push(
                      context,
                      child: InvoiceProductListPage(
                        dashboardQuery: state.query,
                        dashboardSearchQuery: _searchController.text
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return TextField(
                    onSubmitted: (value) {
                      context.read<ProductBloc>().add(
                            ProductEventSearchActive(searchQuery: value),
                          );
                    },
                    controller: _searchController,
                    decoration: InputDecoration(
                      prefixIcon: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Icon(
                          Ionicons.search,
                          size: 20,
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _searchController.clear();
                          });
                        },
                        icon: Icon(
                          Ionicons.close_circle_outline,
                          size: 20,
                          color: AppTheme.colors.primary,
                        ),
                      ),
                      border: InputBorder.none,
                      hintText: "Cari produk di toko...",
                      hintStyle: AppTheme.text.subtitle.copyWith(
                        color: AppTheme.colors.outline,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 1,
            width: double.infinity,
            color: AppTheme.colors.outline.withOpacity(0.25),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Opacity(
                      opacity: state is AuthStateLoggedIn &&
                              state.user.role != UserRoles.worker
                          ? 1.0
                          : 0.5,
                      child: TextButton(
                        onPressed: () {
                          if (state is AuthStateLoggedIn &&
                              state.user.role != UserRoles.worker) {
                            RouteWrapper.push(context, child: const ArchivePage());
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Icon(Ionicons.file_tray_outline, size: 26),
                            ),
                            AutoSizeText("Arsip"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                TextButton(
                  onPressed: () {
                    RouteWrapper.push(context, child: const InvoiceProductListPage());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.0),
                        child: Icon(Ionicons.receipt_outline, size: 24),
                      ),
                      AutoSizeText("Buat Nota"),
                    ],
                  ),
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Opacity(
                      opacity: state is AuthStateLoggedIn &&
                              state.user.role != UserRoles.worker
                          ? 1.0
                          : 0.5,
                      child: TextButton(
                        onPressed: () {
                          RouteWrapper.push(context, child: const InvoiceListPage());
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Icon(Ionicons.time_outline, size: 24),
                            ),
                            AutoSizeText("Riwayat"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Opacity(
                  opacity: 0.4,
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Icon(Ionicons.information_circle_outline, size: 24),
                        ),
                        AutoSizeText("Informasi"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
